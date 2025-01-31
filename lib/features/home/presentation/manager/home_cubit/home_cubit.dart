import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/features/home/data/repos/home_repo.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_states.dart';
import 'package:smart_cart_app/features/home/presentation/views/cart_view.dart';
import 'package:smart_cart_app/features/home/presentation/views/map_view.dart';
import 'package:smart_cart_app/features/home/presentation/views/offers_view.dart';
import 'package:smart_cart_app/features/home/presentation/views/profile_view.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  HomeRepo homeRepo;
  String cartId = "";
  int currentIndex = 0;
  late IO.Socket socket;

  initSocket() {
    socket = IO.io("http://192.168.110.1:3000", <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.onConnect((_) {
      print("Connection established");
      getScannedProducts();
    });
    socket.onDisconnect((_) => print("connection Disconnection"));
    socket.onConnectError((err) => print("Socket could not connect :" + err));
    socket.onError((err) => print("Socket could not connect :" + err));
  }

  removeProduct() {
    socket.emit("cartUpdated");
  }

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: "Cart",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.redeem_rounded),
      label: "Offers",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.map),
      label: "Map",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Profile",
    ),
  ];
  List<Widget> screens = [
    const CartView(),
    const OffersView(),
    const MapView(),
    const ProfileView()
  ];

  void changeBottomNav(int index) {
    if (!isClosed) {
      // Check if Cubit is still active before emitting
      currentIndex = index;
      emit(HomeChangeBottomNavState());
    }
  }

  Future<void> connectUserToCart(String cartID) async {
    emit(HomeAddUserToCartLoading());
    var result =
        await homeRepo.addUserToCart(cartID: cartID, userID: "AzouzUser");
    result.fold((failure) {
      emit(HomeAddUserToCartFailure());
    }, (responseCode) {
      emit(HomeAddUserToCartSuccess());
      cartId = cartID;
    });
  }

  Future<void> getScannedProducts() async {
    emit(HomeGetScannedProductsLoading());

    homeRepo.getScannedProducts().listen(
      (result) {
        result.fold(
          (failure) => emit(HomeGetScannedProductsFailure()),
          (products) => emit(HomeGetScannedProductsSuccess(products)),
        );
      },
      onError: (error) {
        emit(HomeGetScannedProductsFailure());
      },
    );
  }

  // Future<void> getScannedProducts() async {
  //   emit(HomeGetScannedProductsLoading());
  //   var result = await homeRepo.getScannedProducts();
  //   result.fold((failure) {
  //     emit(HomeGetScannedProductsFailure());
  //   }, (products) {
  //     emit(HomeGetScannedProductsSuccess(products));
  //   });
  // }

  Future<void> getCartProducts(String cartID) async {
    emit(HomeGetCartProductsLoading());
    var result = await homeRepo.getCartProducts(cartID: cartID);
    result.fold((failure) {
      emit(HomeGetCartProductsFailure());
    }, (products) {
      emit(HomeGetCartProductsSuccess(products));
    });
  }
}

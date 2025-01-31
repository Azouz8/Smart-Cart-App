import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/features/home/data/models/cart_product_model/cart_product_model.dart';
import 'package:smart_cart_app/features/home/data/repos/home_repo.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_states.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  HomeRepo homeRepo;
  String cartId = "";
  late IO.Socket socket;
  List<CartProductModel> cartProducts = [];

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

  @override
  Future<void> close() {
    if (socket.connected) {
      socket.disconnect();
      socket.dispose();
      print("Socket disconnected and disposed.");
    }
    return super.close();
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
          (products) {
            cartProducts = products;
            emit(HomeGetScannedProductsSuccess(products));
          },
        );
      },
      onError: (error) {
        emit(HomeGetScannedProductsFailure());
      },
    );
  }

  Future<void> getCartProducts(String cartID) async {
    emit(HomeGetCartProductsLoading());
    var result = await homeRepo.getCartProducts(cartID: cartID);
    result.fold((failure) {
      emit(HomeGetCartProductsFailure());
    }, (products) {
      cartProducts = products;
      emit(HomeGetCartProductsSuccess(products));
    });
  }

  Future<void> deleteProductFromCart({required String cartID, required String productID}) async {
    emit(HomeDeleteProductLoading());
    var result = await homeRepo.deleteProductFromCart(
        cartID: cartID, productID: productID);
    result.fold((failure) {
      emit(HomeDeleteProductFailure());
    }, (responseCode) {
      emit(HomeDeleteProductSuccess());
    });
  }
}

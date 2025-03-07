import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/core/networking/api/api_consts.dart';
import 'package:smart_cart_app/core/services/cache_helper.dart';
import 'package:smart_cart_app/features/home/data/models/cart_product_model/cart_product_model.dart';
import 'package:smart_cart_app/features/home/data/repos/home_repo.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_states.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this.homeRepo) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  HomeRepo homeRepo;
  String cartId = "";
  String orderSubtotal = "";
  String totalPrice = "";
  String totalDiscount = "";
  late IO.Socket socket;
  List<CartProductModel> cartProducts = [];

  initSocket() {
    socket = IO.io(ApiConsts.socketIOUrl, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.onConnect((_) {
      print("Connection established");
      // emit(HomeSocketConnectedState());
      getScannedProducts();
    });
    socket.onDisconnect((_) => print("connection Disconnection"));
    socket.onConnectError((err) => print("Socket could not connect :$err"));
    socket.onError((err) => print("Socket could not connect :$err"));
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

  Future<void> connectUserToCart(String cartID, String userID) async {
    emit(HomeAddUserToCartLoading());
    var result = await homeRepo.addUserToCart(cartID: cartID, userID: userID);
    result.fold((failure) {
      emit(HomeAddUserToCartFailure(failure));
    }, (responseCode) {
      cartId = cartID;
      CacheHelper.putString(key: CacheHelperKeys.cartID, value: cartID);
      emit(HomeAddUserToCartSuccess());
    });
  }

  Future<void> removeUserFromCart(String cartID, String userID) async {
    emit(HomeRemoveUserFromCartLoading());
    var result =
        await homeRepo.removeUserFromCart(cartID: cartID, userID: userID);
    result.fold((failure) {
      emit(HomeRemoveUserFromCartFailure(failure));
    }, (responseCode) {
      CacheHelper.remove(key: CacheHelperKeys.cartID);
      emit(HomeRemoveUserFromCartSuccess());
      cartId = "";
      // cartProducts.clear();
    });
  }

  void getTotalPrice() {
    int total = 0;
    for (var product in cartProducts) {
      total += product.productID!.price!.ceil() * product.quantity!;
    }
    orderSubtotal = total.ceil().toString();
    int discount = getTotalDiscount();
    totalPrice = (total - discount).toString();
  }

  int getTotalDiscount() {
    int discount = 0;
    for (var product in cartProducts) {
      discount += product.productID!.discount!; // Assuming `price` is a double
    }
    totalDiscount = discount.ceil().toString();
    return discount;
  }

  Future<void> getScannedProducts() async {
    homeRepo.getScannedProducts().listen(
      (result) {
        result.fold(
          (failure) => emit(HomeGetScannedProductsFailure(failure)),
          (products) {
            cartProducts = products;
            emit(HomeGetScannedProductsSuccess(products));
          },
        );
      },
      onError: (error) {
        emit(HomeGetScannedProductsFailure(error.toString()));
      },
    );
  }

  Future<void> getCartProducts(String cartID) async {
    emit(HomeGetCartProductsLoading());
    var result = await homeRepo.getCartProducts(cartID: cartID);
    result.fold((failure) {
      emit(HomeGetCartProductsFailure(failure));
    }, (products) {
      cartProducts = products;
      cartId = cartID;
      emit(HomeGetCartProductsSuccess(products));
    });
  }

  Future<void> deleteProductFromCart(
      {required String cartID, required String productID}) async {
    var result = await homeRepo.deleteProductFromCart(
      cartID: cartID,
      productID: productID,
    );
    result.fold((failure) {
      emit(HomeDeleteProductFailure(failure));
    }, (responseCode) {
      emit(HomeDeleteProductSuccess());
    });
  }
}

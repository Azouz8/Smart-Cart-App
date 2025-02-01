import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:smart_cart_app/core/networking/api_error_handler.dart';
import 'package:smart_cart_app/core/networking/api_service.dart';
import 'package:smart_cart_app/features/home/data/models/cart_product_model/cart_product_model.dart';
import 'package:smart_cart_app/features/home/data/repos/home_repo.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeRepoImpl extends HomeRepo {
  final ApiService apiService;
  final IO.Socket socket;
 HomeRepoImpl(this.apiService, this.socket) {
    _setupSocketListeners();
  }

  @override
  Future<Either<Failures, int>> addUserToCart({
    required String cartID,
    required String userID,
  }) async {
    try {
      var resposeCode =
          await apiService.addUserToCart(cartID: cartID, userID: userID);
      return Right(resposeCode!);
    } on Exception {
      return Left(ServerFailure());
    }
  }
 final StreamController<Either<Failures, List<CartProductModel>>> _streamController =
      StreamController.broadcast();

  void _setupSocketListeners() {
    socket.on("cartUpdated", (data) {
      try {
        List<CartProductModel> updatedProducts = data
            .map<CartProductModel>((item) => CartProductModel.fromJson(item))
            .toList();

        _streamController.add(Right(updatedProducts));
      } catch (e) {
        print("Error parsing product: $e");
        _streamController.add(Left(ServerFailure()));
      }
    });

    socket.onError((error) {
      print("Socket error: $error");
      _streamController.add(Left(ServerFailure()));
    });
  }
  @override
  Stream<Either<Failures, List<CartProductModel>>> getScannedProducts() {
    return _streamController.stream;
  }

  @override
  Future<Either<Failures, List<CartProductModel>>> getCartProducts(
      {required String cartID}) async {
    try {
      var data = await apiService.getCartProducts(cartID: cartID);
      List<CartProductModel> products = [];
      for (var i in data["results"]) {
        products.add(CartProductModel.fromJson(i));
      }
      return Right(products);
    } on Exception {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failures, int>> deleteProductFromCart({required String productID, required String cartID}) async{
    try {
      var responseCode =await apiService.deleteProduct(productID: productID,cartID: cartID);
      
      return Right(responseCode!);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}

import 'package:either_dart/either.dart';
import 'package:smart_cart_app/features/home/data/models/cart_product_model/cart_product_model.dart';

abstract class HomeRepo {
  Future<Either<String, Map<String, dynamic>>> addUserToCart(
      {required String cartID, required String userID});
  Future<Either<String, Map<String, dynamic>>> removeUserFromCart(
      {required String cartID, required String userID});

  Stream<Either<String, List<CartProductModel>>> getScannedProducts();
  // void disconnectSocket();
  Future<Either<String, List<CartProductModel>>> getCartProducts(
      {required String cartID});

  Future<Either<String, int?>> deleteProductFromCart(
      {required String productID, required String cartID});
}

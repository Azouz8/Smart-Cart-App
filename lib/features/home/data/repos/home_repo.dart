import 'package:either_dart/either.dart';
import 'package:smart_cart_app/core/networking/api_error_handler.dart';
import 'package:smart_cart_app/features/home/data/models/cart_product_model/cart_product_model.dart';

abstract class HomeRepo {
  Future<Either<Failures, int>> addUserToCart(
      {required String cartID, required String userID});

  Future<Either<Failures, List<CartProductModel>>> getCartProducts({required String cartID});
}

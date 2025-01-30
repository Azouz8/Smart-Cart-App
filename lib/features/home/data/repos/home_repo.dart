import 'package:either_dart/either.dart';
import 'package:smart_cart_app/core/networking/api_error_handler.dart';

abstract class HomeRepo {
  Future<Either<Failures, int>> addUserToCart(
      {required String cartID, required String userID});
}

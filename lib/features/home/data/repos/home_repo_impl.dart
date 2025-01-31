import 'package:either_dart/either.dart';
import 'package:smart_cart_app/core/networking/api_error_handler.dart';
import 'package:smart_cart_app/core/networking/api_service.dart';
import 'package:smart_cart_app/features/home/data/models/cart_product_model/cart_product_model.dart';
import 'package:smart_cart_app/features/home/data/repos/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);
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

  @override
  Future<Either<Failures, List<CartProductModel>>> getCartProducts(
      {required String cartID}) async {
    try {
      var data = await apiService.getCartProducts(cartID: cartID);
      List<CartProductModel> products = [];
      for (var i in data["cartProducts"]) {
        products.add(CartProductModel.fromJson(i));
      }
      return Right(products);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}

import 'package:smart_cart_app/core/networking/api/api_consumer.dart';
import 'package:smart_cart_app/core/networking/api/api_consts.dart';

class ApiService {
  final ApiConsumer api;

  ApiService(this.api);

  addUserToCart({required String cartID, required String userID}) async {
    var response = await api.patch(
      '${ApiConsts.apiBaseUrl}${ApiConsts.cart}$cartID/${ApiConsts.addUserToCart}',
      data: {"userID": userID},
    );
    return response;
  }

  removeUserFromCart({required String cartID, required String userID}) async {
    var response = await api.patch(
      '${ApiConsts.apiBaseUrl}${ApiConsts.cart}$cartID/${ApiConsts.removeUserFromCart}',
      data: {"userID": userID},
    );
    return response;
  }

  Future<Map<String, dynamic>> getCartProducts({required String cartID}) async {
    var response = await api.get(
      '${ApiConsts.apiBaseUrl}${ApiConsts.cart}$cartID/${ApiConsts.products}',
    );
    return response;
  }

  deleteProduct({required String productID, required String cartID}) async {
    var response = await api.delete(
      '${ApiConsts.apiBaseUrl}${ApiConsts.cart}$cartID/${ApiConsts.deleteProductFromCart}',
      data: {"productID": productID},
    );
    return response;
  }
}

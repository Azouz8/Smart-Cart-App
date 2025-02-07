import 'package:smart_cart_app/core/networking/api/api_consumer.dart';
import 'package:smart_cart_app/core/networking/api/api_consts.dart';

class ApiService {
  final ApiConsumer api;

  ApiService(this.api);

  signUp(
      {required String name,
      required String email,
      required String password,
      required String gender,
      required String birthdate}) async {
    var response = await api.post(
      '${ApiConsts.apiBaseUrl}${ApiConsts.auth}${ApiConsts.signUp}',
      data: {
        ApiKeys.name: name,
        ApiKeys.email: email,
        ApiKeys.password: password,
        ApiKeys.gender: gender,
        ApiKeys.birthdate: birthdate,
      },
    );
    return response;
  }

  addUserToCart({required String cartID, required String userID}) async {
    var response = await api.patch(
      '${ApiConsts.apiBaseUrl}${ApiConsts.cart}$cartID/${ApiConsts.addUserToCart}',
      data: {ApiKeys.userID: userID},
    );
    return response;
  }

  removeUserFromCart({required String cartID, required String userID}) async {
    var response = await api.patch(
      '${ApiConsts.apiBaseUrl}${ApiConsts.cart}$cartID/${ApiConsts.removeUserFromCart}',
      data: {ApiKeys.userID: userID},
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
      data: {ApiKeys.productID: productID},
    );
    return response;
  }
}

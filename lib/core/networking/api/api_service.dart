import 'package:smart_cart_app/core/networking/api/api_consumer.dart';
import 'package:smart_cart_app/core/networking/api/api_consts.dart';
import 'package:smart_cart_app/features/checkout/data/models/payment_intent_input_model/payment_intent_input_model.dart';

class ApiService {
  final ApiConsumer api;

  ApiService(this.api);

  signUp({
    required String name,
    required String email,
    required String password,
    required String gender,
    required String birthdate,
  }) async {
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

  verifyEmail({
    required String code,
  }) async {
    var response = await api.post(
      '${ApiConsts.apiBaseUrl}${ApiConsts.auth}${ApiConsts.verifyEmail}',
      data: {
        ApiKeys.code: code,
      },
    );
    return response;
  }

  logIn({
    required String email,
    required String password,
  }) async {
    var response = await api.post(
      '${ApiConsts.apiBaseUrl}${ApiConsts.auth}${ApiConsts.login}',
      data: {
        ApiKeys.email: email,
        ApiKeys.password: password,
      },
    );
    return response;
  }

  logOut() async {
    var response = await api
        .post('${ApiConsts.apiBaseUrl}${ApiConsts.auth}${ApiConsts.logout}');
    return response;
  }

  refreshToken({required String token}) async {
    var response = await api.post(
        '${ApiConsts.apiBaseUrl}${ApiConsts.auth}${ApiConsts.refreshToken}');
    return response;
  }

  getCategories() async {
    var response = await api
        .get('${ApiConsts.apiBaseUrl}${ApiConsts.user}${ApiConsts.categories}');
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

  createPaymentIntent({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    var response = await api.post(
      ApiConsts.stripeUrl,
      data: paymentIntentInputModel.toJson(),
      token: ApiConsts.stripeToken,
    );
    return response;
  }
}

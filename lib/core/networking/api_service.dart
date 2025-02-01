import 'package:dio/dio.dart';
import 'package:smart_cart_app/core/networking/api_consts.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<int?> addUserToCart(
      {required String cartID, required String userID}) async {
    var response = await _dio.request<dynamic>(
      '${ApiConsts.apiBaseUrl}${ApiConsts.cart}$cartID/${ApiConsts.addUserToCart}',
      data: {"userID": userID},
      options: Options(
        method: "PATCH",
      ),
    );
    return response.statusCode;
  }

  Future<int?> removeUserFromCart(
      {required String cartID, required String userID}) async {
    print(userID);
    print(cartID);
    var response = await _dio.request<dynamic>(
      '${ApiConsts.apiBaseUrl}${ApiConsts.cart}$cartID/${ApiConsts.removeUserFromCart}',
      data: {"userID": userID},
      options: Options(
        method: "PATCH",
      ),
    );
    return response.statusCode;
  }

  Future<Map<String, dynamic>> getCartProducts({required String cartID}) async {
    var response = await _dio.request<dynamic>(
        '${ApiConsts.apiBaseUrl}${ApiConsts.cart}$cartID/${ApiConsts.products}',
        options: Options(method: "GET"));
    return response.data;
  }

  Future<int?> deleteProduct(
      {required String productID, required String cartID}) async {
    try {
      print(
          "=========================================================================");
      print(productID);
      print(cartID);
      var response = await _dio.request<dynamic>(
        '${ApiConsts.apiBaseUrl}${ApiConsts.cart}$cartID/${ApiConsts.deleteProductFromCart}',
        options: Options(method: "DELETE"),
        data: {"productID": productID},
      );
      return response.statusCode;
    } catch (e) {
      print("ERORRRRRRRRRRRRRR: $e");
      return null;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:smart_cart_app/core/networking/api_consts.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<int?> addUserToCart(
      {required String cartID, required String userID}) async {
    var response = await _dio.request<dynamic>(
        '${ApiConsts.apiBaseUrl}${ApiConsts.cart}$cartID/${ApiConsts.addUserToCart}',
        queryParameters: <String, dynamic>{"userID": userID},
        options: Options(method: "PATCH"));
    return response.statusCode;
  }

  Future<Map<String, dynamic>> getCartProducts({required String cartID}) async {
    var response = await _dio.request<dynamic>(
        '${ApiConsts.apiBaseUrl}${ApiConsts.cart}$cartID/${ApiConsts.products}',
        options: Options(method: "GET"));
    return response.data;
  }
}

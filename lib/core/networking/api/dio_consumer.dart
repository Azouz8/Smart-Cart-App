import 'package:dio/dio.dart';
import 'package:smart_cart_app/core/networking/api/api_consumer.dart';
import 'package:smart_cart_app/core/networking/errors/exceptions.dart';
import 'package:smart_cart_app/core/services/cache_helper.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;
  DioConsumer({required this.dio}) {
    dio.interceptors
        .add(LogInterceptor(responseBody: true, requestHeader: true));
  }
  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final token = CacheHelper.getString(key: CacheHelperKeys.token);
      dio.options.headers["authorization"] = "Bearer $token";
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future patch(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final token = CacheHelper.getString(key: CacheHelperKeys.token);
      dio.options.headers["authorization"] = "Bearer $token";
      final response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future post(String path,
      {Object? data, Map<String, dynamic>? queryParameters ,String? token}) async {
    try {
      // final token = CacheHelper.getString(key: CacheHelperKeys.token);
      // Remember to add the token for each method use this
      dio.options.headers["authorization"] = "Bearer $token";
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future delete(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final token = CacheHelper.getString(key: CacheHelperKeys.token);
      dio.options.headers["authorization"] = "Bearer $token";
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.statusCode;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }
}

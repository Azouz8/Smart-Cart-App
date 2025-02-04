import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_cart_app/core/networking/api/api_service.dart';
import 'package:smart_cart_app/core/networking/api/dio_consumer.dart';
import 'package:smart_cart_app/features/home/data/repos/home_repo_impl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(DioConsumer(dio: Dio())));

  getIt.registerSingleton<IO.Socket>(
    IO.io(
      "http://192.168.110.1:3000", // Replace with your server URL
      <String, dynamic>{
        'autoConnect': false,
        'transports': ['websocket'],
      },
    ),
  );

  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      getIt<ApiService>(),
      getIt<IO.Socket>(),
    ),
  );
}

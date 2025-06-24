import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CommonModule extends Module {
  @override
  void exportedBinds(Injector i) {
    final dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('[DIO] REQUEST[${options.method}] => PATH: ${options.path}');
          print('[DIO] REQUEST[${options.method}] => BASE URL: ${options.baseUrl}');
          print('[DIO] REQUEST[${options.method}] => FULL URL: ${options.uri.toString()}');
          // options.headers['Authorization'] = 'Bearer token'; // Example
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print(
            '[DIO] RESPONSE[${response.statusCode}] => DATA: ${response.data}',
          );
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print(
            '[DIO] ERROR[${e.response?.statusCode}] => MESSAGE: ${e.message}',
          );
          return handler.next(e);
        },
      ),
    );

    i.addSingleton<Dio>(()=> dio);
  }
}

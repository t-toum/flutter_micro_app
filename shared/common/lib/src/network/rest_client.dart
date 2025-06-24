import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'rest_client.g.dart';
@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('/todos')
  Future<List<TodoModel>> getTodos();
}
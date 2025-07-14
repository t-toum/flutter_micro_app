import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:todo/src/feature/data/models/todo_model.dart';
part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('/todos')
  Future<List<TodoModel>> getTodos();
}
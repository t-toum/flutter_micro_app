import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:todo/src/core/network/rest_client.dart';
import 'package:todo/src/feature/data/models/todo_model.dart';

abstract class TodoRemoteDatasource {
  Future<List<TodoModel>> getTodos();
}

class TodoRemoteDatasourceImpl implements TodoRemoteDatasource {
  final RestClient _restClient;
  TodoRemoteDatasourceImpl(this._restClient);
  
  @override
  Future<List<TodoModel>> getTodos() async {
    try {
      final response = await _restClient.getTodos();
      return response;
    } on DioException catch (e) {
      throw ServerException(
        e.message ?? e.response?.data['message'] ?? 'Server error',
      );
    }
  }
}



import 'package:common/common.dart';
import 'package:dio/dio.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> getTodos();
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final RestClient _client;

  TodoRemoteDataSourceImpl(this._client);
  @override
  Future<List<TodoModel>> getTodos() async {
    try {
      final data = await _client.getTodos();
      return data;
    } on DioException catch (error) {
      throw ServerException(error.message ?? error.response?.data ?? '');
    } catch (error) {
      throw ServerException(error.toString());
    }
  }
}

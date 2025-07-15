import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:todo/src/core/network/rest_client.dart';
import 'package:todo/src/feature/home/data/datasources/todo_remote_datasource.dart';
import 'package:todo/src/feature/home/domain/repositories/todo_repository.dart';
import 'package:todo/src/feature/home/domain/usecases/get_todo_usecase.dart';

@GenerateMocks([
  RestClient,
  TodoRemoteDatasource,
  TodoRepository,
  GetTodoUsecase,
  Dio,
])
void main() {}

class TestHelper {
  static String fixture(String name) {
    final file = File('test/fixtures/$name');
    return file.readAsStringSync();
  }

  static Map<String, dynamic> fixtureMap(String name) {
    return json.decode(fixture(name));
  }

  static List<dynamic> fixtureList(String name) {
    return json.decode(fixture(name));
  }
}

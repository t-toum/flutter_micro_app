import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/src/feature/home/data/datasources/todo_remote_datasource.dart';
import 'package:todo/src/feature/home/data/models/todo_model.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late TodoRemoteDatasourceImpl dataSource;
  late MockRestClient mockRestClient;

  setUp(() {
    mockRestClient = MockRestClient();
    dataSource = TodoRemoteDatasourceImpl(mockRestClient);
  });

  const tTodoModelList = [
    TodoModel(id: 1, userId: 1, title: 'Test Todo 1', completed: false),
    TodoModel(id: 2, userId: 1, title: 'Test Todo 2', completed: true),
  ];

  group("Get Todos", () {
    test(
      'should return list of TodoModel when response is successful',
      () async {
        // arrange
        when(mockRestClient.getTodos()).thenAnswer((_) async => tTodoModelList);

        // act
        final result = await dataSource.getTodos();

        // assert
        verify(mockRestClient.getTodos());
        expect(result, equals(tTodoModelList));
      },
    );

    test('should throw ServerException when DioException occurs', () async {
      // arrange
      when(mockRestClient.getTodos()).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          message: 'Server Error',
        ),
      );

      // act
      final call = dataSource.getTodos;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
    test(
      'should throw ServerException with custom message from response',
      () async {
        // arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {'message': 'Custom Error Message'},
            statusCode: 500,
          ),
        );

        when(mockRestClient.getTodos()).thenThrow(dioException);

        // act & assert
        expect(
          () => dataSource.getTodos(),
          throwsA(
            predicate(
              (e) => e is ServerException && e.message == 'Custom Error Message',
            ),
          ),
        );
      },
    );
  });
}

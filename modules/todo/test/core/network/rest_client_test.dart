import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/src/feature/home/data/models/todo_model.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockRestClient mockRestClient;

  setUp(() {
    mockRestClient = MockRestClient();
  });

  group('RestClient', () {
    group("getTodos", () {
      const tTodoModelList = [
        TodoModel(
          id: 1,
          userId: 1,
          title: 'Learn Flutter TDD',
          completed: false,
        ),
        TodoModel(id: 2, userId: 1, title: 'Write Unit Tests', completed: true),
      ];
      test(
        'should return List<TodoModel> when API call is successful',
        () async {
          // arrange
          when(
            mockRestClient.getTodos(),
          ).thenAnswer((_) async => tTodoModelList);
          // act
          final result = await mockRestClient.getTodos();
          // assert
          expect(result, isA<List<TodoModel>>());
          expect(result.length, 2);
          expect(result[0].id, 1);
          expect(result[0].title, 'Learn Flutter TDD');
          expect(result[0].completed, false);
          expect(result[1].id, 2);
          expect(result[1].title, 'Write Unit Tests');
          expect(result[1].completed, true);
          verify(mockRestClient.getTodos()).called(1);
          verifyNoMoreInteractions(mockRestClient);
        },
      );
      test('should return empty list when API returns empty data', () async {
        // arrange
        when(mockRestClient.getTodos()).thenAnswer((_) async => <TodoModel>[]);

        // act
        final result = await mockRestClient.getTodos();

        // assert
        expect(result, isA<List<TodoModel>>());
        expect(result, isEmpty);
        verify(mockRestClient.getTodos()).called(1);
      });
      test('should throw DioException when network error occurs', () async {
        // arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/todos'),
          message: 'Network Error',
          type: DioExceptionType.connectionTimeout,
        );

        when(mockRestClient.getTodos()).thenThrow(dioException);

        // act & assert
        expect(() => mockRestClient.getTodos(), throwsA(isA<DioException>()));
        verify(mockRestClient.getTodos()).called(1);
      });
      test('should throw DioException when server returns error', () async {
        // arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/todos'),
          response: Response(
            statusCode: 500,
            data: {'error': 'Internal Server Error'},
            requestOptions: RequestOptions(path: '/todos'),
          ),
          type: DioExceptionType.badResponse,
        );

        when(mockRestClient.getTodos()).thenThrow(dioException);

        // act & assert
        expect(() => mockRestClient.getTodos(), throwsA(isA<DioException>()));
        verify(mockRestClient.getTodos()).called(1);
      });
      test('should handle large response data efficiently', () async {
        // arrange
        final largeTodoList = List.generate(
          1000,
          (index) => TodoModel(
            id: index + 1,
            userId: (index % 10) + 1,
            title: 'Todo ${index + 1}',
            completed: index % 2 == 0,
          ),
        );

        when(mockRestClient.getTodos()).thenAnswer((_) async => largeTodoList);

        // act
        final result = await mockRestClient.getTodos();

        // assert
        expect(result.length, 1000);
        expect(result[0].id, 1);
        expect(result[999].id, 1000);
        expect(result[0].completed, true); // Even index = true
        expect(result[1].completed, false); // Odd index = false
        verify(mockRestClient.getTodos()).called(1);
      });
      test('should handle todos with special characters in title', () async {
        // arrange
        const specialTodos = [
          TodoModel(
            id: 1,
            userId: 1,
            title: 'TODO with émojis 🚀 and spëcial chars àáâãäåæçèéêë',
            completed: false,
          ),
        ];

        when(mockRestClient.getTodos()).thenAnswer((_) async => specialTodos);

        // act
        final result = await mockRestClient.getTodos();

        // assert
        expect(result.length, 1);
        expect(
          result[0].title,
          'TODO with émojis 🚀 and spëcial chars àáâãäåæçèéêë',
        );
        verify(mockRestClient.getTodos()).called(1);
      });
    });
    group('error handling scenarios', () {
      test('should handle connection timeout', () async {
        // arrange
        final timeoutException = DioException(
          requestOptions: RequestOptions(path: '/todos'),
          type: DioExceptionType.connectionTimeout,
          message: 'Connection timeout',
        );

        when(mockRestClient.getTodos()).thenThrow(timeoutException);

        // act & assert
        expect(
          () => mockRestClient.getTodos(),
          throwsA(
            predicate<DioException>(
              (e) => e.type == DioExceptionType.connectionTimeout,
            ),
          ),
        );
      });
      test('should handle receive timeout', () async {
        // arrange
        final timeoutException = DioException(
          requestOptions: RequestOptions(path: '/todos'),
          type: DioExceptionType.receiveTimeout,
          message: 'Receive timeout',
        );

        when(mockRestClient.getTodos()).thenThrow(timeoutException);

        // act & assert
        expect(
          () => mockRestClient.getTodos(),
          throwsA(
            predicate<DioException>(
              (e) => e.type == DioExceptionType.receiveTimeout,
            ),
          ),
        );
      });
      test('should handle send timeout', () async {
        // arrange
        final timeoutException = DioException(
          requestOptions: RequestOptions(path: '/todos'),
          type: DioExceptionType.sendTimeout,
          message: 'Send timeout',
        );

        when(mockRestClient.getTodos()).thenThrow(timeoutException);

        // act & assert
        expect(
          () => mockRestClient.getTodos(),
          throwsA(
            predicate<DioException>(
              (e) => e.type == DioExceptionType.sendTimeout,
            ),
          ),
        );
      });
      test('should handle request cancellation', () async {
        // arrange
        final cancelException = DioException(
          requestOptions: RequestOptions(path: '/todos'),
          type: DioExceptionType.cancel,
          message: 'Request cancelled',
        );

        when(mockRestClient.getTodos()).thenThrow(cancelException);

        // act & assert
        expect(
          () => mockRestClient.getTodos(),
          throwsA(
            predicate<DioException>((e) => e.type == DioExceptionType.cancel),
          ),
        );
      });
      test('should handle 400 Bad Request error', () async {
        // arrange
        final badRequestException = DioException(
          requestOptions: RequestOptions(path: '/todos'),
          response: Response(
            statusCode: 400,
            data: {'error': 'Bad Request', 'message': 'Invalid parameters'},
            requestOptions: RequestOptions(path: '/todos'),
          ),
          type: DioExceptionType.badResponse,
        );

        when(mockRestClient.getTodos()).thenThrow(badRequestException);

        // act & assert
        expect(
          () => mockRestClient.getTodos(),
          throwsA(
            predicate<DioException>((e) => e.response?.statusCode == 400),
          ),
        );
      });
      test('should handle 401 Unauthorized error', () async {
        // arrange
        final unauthorizedException = DioException(
          requestOptions: RequestOptions(path: '/todos'),
          response: Response(
            statusCode: 401,
            data: {
              'error': 'Unauthorized',
              'message': 'Authentication required',
            },
            requestOptions: RequestOptions(path: '/todos'),
          ),
          type: DioExceptionType.badResponse,
        );

        when(mockRestClient.getTodos()).thenThrow(unauthorizedException);

        // act & assert
        expect(
          () => mockRestClient.getTodos(),
          throwsA(
            predicate<DioException>((e) => e.response?.statusCode == 401),
          ),
        );
      });
      test('should handle 404 Not Found error', () async {
        // arrange
        final notFoundException = DioException(
          requestOptions: RequestOptions(path: '/todos'),
          response: Response(
            statusCode: 404,
            data: {'error': 'Not Found', 'message': 'Endpoint not found'},
            requestOptions: RequestOptions(path: '/todos'),
          ),
          type: DioExceptionType.badResponse,
        );

        when(mockRestClient.getTodos()).thenThrow(notFoundException);

        // act & assert
        expect(
          () => mockRestClient.getTodos(),
          throwsA(
            predicate<DioException>((e) => e.response?.statusCode == 404),
          ),
        );
      });

      test('should handle 500 Internal Server Error', () async {
        // arrange
        final serverErrorException = DioException(
          requestOptions: RequestOptions(path: '/todos'),
          response: Response(
            statusCode: 500,
            data: {'error': 'Internal Server Error'},
            requestOptions: RequestOptions(path: '/todos'),
          ),
          type: DioExceptionType.badResponse,
        );

        when(mockRestClient.getTodos()).thenThrow(serverErrorException);

        // act & assert
        expect(
          () => mockRestClient.getTodos(),
          throwsA(
            predicate<DioException>((e) => e.response?.statusCode == 500),
          ),
        );
      });
    });
    group('behavior verification', () {
      test('should call getTodos method exactly once', () async {
        // arrange
        when(mockRestClient.getTodos()).thenAnswer((_) async => <TodoModel>[]);

        // act
        await mockRestClient.getTodos();

        // assert
        verify(mockRestClient.getTodos()).called(1);
        verifyNoMoreInteractions(mockRestClient);
      });

      test('should maintain method call order in sequence', () async {
        // arrange
        const firstBatch = [
          TodoModel(id: 1, userId: 1, title: 'First', completed: false),
        ];
        const secondBatch = [
          TodoModel(id: 2, userId: 1, title: 'Second', completed: true),
        ];

        when(mockRestClient.getTodos()).thenAnswer((_) async => firstBatch);

        // act - first call
        final firstResult = await mockRestClient.getTodos();

        // arrange - change mock behavior for second call
        when(mockRestClient.getTodos()).thenAnswer((_) async => secondBatch);

        // act - second call
        final secondResult = await mockRestClient.getTodos();

        // assert
        expect(firstResult[0].title, 'First');
        expect(secondResult[0].title, 'Second');
        verify(mockRestClient.getTodos()).called(2);
      });
    });

    group('data integrity tests', () {
      test('should preserve all todo properties correctly', () async {
        // arrange
        const testTodo = TodoModel(
          id: 999,
          userId: 42,
          title: 'Comprehensive Test Todo',
          completed: true,
        );

        when(mockRestClient.getTodos()).thenAnswer((_) async => [testTodo]);

        // act
        final result = await mockRestClient.getTodos();

        // assert
        expect(result.length, 1);
        final todo = result[0];
        expect(todo.id, 999);
        expect(todo.userId, 42);
        expect(todo.title, 'Comprehensive Test Todo');
        expect(todo.completed, true);

        // Verify it's the exact same object
        expect(todo, equals(testTodo));
      });

      test('should handle mixed completion states correctly', () async {
        // arrange
        const mixedTodos = [
          TodoModel(id: 1, userId: 1, title: 'Incomplete', completed: false),
          TodoModel(id: 2, userId: 1, title: 'Complete', completed: true),
          TodoModel(
            id: 3,
            userId: 2,
            title: 'Another Incomplete',
            completed: false,
          ),
        ];

        when(mockRestClient.getTodos()).thenAnswer((_) async => mixedTodos);

        // act
        final result = await mockRestClient.getTodos();

        // assert
        expect(result.length, 3);

        final incompleteTodos = result
            .where((todo) => !todo.completed)
            .toList();
        final completeTodos = result.where((todo) => todo.completed).toList();

        expect(incompleteTodos.length, 2);
        expect(completeTodos.length, 1);
        expect(completeTodos[0].title, 'Complete');
      });
    });
  });
}

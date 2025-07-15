import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/src/feature/home/data/models/todo_model.dart';
import 'package:todo/src/feature/home/data/repositories/todo_repository_impl.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late TodoRepositoryImpl repository;
  late MockTodoRemoteDatasource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockTodoRemoteDatasource();
    repository = TodoRepositoryImpl(mockRemoteDataSource);
  });

  const tTodoModelList = [
    TodoModel(id: 1, userId: 1, title: 'Test Todo 1', completed: false),
    TodoModel(id: 2, userId: 1, title: 'Test Todo 2', completed: true),
  ];

  group("getTodos", () {
    test(
      "should return todos when call to remote data source is successful",
      () async {
        // arrange
        when(
          mockRemoteDataSource.getTodos(),
        ).thenAnswer((_) async => tTodoModelList);

        // act
        final result = await repository.getTodos();

        // assert
        verify(mockRemoteDataSource.getTodos());
        expect(result, equals(const Right(tTodoModelList)));
      },
    );

    test(
      "should return ServerFailure when call to remote data source fails",
      () async {
        // arrange
        when(
          mockRemoteDataSource.getTodos(),
        ).thenThrow(const ServerException('Server Error'));

        final result = await repository.getTodos();
        // assert
        verify(mockRemoteDataSource.getTodos());
        expect(result, equals(const Left(ServerFailure('Server Error'))));
      },
    );
  });
}

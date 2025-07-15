import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/src/feature/home/domain/entities/todo.dart';
import 'package:todo/src/feature/home/domain/usecases/get_todo_usecase.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTodoUsecase usecase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = GetTodoUsecase(mockTodoRepository);
  });

  const tTodoList = [
    Todo(id: 1, userId: 1, title: 'Test Todo 1', completed: false),
    Todo(id: 2, userId: 1, title: 'Test Todo 2', completed: true),
  ];

  group('GetTodoUsecase', () {
    test('should get todos from the repository', () async {
      // arrange
      when(
        mockTodoRepository.getTodos(),
      ).thenAnswer((_) async => const Right(tTodoList));

      // act
      final result = await usecase(NoParams());

      // assert
      expect(result, const Right(tTodoList));
      verify(mockTodoRepository.getTodos());
      verifyNoMoreInteractions(mockTodoRepository);
    });

    test('hould return ServerFailure when repository fails', () async {
      // arrange
      const tFailure = ServerFailure('Server Error');
      when(
        mockTodoRepository.getTodos(),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await usecase(NoParams());

      // assert
      expect(result, const Left(tFailure));
      verify(mockTodoRepository.getTodos());
      verifyNoMoreInteractions(mockTodoRepository);
    });
  });
}

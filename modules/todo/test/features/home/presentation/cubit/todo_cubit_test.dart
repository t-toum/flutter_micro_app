import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/src/feature/home/domain/entities/todo.dart';
import 'package:todo/src/feature/home/presentation/cubit/todo_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late TodoCubit cubit;
  late MockGetTodoUsecase mockGetTodoUsecase;

  setUp(() {
    mockGetTodoUsecase = MockGetTodoUsecase();
    cubit = TodoCubit(mockGetTodoUsecase);
  });

  tearDown(() {
    cubit.close();
  });

  const tTodoList = [
    Todo(id: 1, userId: 1, title: 'Test Todo 1', completed: false),
    Todo(id: 2, userId: 1, title: 'Test Todo 2', completed: true),
  ];

  test('initial state should be TodoState with initial status', () {
    // assert
    expect(cubit.state, equals(const TodoState()));
    expect(cubit.state.status, equals(DataStatus.initial));
    expect(cubit.state.todos, equals([]));
    expect(cubit.state.error, isNull);
  });

  group('fetchTodos', () {
    blocTest<TodoCubit, TodoState>(
      'should emit [loading, success] when data is gotten successfully',
      build: () {
        when(
          mockGetTodoUsecase(any),
        ).thenAnswer((_) async => const Right(tTodoList));
        return cubit;
      },
      act: (cubit) => cubit.fetchTodos(),
      expect: () => [
        const TodoState(status: DataStatus.loading),
        const TodoState(status: DataStatus.success, todos: tTodoList),
      ],
    );

    blocTest<TodoCubit, TodoState>(
      'should emit [loading, failed] when getting data fails',
      build: () {
        when(
          mockGetTodoUsecase(any),
        ).thenAnswer((_) async => const Left(ServerFailure('Server Error')));
        return cubit;
      },
      act: (cubit) => cubit.fetchTodos(),
      expect: () => [
        const TodoState(status: DataStatus.loading),
        const TodoState(status: DataStatus.failure, error: 'Server Error'),
      ],
    );

    blocTest<TodoCubit, TodoState>(
      'should call GetTodoUsecase',
      build: () {
        when(
          mockGetTodoUsecase(any),
        ).thenAnswer((_) async => const Right(tTodoList));
        return cubit;
      },
      act: (cubit) => cubit.fetchTodos(),
      verify: (_) {
        verify(mockGetTodoUsecase(NoParams()));
      },
    );
  });
}

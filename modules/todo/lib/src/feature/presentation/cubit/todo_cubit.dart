import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/src/feature/domain/entities/todo.dart';
import 'package:todo/src/feature/domain/usecases/get_todo_usecase.dart';
part 'todo_state.dart';
part 'todo_cubit.freezed.dart';

class TodoCubit extends Cubit<TodoState> {
  final GetTodoUsecase _getTodoUsecase;
  TodoCubit(this._getTodoUsecase) : super(const TodoState());
  Future<void> fetchTodos() async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _getTodoUsecase(NoParams());
    result.fold(
      (failure) {
        emit(state.copyWith(
          error: failure.msg,
          status: DataStatus.failed,
        ));
      },
      (todos) {
        emit(state.copyWith(
          todos: todos,
          status: DataStatus.success,
        ));
      },
    );
  }
  
}

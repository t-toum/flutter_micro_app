import 'package:common/common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todos/todos.dart';
part 'todo_state.dart';
part 'todo_cubit.freezed.dart';

class TodoCubit extends Cubit<TodoState> {
  final GetTodoUsecase _getTodoUsecase;
  TodoCubit(this._getTodoUsecase) : super(const TodoState());


  Future<void> getTodo() async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _getTodoUsecase(NoParams());
    result.fold(
      (error) {
        emit(state.copyWith(error: error.msg, status: DataStatus.failed));
      },
      (success) {
        emit(state.copyWith(status: DataStatus.success, todos: success));
      },
    );
  }
}

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:todo/src/feature/domain/entities/todo.dart';
import 'package:todo/src/feature/domain/repositories/todo_repository.dart';

class GetTodoUsecase implements UseCase<List<Todo>, NoParams> {
  final TodoRepository todoRepository;
  GetTodoUsecase(this.todoRepository);

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async {
    return await todoRepository.getTodos();
  }
}

import 'package:common/common.dart';
import 'package:todos/src/domain/repositories/todo_repository.dart';

class GetTodoUsecase implements UseCase<List<Todo>, NoParams> {
  final TodoRepository _repository;
  GetTodoUsecase(this._repository);
  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async {
    return await _repository.getTodo();
  }
}

import 'package:common/common.dart';
import 'package:todos/src/data/datasources/todo_remote_data_source.dart';
import 'package:todos/src/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource _dataSource;
  TodoRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failure, List<Todo>>> getTodo() async {
    try {
      final data = await _dataSource.getTodos();
      return Right(data);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.msg));
    }
  }
}

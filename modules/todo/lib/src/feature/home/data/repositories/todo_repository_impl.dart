import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:todo/src/feature/home/data/datasources/todo_remote_datasource.dart';
import 'package:todo/src/feature/home/domain/entities/todo.dart';
import 'package:todo/src/feature/home/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDatasource _remoteDataSource;

  TodoRepositoryImpl(this._remoteDataSource);
  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      final todos = await _remoteDataSource.getTodos();
      return Right(todos);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, code: e.code, details: e.details));
    }
  }
}

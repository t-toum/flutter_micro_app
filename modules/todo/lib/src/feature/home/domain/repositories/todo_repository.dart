import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:todo/src/feature/home/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos();
}
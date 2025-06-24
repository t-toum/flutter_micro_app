import 'package:common/common.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodo();
}
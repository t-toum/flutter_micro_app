import 'package:common/common.dart';
import 'package:todos/src/data/datasources/todo_remote_data_source.dart';
import 'package:todos/src/data/repositories/todo_repository_impl.dart';
import 'package:todos/src/domain/repositories/todo_repository.dart';
import 'package:todos/src/domain/usecases/get_todo_usecase.dart';

class TodoModule extends Module {
  @override
  List<Module> get imports => [CommonModule()];

  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<RestClient>(
      () => RestClient(
        Modular.get<Dio>(),
        baseUrl: 'https://dummy-json.mock.beeceptor.com',
      ),
    );
    i.addLazySingleton<TodoRemoteDataSource>(TodoRemoteDataSourceImpl.new);
    i.addLazySingleton<TodoRepository>(TodoRepositoryImpl.new);
    i.addLazySingleton<GetTodoUsecase>(GetTodoUsecase.new);
  }
}

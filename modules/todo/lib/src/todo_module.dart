import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo/src/core/network/rest_client.dart';
import 'package:todo/src/feature/home/data/datasources/todo_remote_datasource.dart';
import 'package:todo/src/feature/home/data/repositories/todo_repository_impl.dart';
import 'package:todo/src/feature/home/domain/repositories/todo_repository.dart';
import 'package:todo/src/feature/home/domain/usecases/get_todo_usecase.dart';
import 'package:todo/src/feature/home/presentation/cubit/todo_cubit.dart';
import 'package:todo/src/feature/home/presentation/pages/todo_list_page.dart';

class TodoModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton<RestClient>(
      () => RestClient(
        i.get<Dio>(),
        baseUrl: 'https://dummy-json.mock.beeceptor.com',
      ),
    );

    i.addLazySingleton<TodoRemoteDatasource>(
      () => TodoRemoteDatasourceImpl(i.get<RestClient>()),
    );
    i.addLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(i.get<TodoRemoteDatasource>()),
    );
    i.addLazySingleton<GetTodoUsecase>(
      () => GetTodoUsecase(i.get<TodoRepository>()),
    );
    i.add<TodoCubit>(() => TodoCubit(i.get<GetTodoUsecase>()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => BlocProvider<TodoCubit>(
        create: (context) => Modular.get<TodoCubit>()..fetchTodos(),
        child: const TodoListPage(),
      ),
    );
  }
}

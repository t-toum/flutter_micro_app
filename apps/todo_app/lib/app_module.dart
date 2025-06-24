import 'package:common/common.dart';
import 'package:todo_app/home/cubit/todo_cubit.dart';
import 'package:todo_app/home/pages/todo_page.dart';
import 'package:todos/todos.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [TodoModule()];

  @override
  void binds(Injector i) {
    //Register factory
    i.add<TodoCubit>(TodoCubit.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child:
          (_) => BlocProvider<TodoCubit>(
            create: (context) => Modular.get<TodoCubit>()..getTodo(),
            child: const TodoPage(),
          ),
    );
  }
}

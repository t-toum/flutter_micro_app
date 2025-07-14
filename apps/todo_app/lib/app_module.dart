import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo/todo.dart';
import 'package:todo_app/pages/home_page.dart';

class AppModule implements Module {
  @override
  void binds(Injector i) {
  }

  @override
  void exportedBinds(Injector i) {
  }

  @override
  List<Module> get imports => [];

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const HomePage());
    r.module('/todo', module: TodoModule());
  }
}
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import '../cubit/todo_cubit.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state.status == DataStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (context, index) {
              final todo = state.todos[index];
              return ListTile(
                title: Text(todo.title),
                trailing: todo.completed ? Icon(Icons.check) : SizedBox(),
              );
            },
          );
        },
      ),
    );
  }
}

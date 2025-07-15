import 'package:flutter_test/flutter_test.dart';
import 'package:todo/src/feature/home/domain/entities/todo.dart';

void main() {
  group('Todo Entity', () {
    const tTodo = Todo(id: 1, userId: 1, title: 'Test Todo', completed: false);
    test('should be a subclass of Equatable', () {
      expect(tTodo, isA<Todo>());
    });

    test('should have correct props for Equatable', () {
      // arrange & act
      final props = tTodo.props;

      // assert
      expect(props, [1, 1, 'Test Todo', false]);
    });

    test('should return true when comparing two identical todos', () {
      // arrange
      const tTodo1 = Todo(
        id: 1,
        userId: 1,
        title: 'Test Todo',
        completed: false,
      );
      const tTodo2 = Todo(
        id: 1,
        userId: 1,
        title: 'Test Todo',
        completed: false,
      );

      // act & assert
      expect(tTodo1, equals(tTodo2));
    });
  });
}

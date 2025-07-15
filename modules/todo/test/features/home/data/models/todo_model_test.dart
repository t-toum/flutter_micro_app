import 'package:flutter_test/flutter_test.dart';
import 'package:todo/src/feature/home/data/models/todo_model.dart';
import 'package:todo/src/feature/home/domain/entities/todo.dart';

import '../../../../helpers/test_helper.dart';

void main() {
  const tTodoModel = TodoModel(
    id: 1,
    userId: 1,
    title: 'Learn Flutter TDD',
    completed: false,
  );

  group('Todo Model', () {
    test('should be a subclass of Todo entity', () {
      // assert
      expect(tTodoModel, isA<Todo>());
    });
  });

  group("fromJson", () {
    test('should return a valid TodoModel from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap = {
        'id': 1,
        'userId': 1,
        'title': 'Learn Flutter TDD',
        'completed': false,
      };

      // act
      final result = TodoModel.fromJson(jsonMap);

      // assert
      expect(result, equals(tTodoModel));
    });

    test('should return a valid TodoModel from fixture', () {
      // arrange
      final List<dynamic> jsonList = TestHelper.fixtureList(
        'todo_fixtures.json',
      );
      final Map<String, dynamic> jsonMap = jsonList.first;

      // act
      final result = TodoModel.fromJson(jsonMap);

      // assert
      expect(result, isA<TodoModel>());
      expect(result.id, 1);
      expect(result.title, 'Learn Flutter TDD');
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () {
      // act
      final result = tTodoModel.toJson();
      final expectedMap = {
        'id': 1,
        'userId': 1,
        'title': 'Learn Flutter TDD',
        'completed': false,
      };
      expect(result, equals(expectedMap));
    });
  });
}

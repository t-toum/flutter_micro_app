part of 'todo_cubit.dart';

@freezed
abstract class TodoState with _$TodoState {
  const factory TodoState({
    String? error,
    @Default(DataStatus.initial) DataStatus status,
    @Default([])
    List<Todo> todos,
  }) = _TodoState;
}

part of 'todo_cubit.dart';

@freezed
abstract class TodoState with _$TodoState {
  const factory TodoState({
    @Default(DataStatus.loading) DataStatus status,
    String? error,
    @Default([])
    List<Todo> todos,
  }) = _TodoState;
}

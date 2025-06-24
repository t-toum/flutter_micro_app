// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodoState {

 DataStatus get status; String? get error; List<Todo> get todos;
/// Create a copy of TodoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoStateCopyWith<TodoState> get copyWith => _$TodoStateCopyWithImpl<TodoState>(this as TodoState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.todos, todos));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,const DeepCollectionEquality().hash(todos));

@override
String toString() {
  return 'TodoState(status: $status, error: $error, todos: $todos)';
}


}

/// @nodoc
abstract mixin class $TodoStateCopyWith<$Res>  {
  factory $TodoStateCopyWith(TodoState value, $Res Function(TodoState) _then) = _$TodoStateCopyWithImpl;
@useResult
$Res call({
 DataStatus status, String? error, List<Todo> todos
});




}
/// @nodoc
class _$TodoStateCopyWithImpl<$Res>
    implements $TodoStateCopyWith<$Res> {
  _$TodoStateCopyWithImpl(this._self, this._then);

  final TodoState _self;
  final $Res Function(TodoState) _then;

/// Create a copy of TodoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? todos = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DataStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,todos: null == todos ? _self.todos : todos // ignore: cast_nullable_to_non_nullable
as List<Todo>,
  ));
}

}


/// @nodoc


class _TodoState implements TodoState {
  const _TodoState({this.status = DataStatus.loading, this.error, final  List<Todo> todos = const []}): _todos = todos;
  

@override@JsonKey() final  DataStatus status;
@override final  String? error;
 final  List<Todo> _todos;
@override@JsonKey() List<Todo> get todos {
  if (_todos is EqualUnmodifiableListView) return _todos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_todos);
}


/// Create a copy of TodoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoStateCopyWith<_TodoState> get copyWith => __$TodoStateCopyWithImpl<_TodoState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._todos, _todos));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,const DeepCollectionEquality().hash(_todos));

@override
String toString() {
  return 'TodoState(status: $status, error: $error, todos: $todos)';
}


}

/// @nodoc
abstract mixin class _$TodoStateCopyWith<$Res> implements $TodoStateCopyWith<$Res> {
  factory _$TodoStateCopyWith(_TodoState value, $Res Function(_TodoState) _then) = __$TodoStateCopyWithImpl;
@override @useResult
$Res call({
 DataStatus status, String? error, List<Todo> todos
});




}
/// @nodoc
class __$TodoStateCopyWithImpl<$Res>
    implements _$TodoStateCopyWith<$Res> {
  __$TodoStateCopyWithImpl(this._self, this._then);

  final _TodoState _self;
  final $Res Function(_TodoState) _then;

/// Create a copy of TodoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? todos = null,}) {
  return _then(_TodoState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DataStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,todos: null == todos ? _self._todos : todos // ignore: cast_nullable_to_non_nullable
as List<Todo>,
  ));
}


}

// dart format on

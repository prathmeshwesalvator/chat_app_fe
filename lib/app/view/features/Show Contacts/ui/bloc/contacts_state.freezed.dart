// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contacts_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContactsState {

 List<ContactEntities> get contacts; Blocstatus? get contactStatus; String get errroMessage;
/// Create a copy of ContactsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactsStateCopyWith<ContactsState> get copyWith => _$ContactsStateCopyWithImpl<ContactsState>(this as ContactsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactsState&&const DeepCollectionEquality().equals(other.contacts, contacts)&&(identical(other.contactStatus, contactStatus) || other.contactStatus == contactStatus)&&(identical(other.errroMessage, errroMessage) || other.errroMessage == errroMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(contacts),contactStatus,errroMessage);

@override
String toString() {
  return 'ContactsState(contacts: $contacts, contactStatus: $contactStatus, errroMessage: $errroMessage)';
}


}

/// @nodoc
abstract mixin class $ContactsStateCopyWith<$Res>  {
  factory $ContactsStateCopyWith(ContactsState value, $Res Function(ContactsState) _then) = _$ContactsStateCopyWithImpl;
@useResult
$Res call({
 List<ContactEntities> contacts, Blocstatus? contactStatus, String errroMessage
});




}
/// @nodoc
class _$ContactsStateCopyWithImpl<$Res>
    implements $ContactsStateCopyWith<$Res> {
  _$ContactsStateCopyWithImpl(this._self, this._then);

  final ContactsState _self;
  final $Res Function(ContactsState) _then;

/// Create a copy of ContactsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contacts = null,Object? contactStatus = freezed,Object? errroMessage = null,}) {
  return _then(_self.copyWith(
contacts: null == contacts ? _self.contacts : contacts // ignore: cast_nullable_to_non_nullable
as List<ContactEntities>,contactStatus: freezed == contactStatus ? _self.contactStatus : contactStatus // ignore: cast_nullable_to_non_nullable
as Blocstatus?,errroMessage: null == errroMessage ? _self.errroMessage : errroMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ContactsState].
extension ContactsStatePatterns on ContactsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContactsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContactsState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContactsState value)  $default,){
final _that = this;
switch (_that) {
case _ContactsState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContactsState value)?  $default,){
final _that = this;
switch (_that) {
case _ContactsState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ContactEntities> contacts,  Blocstatus? contactStatus,  String errroMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContactsState() when $default != null:
return $default(_that.contacts,_that.contactStatus,_that.errroMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ContactEntities> contacts,  Blocstatus? contactStatus,  String errroMessage)  $default,) {final _that = this;
switch (_that) {
case _ContactsState():
return $default(_that.contacts,_that.contactStatus,_that.errroMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ContactEntities> contacts,  Blocstatus? contactStatus,  String errroMessage)?  $default,) {final _that = this;
switch (_that) {
case _ContactsState() when $default != null:
return $default(_that.contacts,_that.contactStatus,_that.errroMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ContactsState implements ContactsState {
  const _ContactsState({final  List<ContactEntities> contacts = const [], this.contactStatus, this.errroMessage = ''}): _contacts = contacts;
  

 final  List<ContactEntities> _contacts;
@override@JsonKey() List<ContactEntities> get contacts {
  if (_contacts is EqualUnmodifiableListView) return _contacts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contacts);
}

@override final  Blocstatus? contactStatus;
@override@JsonKey() final  String errroMessage;

/// Create a copy of ContactsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactsStateCopyWith<_ContactsState> get copyWith => __$ContactsStateCopyWithImpl<_ContactsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContactsState&&const DeepCollectionEquality().equals(other._contacts, _contacts)&&(identical(other.contactStatus, contactStatus) || other.contactStatus == contactStatus)&&(identical(other.errroMessage, errroMessage) || other.errroMessage == errroMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_contacts),contactStatus,errroMessage);

@override
String toString() {
  return 'ContactsState(contacts: $contacts, contactStatus: $contactStatus, errroMessage: $errroMessage)';
}


}

/// @nodoc
abstract mixin class _$ContactsStateCopyWith<$Res> implements $ContactsStateCopyWith<$Res> {
  factory _$ContactsStateCopyWith(_ContactsState value, $Res Function(_ContactsState) _then) = __$ContactsStateCopyWithImpl;
@override @useResult
$Res call({
 List<ContactEntities> contacts, Blocstatus? contactStatus, String errroMessage
});




}
/// @nodoc
class __$ContactsStateCopyWithImpl<$Res>
    implements _$ContactsStateCopyWith<$Res> {
  __$ContactsStateCopyWithImpl(this._self, this._then);

  final _ContactsState _self;
  final $Res Function(_ContactsState) _then;

/// Create a copy of ContactsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contacts = null,Object? contactStatus = freezed,Object? errroMessage = null,}) {
  return _then(_ContactsState(
contacts: null == contacts ? _self._contacts : contacts // ignore: cast_nullable_to_non_nullable
as List<ContactEntities>,contactStatus: freezed == contactStatus ? _self.contactStatus : contactStatus // ignore: cast_nullable_to_non_nullable
as Blocstatus?,errroMessage: null == errroMessage ? _self.errroMessage : errroMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

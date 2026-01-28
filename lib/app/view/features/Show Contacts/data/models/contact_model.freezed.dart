// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContactModel {

@JsonKey(name: 'id') int get id;@JsonKey(name: 'contact_user_id') int get contactUserId;@JsonKey(name: 'contact_username') String get contactUsername;@JsonKey(name: 'contact_email') String get contactEmail;@JsonKey(name: 'created_at') String get createdAt;
/// Create a copy of ContactModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactModelCopyWith<ContactModel> get copyWith => _$ContactModelCopyWithImpl<ContactModel>(this as ContactModel, _$identity);

  /// Serializes this ContactModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactModel&&(identical(other.id, id) || other.id == id)&&(identical(other.contactUserId, contactUserId) || other.contactUserId == contactUserId)&&(identical(other.contactUsername, contactUsername) || other.contactUsername == contactUsername)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,contactUserId,contactUsername,contactEmail,createdAt);

@override
String toString() {
  return 'ContactModel(id: $id, contactUserId: $contactUserId, contactUsername: $contactUsername, contactEmail: $contactEmail, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ContactModelCopyWith<$Res>  {
  factory $ContactModelCopyWith(ContactModel value, $Res Function(ContactModel) _then) = _$ContactModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'contact_user_id') int contactUserId,@JsonKey(name: 'contact_username') String contactUsername,@JsonKey(name: 'contact_email') String contactEmail,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class _$ContactModelCopyWithImpl<$Res>
    implements $ContactModelCopyWith<$Res> {
  _$ContactModelCopyWithImpl(this._self, this._then);

  final ContactModel _self;
  final $Res Function(ContactModel) _then;

/// Create a copy of ContactModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? contactUserId = null,Object? contactUsername = null,Object? contactEmail = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,contactUserId: null == contactUserId ? _self.contactUserId : contactUserId // ignore: cast_nullable_to_non_nullable
as int,contactUsername: null == contactUsername ? _self.contactUsername : contactUsername // ignore: cast_nullable_to_non_nullable
as String,contactEmail: null == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ContactModel].
extension ContactModelPatterns on ContactModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContactModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContactModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContactModel value)  $default,){
final _that = this;
switch (_that) {
case _ContactModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContactModel value)?  $default,){
final _that = this;
switch (_that) {
case _ContactModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'contact_user_id')  int contactUserId, @JsonKey(name: 'contact_username')  String contactUsername, @JsonKey(name: 'contact_email')  String contactEmail, @JsonKey(name: 'created_at')  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContactModel() when $default != null:
return $default(_that.id,_that.contactUserId,_that.contactUsername,_that.contactEmail,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'contact_user_id')  int contactUserId, @JsonKey(name: 'contact_username')  String contactUsername, @JsonKey(name: 'contact_email')  String contactEmail, @JsonKey(name: 'created_at')  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _ContactModel():
return $default(_that.id,_that.contactUserId,_that.contactUsername,_that.contactEmail,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'contact_user_id')  int contactUserId, @JsonKey(name: 'contact_username')  String contactUsername, @JsonKey(name: 'contact_email')  String contactEmail, @JsonKey(name: 'created_at')  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ContactModel() when $default != null:
return $default(_that.id,_that.contactUserId,_that.contactUsername,_that.contactEmail,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContactModel implements ContactModel {
  const _ContactModel({@JsonKey(name: 'id') this.id = 0, @JsonKey(name: 'contact_user_id') this.contactUserId = 0, @JsonKey(name: 'contact_username') this.contactUsername = '', @JsonKey(name: 'contact_email') this.contactEmail = '', @JsonKey(name: 'created_at') this.createdAt = ''});
  factory _ContactModel.fromJson(Map<String, dynamic> json) => _$ContactModelFromJson(json);

@override@JsonKey(name: 'id') final  int id;
@override@JsonKey(name: 'contact_user_id') final  int contactUserId;
@override@JsonKey(name: 'contact_username') final  String contactUsername;
@override@JsonKey(name: 'contact_email') final  String contactEmail;
@override@JsonKey(name: 'created_at') final  String createdAt;

/// Create a copy of ContactModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactModelCopyWith<_ContactModel> get copyWith => __$ContactModelCopyWithImpl<_ContactModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContactModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContactModel&&(identical(other.id, id) || other.id == id)&&(identical(other.contactUserId, contactUserId) || other.contactUserId == contactUserId)&&(identical(other.contactUsername, contactUsername) || other.contactUsername == contactUsername)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,contactUserId,contactUsername,contactEmail,createdAt);

@override
String toString() {
  return 'ContactModel(id: $id, contactUserId: $contactUserId, contactUsername: $contactUsername, contactEmail: $contactEmail, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ContactModelCopyWith<$Res> implements $ContactModelCopyWith<$Res> {
  factory _$ContactModelCopyWith(_ContactModel value, $Res Function(_ContactModel) _then) = __$ContactModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'contact_user_id') int contactUserId,@JsonKey(name: 'contact_username') String contactUsername,@JsonKey(name: 'contact_email') String contactEmail,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class __$ContactModelCopyWithImpl<$Res>
    implements _$ContactModelCopyWith<$Res> {
  __$ContactModelCopyWithImpl(this._self, this._then);

  final _ContactModel _self;
  final $Res Function(_ContactModel) _then;

/// Create a copy of ContactModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? contactUserId = null,Object? contactUsername = null,Object? contactEmail = null,Object? createdAt = null,}) {
  return _then(_ContactModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,contactUserId: null == contactUserId ? _self.contactUserId : contactUserId // ignore: cast_nullable_to_non_nullable
as int,contactUsername: null == contactUsername ? _self.contactUsername : contactUsername // ignore: cast_nullable_to_non_nullable
as String,contactEmail: null == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

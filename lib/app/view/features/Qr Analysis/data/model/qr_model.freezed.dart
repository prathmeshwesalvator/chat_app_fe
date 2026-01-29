// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QrModel {

 String get message; String get contactHash; String get expiresInMinutes; String get createdAt;
/// Create a copy of QrModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QrModelCopyWith<QrModel> get copyWith => _$QrModelCopyWithImpl<QrModel>(this as QrModel, _$identity);

  /// Serializes this QrModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QrModel&&(identical(other.message, message) || other.message == message)&&(identical(other.contactHash, contactHash) || other.contactHash == contactHash)&&(identical(other.expiresInMinutes, expiresInMinutes) || other.expiresInMinutes == expiresInMinutes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,contactHash,expiresInMinutes,createdAt);

@override
String toString() {
  return 'QrModel(message: $message, contactHash: $contactHash, expiresInMinutes: $expiresInMinutes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $QrModelCopyWith<$Res>  {
  factory $QrModelCopyWith(QrModel value, $Res Function(QrModel) _then) = _$QrModelCopyWithImpl;
@useResult
$Res call({
 String message, String contactHash, String expiresInMinutes, String createdAt
});




}
/// @nodoc
class _$QrModelCopyWithImpl<$Res>
    implements $QrModelCopyWith<$Res> {
  _$QrModelCopyWithImpl(this._self, this._then);

  final QrModel _self;
  final $Res Function(QrModel) _then;

/// Create a copy of QrModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? contactHash = null,Object? expiresInMinutes = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,contactHash: null == contactHash ? _self.contactHash : contactHash // ignore: cast_nullable_to_non_nullable
as String,expiresInMinutes: null == expiresInMinutes ? _self.expiresInMinutes : expiresInMinutes // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QrModel].
extension QrModelPatterns on QrModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QrModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QrModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QrModel value)  $default,){
final _that = this;
switch (_that) {
case _QrModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QrModel value)?  $default,){
final _that = this;
switch (_that) {
case _QrModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  String contactHash,  String expiresInMinutes,  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QrModel() when $default != null:
return $default(_that.message,_that.contactHash,_that.expiresInMinutes,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  String contactHash,  String expiresInMinutes,  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _QrModel():
return $default(_that.message,_that.contactHash,_that.expiresInMinutes,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  String contactHash,  String expiresInMinutes,  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _QrModel() when $default != null:
return $default(_that.message,_that.contactHash,_that.expiresInMinutes,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QrModel implements QrModel {
  const _QrModel({this.message = '', this.contactHash = '', this.expiresInMinutes = '', this.createdAt = ''});
  factory _QrModel.fromJson(Map<String, dynamic> json) => _$QrModelFromJson(json);

@override@JsonKey() final  String message;
@override@JsonKey() final  String contactHash;
@override@JsonKey() final  String expiresInMinutes;
@override@JsonKey() final  String createdAt;

/// Create a copy of QrModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QrModelCopyWith<_QrModel> get copyWith => __$QrModelCopyWithImpl<_QrModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QrModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QrModel&&(identical(other.message, message) || other.message == message)&&(identical(other.contactHash, contactHash) || other.contactHash == contactHash)&&(identical(other.expiresInMinutes, expiresInMinutes) || other.expiresInMinutes == expiresInMinutes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,contactHash,expiresInMinutes,createdAt);

@override
String toString() {
  return 'QrModel(message: $message, contactHash: $contactHash, expiresInMinutes: $expiresInMinutes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$QrModelCopyWith<$Res> implements $QrModelCopyWith<$Res> {
  factory _$QrModelCopyWith(_QrModel value, $Res Function(_QrModel) _then) = __$QrModelCopyWithImpl;
@override @useResult
$Res call({
 String message, String contactHash, String expiresInMinutes, String createdAt
});




}
/// @nodoc
class __$QrModelCopyWithImpl<$Res>
    implements _$QrModelCopyWith<$Res> {
  __$QrModelCopyWithImpl(this._self, this._then);

  final _QrModel _self;
  final $Res Function(_QrModel) _then;

/// Create a copy of QrModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? contactHash = null,Object? expiresInMinutes = null,Object? createdAt = null,}) {
  return _then(_QrModel(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,contactHash: null == contactHash ? _self.contactHash : contactHash // ignore: cast_nullable_to_non_nullable
as String,expiresInMinutes: null == expiresInMinutes ? _self.expiresInMinutes : expiresInMinutes // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

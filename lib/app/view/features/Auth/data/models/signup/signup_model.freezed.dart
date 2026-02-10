// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
SignupModel _$SignupModelFromJson(Map<String, dynamic> json) {
  return _SignupUserModel.fromJson(json);
}

/// @nodoc
mixin _$SignupModel {
  int get userId;
  String get username;
  String get email;
  String get dateJoined;
  String get accessToken;
  String get refreshToken;
  String get message;

  /// Create a copy of SignupModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignupModelCopyWith<SignupModel> get copyWith =>
      _$SignupModelCopyWithImpl<SignupModel>(this as SignupModel, _$identity);

  /// Serializes this SignupModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignupModel &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.dateJoined, dateJoined) ||
                other.dateJoined == dateJoined) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, username, email,
      dateJoined, accessToken, refreshToken, message);

  @override
  String toString() {
    return 'SignupModel(userId: $userId, username: $username, email: $email, dateJoined: $dateJoined, accessToken: $accessToken, refreshToken: $refreshToken, message: $message)';
  }
}

/// @nodoc
abstract mixin class $SignupModelCopyWith<$Res> {
  factory $SignupModelCopyWith(
          SignupModel value, $Res Function(SignupModel) _then) =
      _$SignupModelCopyWithImpl;
  @useResult
  $Res call(
      {int userId,
      String username,
      String email,
      String dateJoined,
      String accessToken,
      String refreshToken,
      String message});
}

/// @nodoc
class _$SignupModelCopyWithImpl<$Res> implements $SignupModelCopyWith<$Res> {
  _$SignupModelCopyWithImpl(this._self, this._then);

  final SignupModel _self;
  final $Res Function(SignupModel) _then;

  /// Create a copy of SignupModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? email = null,
    Object? dateJoined = null,
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? message = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      dateJoined: null == dateJoined
          ? _self.dateJoined
          : dateJoined // ignore: cast_nullable_to_non_nullable
              as String,
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SignupModel].
extension SignupModelPatterns on SignupModel {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SignupUserModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SignupUserModel() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SignupUserModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignupUserModel():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SignupUserModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignupUserModel() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int userId,
            String username,
            String email,
            String dateJoined,
            String accessToken,
            String refreshToken,
            String message)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SignupUserModel() when $default != null:
        return $default(
            _that.userId,
            _that.username,
            _that.email,
            _that.dateJoined,
            _that.accessToken,
            _that.refreshToken,
            _that.message);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int userId,
            String username,
            String email,
            String dateJoined,
            String accessToken,
            String refreshToken,
            String message)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignupUserModel():
        return $default(
            _that.userId,
            _that.username,
            _that.email,
            _that.dateJoined,
            _that.accessToken,
            _that.refreshToken,
            _that.message);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int userId,
            String username,
            String email,
            String dateJoined,
            String accessToken,
            String refreshToken,
            String message)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignupUserModel() when $default != null:
        return $default(
            _that.userId,
            _that.username,
            _that.email,
            _that.dateJoined,
            _that.accessToken,
            _that.refreshToken,
            _that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SignupUserModel implements SignupModel {
  const _SignupUserModel(
      {this.userId = 0,
      this.username = '',
      this.email = '',
      this.dateJoined = '',
      this.accessToken = '',
      this.refreshToken = '',
      this.message = ''});
  factory _SignupUserModel.fromJson(Map<String, dynamic> json) =>
      _$SignupUserModelFromJson(json);

  @override
  @JsonKey()
  final int userId;
  @override
  @JsonKey()
  final String username;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String dateJoined;
  @override
  @JsonKey()
  final String accessToken;
  @override
  @JsonKey()
  final String refreshToken;
  @override
  @JsonKey()
  final String message;

  /// Create a copy of SignupModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SignupUserModelCopyWith<_SignupUserModel> get copyWith =>
      __$SignupUserModelCopyWithImpl<_SignupUserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SignupUserModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignupUserModel &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.dateJoined, dateJoined) ||
                other.dateJoined == dateJoined) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, username, email,
      dateJoined, accessToken, refreshToken, message);

  @override
  String toString() {
    return 'SignupModel(userId: $userId, username: $username, email: $email, dateJoined: $dateJoined, accessToken: $accessToken, refreshToken: $refreshToken, message: $message)';
  }
}

/// @nodoc
abstract mixin class _$SignupUserModelCopyWith<$Res>
    implements $SignupModelCopyWith<$Res> {
  factory _$SignupUserModelCopyWith(
          _SignupUserModel value, $Res Function(_SignupUserModel) _then) =
      __$SignupUserModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int userId,
      String username,
      String email,
      String dateJoined,
      String accessToken,
      String refreshToken,
      String message});
}

/// @nodoc
class __$SignupUserModelCopyWithImpl<$Res>
    implements _$SignupUserModelCopyWith<$Res> {
  __$SignupUserModelCopyWithImpl(this._self, this._then);

  final _SignupUserModel _self;
  final $Res Function(_SignupUserModel) _then;

  /// Create a copy of SignupModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? email = null,
    Object? dateJoined = null,
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? message = null,
  }) {
    return _then(_SignupUserModel(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      dateJoined: null == dateJoined
          ? _self.dateJoined
          : dateJoined // ignore: cast_nullable_to_non_nullable
              as String,
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on

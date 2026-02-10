// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignupState implements DiagnosticableTreeMixin {
  Blocstatus? get signupStatus;
  Blocstatus? get sendOtpStatus;
  Blocstatus? get verifyOtpStatus;
  String get errorMessage;
  String get successMessage;

  /// Create a copy of SignupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignupStateCopyWith<SignupState> get copyWith =>
      _$SignupStateCopyWithImpl<SignupState>(this as SignupState, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'SignupState'))
      ..add(DiagnosticsProperty('signupStatus', signupStatus))
      ..add(DiagnosticsProperty('sendOtpStatus', sendOtpStatus))
      ..add(DiagnosticsProperty('verifyOtpStatus', verifyOtpStatus))
      ..add(DiagnosticsProperty('errorMessage', errorMessage))
      ..add(DiagnosticsProperty('successMessage', successMessage));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignupState &&
            (identical(other.signupStatus, signupStatus) ||
                other.signupStatus == signupStatus) &&
            (identical(other.sendOtpStatus, sendOtpStatus) ||
                other.sendOtpStatus == sendOtpStatus) &&
            (identical(other.verifyOtpStatus, verifyOtpStatus) ||
                other.verifyOtpStatus == verifyOtpStatus) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, signupStatus, sendOtpStatus,
      verifyOtpStatus, errorMessage, successMessage);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SignupState(signupStatus: $signupStatus, sendOtpStatus: $sendOtpStatus, verifyOtpStatus: $verifyOtpStatus, errorMessage: $errorMessage, successMessage: $successMessage)';
  }
}

/// @nodoc
abstract mixin class $SignupStateCopyWith<$Res> {
  factory $SignupStateCopyWith(
          SignupState value, $Res Function(SignupState) _then) =
      _$SignupStateCopyWithImpl;
  @useResult
  $Res call(
      {Blocstatus? signupStatus,
      Blocstatus? sendOtpStatus,
      Blocstatus? verifyOtpStatus,
      String errorMessage,
      String successMessage});
}

/// @nodoc
class _$SignupStateCopyWithImpl<$Res> implements $SignupStateCopyWith<$Res> {
  _$SignupStateCopyWithImpl(this._self, this._then);

  final SignupState _self;
  final $Res Function(SignupState) _then;

  /// Create a copy of SignupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signupStatus = freezed,
    Object? sendOtpStatus = freezed,
    Object? verifyOtpStatus = freezed,
    Object? errorMessage = null,
    Object? successMessage = null,
  }) {
    return _then(_self.copyWith(
      signupStatus: freezed == signupStatus
          ? _self.signupStatus
          : signupStatus // ignore: cast_nullable_to_non_nullable
              as Blocstatus?,
      sendOtpStatus: freezed == sendOtpStatus
          ? _self.sendOtpStatus
          : sendOtpStatus // ignore: cast_nullable_to_non_nullable
              as Blocstatus?,
      verifyOtpStatus: freezed == verifyOtpStatus
          ? _self.verifyOtpStatus
          : verifyOtpStatus // ignore: cast_nullable_to_non_nullable
              as Blocstatus?,
      errorMessage: null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      successMessage: null == successMessage
          ? _self.successMessage
          : successMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SignupState].
extension SignupStatePatterns on SignupState {
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
    TResult Function(_SignUpState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SignUpState() when $default != null:
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
    TResult Function(_SignUpState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignUpState():
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
    TResult? Function(_SignUpState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignUpState() when $default != null:
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
            Blocstatus? signupStatus,
            Blocstatus? sendOtpStatus,
            Blocstatus? verifyOtpStatus,
            String errorMessage,
            String successMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SignUpState() when $default != null:
        return $default(_that.signupStatus, _that.sendOtpStatus,
            _that.verifyOtpStatus, _that.errorMessage, _that.successMessage);
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
            Blocstatus? signupStatus,
            Blocstatus? sendOtpStatus,
            Blocstatus? verifyOtpStatus,
            String errorMessage,
            String successMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignUpState():
        return $default(_that.signupStatus, _that.sendOtpStatus,
            _that.verifyOtpStatus, _that.errorMessage, _that.successMessage);
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
            Blocstatus? signupStatus,
            Blocstatus? sendOtpStatus,
            Blocstatus? verifyOtpStatus,
            String errorMessage,
            String successMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignUpState() when $default != null:
        return $default(_that.signupStatus, _that.sendOtpStatus,
            _that.verifyOtpStatus, _that.errorMessage, _that.successMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SignUpState with DiagnosticableTreeMixin implements SignupState {
  const _SignUpState(
      {this.signupStatus,
      this.sendOtpStatus,
      this.verifyOtpStatus,
      this.errorMessage = '',
      this.successMessage = ''});

  @override
  final Blocstatus? signupStatus;
  @override
  final Blocstatus? sendOtpStatus;
  @override
  final Blocstatus? verifyOtpStatus;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  @JsonKey()
  final String successMessage;

  /// Create a copy of SignupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SignUpStateCopyWith<_SignUpState> get copyWith =>
      __$SignUpStateCopyWithImpl<_SignUpState>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'SignupState'))
      ..add(DiagnosticsProperty('signupStatus', signupStatus))
      ..add(DiagnosticsProperty('sendOtpStatus', sendOtpStatus))
      ..add(DiagnosticsProperty('verifyOtpStatus', verifyOtpStatus))
      ..add(DiagnosticsProperty('errorMessage', errorMessage))
      ..add(DiagnosticsProperty('successMessage', successMessage));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignUpState &&
            (identical(other.signupStatus, signupStatus) ||
                other.signupStatus == signupStatus) &&
            (identical(other.sendOtpStatus, sendOtpStatus) ||
                other.sendOtpStatus == sendOtpStatus) &&
            (identical(other.verifyOtpStatus, verifyOtpStatus) ||
                other.verifyOtpStatus == verifyOtpStatus) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, signupStatus, sendOtpStatus,
      verifyOtpStatus, errorMessage, successMessage);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SignupState(signupStatus: $signupStatus, sendOtpStatus: $sendOtpStatus, verifyOtpStatus: $verifyOtpStatus, errorMessage: $errorMessage, successMessage: $successMessage)';
  }
}

/// @nodoc
abstract mixin class _$SignUpStateCopyWith<$Res>
    implements $SignupStateCopyWith<$Res> {
  factory _$SignUpStateCopyWith(
          _SignUpState value, $Res Function(_SignUpState) _then) =
      __$SignUpStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Blocstatus? signupStatus,
      Blocstatus? sendOtpStatus,
      Blocstatus? verifyOtpStatus,
      String errorMessage,
      String successMessage});
}

/// @nodoc
class __$SignUpStateCopyWithImpl<$Res> implements _$SignUpStateCopyWith<$Res> {
  __$SignUpStateCopyWithImpl(this._self, this._then);

  final _SignUpState _self;
  final $Res Function(_SignUpState) _then;

  /// Create a copy of SignupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? signupStatus = freezed,
    Object? sendOtpStatus = freezed,
    Object? verifyOtpStatus = freezed,
    Object? errorMessage = null,
    Object? successMessage = null,
  }) {
    return _then(_SignUpState(
      signupStatus: freezed == signupStatus
          ? _self.signupStatus
          : signupStatus // ignore: cast_nullable_to_non_nullable
              as Blocstatus?,
      sendOtpStatus: freezed == sendOtpStatus
          ? _self.sendOtpStatus
          : sendOtpStatus // ignore: cast_nullable_to_non_nullable
              as Blocstatus?,
      verifyOtpStatus: freezed == verifyOtpStatus
          ? _self.verifyOtpStatus
          : verifyOtpStatus // ignore: cast_nullable_to_non_nullable
              as Blocstatus?,
      errorMessage: null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      successMessage: null == successMessage
          ? _self.successMessage
          : successMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on

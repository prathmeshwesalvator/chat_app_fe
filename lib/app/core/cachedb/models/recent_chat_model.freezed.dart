// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recent_chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecentChatModel {
  String get chatId;
  String get peerUserId;
  String get peerUsername;
  String get lastMessage;
  String get lastMessageTime;
  int get unreadCount;

  /// Create a copy of RecentChatModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecentChatModelCopyWith<RecentChatModel> get copyWith =>
      _$RecentChatModelCopyWithImpl<RecentChatModel>(
          this as RecentChatModel, _$identity);

  /// Serializes this RecentChatModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecentChatModel &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.peerUserId, peerUserId) ||
                other.peerUserId == peerUserId) &&
            (identical(other.peerUsername, peerUsername) ||
                other.peerUsername == peerUsername) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageTime, lastMessageTime) ||
                other.lastMessageTime == lastMessageTime) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chatId, peerUserId, peerUsername,
      lastMessage, lastMessageTime, unreadCount);

  @override
  String toString() {
    return 'RecentChatModel(chatId: $chatId, peerUserId: $peerUserId, peerUsername: $peerUsername, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, unreadCount: $unreadCount)';
  }
}

/// @nodoc
abstract mixin class $RecentChatModelCopyWith<$Res> {
  factory $RecentChatModelCopyWith(
          RecentChatModel value, $Res Function(RecentChatModel) _then) =
      _$RecentChatModelCopyWithImpl;
  @useResult
  $Res call(
      {String chatId,
      String peerUserId,
      String peerUsername,
      String lastMessage,
      String lastMessageTime,
      int unreadCount});
}

/// @nodoc
class _$RecentChatModelCopyWithImpl<$Res>
    implements $RecentChatModelCopyWith<$Res> {
  _$RecentChatModelCopyWithImpl(this._self, this._then);

  final RecentChatModel _self;
  final $Res Function(RecentChatModel) _then;

  /// Create a copy of RecentChatModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
    Object? peerUserId = null,
    Object? peerUsername = null,
    Object? lastMessage = null,
    Object? lastMessageTime = null,
    Object? unreadCount = null,
  }) {
    return _then(_self.copyWith(
      chatId: null == chatId
          ? _self.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      peerUserId: null == peerUserId
          ? _self.peerUserId
          : peerUserId // ignore: cast_nullable_to_non_nullable
              as String,
      peerUsername: null == peerUsername
          ? _self.peerUsername
          : peerUsername // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: null == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageTime: null == lastMessageTime
          ? _self.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as String,
      unreadCount: null == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [RecentChatModel].
extension RecentChatModelPatterns on RecentChatModel {
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
    TResult Function(_RecentChatModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecentChatModel() when $default != null:
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
    TResult Function(_RecentChatModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentChatModel():
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
    TResult? Function(_RecentChatModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentChatModel() when $default != null:
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
    TResult Function(String chatId, String peerUserId, String peerUsername,
            String lastMessage, String lastMessageTime, int unreadCount)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecentChatModel() when $default != null:
        return $default(_that.chatId, _that.peerUserId, _that.peerUsername,
            _that.lastMessage, _that.lastMessageTime, _that.unreadCount);
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
    TResult Function(String chatId, String peerUserId, String peerUsername,
            String lastMessage, String lastMessageTime, int unreadCount)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentChatModel():
        return $default(_that.chatId, _that.peerUserId, _that.peerUsername,
            _that.lastMessage, _that.lastMessageTime, _that.unreadCount);
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
    TResult? Function(String chatId, String peerUserId, String peerUsername,
            String lastMessage, String lastMessageTime, int unreadCount)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentChatModel() when $default != null:
        return $default(_that.chatId, _that.peerUserId, _that.peerUsername,
            _that.lastMessage, _that.lastMessageTime, _that.unreadCount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RecentChatModel implements RecentChatModel {
  const _RecentChatModel(
      {this.chatId = '',
      this.peerUserId = '',
      this.peerUsername = '',
      this.lastMessage = '',
      this.lastMessageTime = '',
      this.unreadCount = 0});
  factory _RecentChatModel.fromJson(Map<String, dynamic> json) =>
      _$RecentChatModelFromJson(json);

  @override
  @JsonKey()
  final String chatId;
  @override
  @JsonKey()
  final String peerUserId;
  @override
  @JsonKey()
  final String peerUsername;
  @override
  @JsonKey()
  final String lastMessage;
  @override
  @JsonKey()
  final String lastMessageTime;
  @override
  @JsonKey()
  final int unreadCount;

  /// Create a copy of RecentChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecentChatModelCopyWith<_RecentChatModel> get copyWith =>
      __$RecentChatModelCopyWithImpl<_RecentChatModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RecentChatModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecentChatModel &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.peerUserId, peerUserId) ||
                other.peerUserId == peerUserId) &&
            (identical(other.peerUsername, peerUsername) ||
                other.peerUsername == peerUsername) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageTime, lastMessageTime) ||
                other.lastMessageTime == lastMessageTime) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chatId, peerUserId, peerUsername,
      lastMessage, lastMessageTime, unreadCount);

  @override
  String toString() {
    return 'RecentChatModel(chatId: $chatId, peerUserId: $peerUserId, peerUsername: $peerUsername, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, unreadCount: $unreadCount)';
  }
}

/// @nodoc
abstract mixin class _$RecentChatModelCopyWith<$Res>
    implements $RecentChatModelCopyWith<$Res> {
  factory _$RecentChatModelCopyWith(
          _RecentChatModel value, $Res Function(_RecentChatModel) _then) =
      __$RecentChatModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String chatId,
      String peerUserId,
      String peerUsername,
      String lastMessage,
      String lastMessageTime,
      int unreadCount});
}

/// @nodoc
class __$RecentChatModelCopyWithImpl<$Res>
    implements _$RecentChatModelCopyWith<$Res> {
  __$RecentChatModelCopyWithImpl(this._self, this._then);

  final _RecentChatModel _self;
  final $Res Function(_RecentChatModel) _then;

  /// Create a copy of RecentChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? chatId = null,
    Object? peerUserId = null,
    Object? peerUsername = null,
    Object? lastMessage = null,
    Object? lastMessageTime = null,
    Object? unreadCount = null,
  }) {
    return _then(_RecentChatModel(
      chatId: null == chatId
          ? _self.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      peerUserId: null == peerUserId
          ? _self.peerUserId
          : peerUserId // ignore: cast_nullable_to_non_nullable
              as String,
      peerUsername: null == peerUsername
          ? _self.peerUsername
          : peerUsername // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: null == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageTime: null == lastMessageTime
          ? _self.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as String,
      unreadCount: null == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on

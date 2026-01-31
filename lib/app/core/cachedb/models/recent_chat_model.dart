import 'package:freezed_annotation/freezed_annotation.dart';
part 'recent_chat_model.freezed.dart';
part 'recent_chat_model.g.dart';

@freezed
abstract class RecentChatModel with _$RecentChatModel {
  const factory RecentChatModel({
    @Default('') final String chatId,
    @Default('') final String peerUserId,
    @Default('') final String peerUsername,
    @Default('') final String lastMessage,
    @Default('') final String lastMessageTime,
    @Default(0) final int unreadCount,
  }) = _RecentChatModel;

  factory RecentChatModel.fromJson(Map<String, dynamic> json) =>
      _$RecentChatModelFromJson(json);
}

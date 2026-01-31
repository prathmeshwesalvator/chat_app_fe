// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecentChatModel _$RecentChatModelFromJson(Map<String, dynamic> json) =>
    _RecentChatModel(
      chatId: json['chatId'] as String? ?? '',
      peerUserId: json['peerUserId'] as String? ?? '',
      peerUsername: json['peerUsername'] as String? ?? '',
      lastMessage: json['lastMessage'] as String? ?? '',
      lastMessageTime: json['lastMessageTime'] as String? ?? '',
      unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RecentChatModelToJson(_RecentChatModel instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'peerUserId': instance.peerUserId,
      'peerUsername': instance.peerUsername,
      'lastMessage': instance.lastMessage,
      'lastMessageTime': instance.lastMessageTime,
      'unreadCount': instance.unreadCount,
    };

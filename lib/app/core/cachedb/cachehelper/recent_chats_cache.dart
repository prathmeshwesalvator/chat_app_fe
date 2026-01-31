import 'package:chat_app_fe/app/core/cachedb/file%20storage/file_storage.dart';
import 'package:chat_app_fe/app/core/cachedb/models/recent_chat_model.dart';

class RecentChatsCache {
  static const _filePath = 'chats/recent_chats.json';
  static const _version = 1;
  static const _ttl = Duration(minutes: 10);
  static const _maxChats = 50;

  List<RecentChatModel>? _memoryCache;

  /// READ
  Future<List<RecentChatModel>> getChats() async {
    if (_memoryCache != null) return _memoryCache!;

    final json = await FileStorage.readJson(_filePath);
    if (json == null) return [];

    final expiresAt = DateTime.parse(json['expiresAt']);
    if (DateTime.now().isAfter(expiresAt)) {
      await clear();
      return [];
    }

    final items = (json['items'] as List)
        .map((e) => RecentChatModel.fromJson(e))
        .toList();

    _memoryCache = items;
    return items;
  }

  /// WRITE
  Future<void> saveChats(List<RecentChatModel> chats) async {
    chats.sort(
      (a, b) => b.lastMessageTime.compareTo(a.lastMessageTime),
    );

    final trimmed = chats.take(_maxChats).toList();

    _memoryCache = trimmed;

    await FileStorage.writeJson(_filePath, {
      'version': _version,
      'createdAt': DateTime.now().toIso8601String(),
      'expiresAt': DateTime.now().add(_ttl).toIso8601String(),
      'items': trimmed.map((e) => e.toJson()).toList(),
    });
  }

  /// MERGE (new message / update)
  Future<void> upsertChat(RecentChatModel chat) async {
    final chats = await getChats();

    chats.removeWhere((c) => c.chatId == chat.chatId);
    chats.insert(0, chat);

    await saveChats(chats);
  }

  /// CLEAR
  Future<void> clear() async {
    _memoryCache = null;
    await FileStorage.delete(_filePath);
  }
}

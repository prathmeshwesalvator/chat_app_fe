import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileStorage {
  static Future<Directory> _baseCacheDir() async {
    final dir = await getTemporaryDirectory();
    return Directory('${dir.path}/app_cache');
  }

  static Future<File> _resolveFile(String relativePath) async {
    final baseDir = await _baseCacheDir();
    return File('${baseDir.path}/$relativePath');
  }

  static Future<void> _ensureParentDir(File file) async {
    final parent = file.parent;
    if (!await parent.exists()) {
      await parent.create(recursive: true);
    }
  }

  static Future<void> writeJson(
    String relativePath,
    Map<String, dynamic> json,
  ) async {
    final file = await _resolveFile(relativePath);
    await _ensureParentDir(file);

    final tempFile = File('${file.path}.tmp');

    await tempFile.writeAsString(
      jsonEncode(json),
      flush: true,
    );

    await tempFile.rename(file.path);
  }

  static Future<Map<String, dynamic>?> readJson(
    String relativePath,
  ) async {
    final file = await _resolveFile(relativePath);

    if (!await file.exists()) return null;

    try {
      final content = await file.readAsString();
      if (content.isEmpty) return null;

      final decoded = jsonDecode(content);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<void> delete(String relativePath) async {
    final file = await _resolveFile(relativePath);

    if (await file.exists()) {
      await file.delete();
    }
  }

  static Future<void> clearAll() async {
    final baseDir = await _baseCacheDir();

    if (await baseDir.exists()) {
      await baseDir.delete(recursive: true);
    }
  }
}

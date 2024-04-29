import 'package:kayobot/src/kayobot.dart';
import 'package:nyxx/nyxx.dart' hide Cache;

import '../cache.dart';

class StickerService {
  static final StickerService _instance = StickerService._();
  late final Cache<String, Snowflake> _cache;

  factory StickerService() => _instance;

  StickerService._() {
    _cache = Cache(ttl: Duration(hours: 1), retrieve: _findStickerByName);
  }

  Future<Snowflake> getSticker(String name) async =>
      (await _cache.get(name) ?? Snowflake.zero);

  Future<Snowflake> _findStickerByName(String stickerName) async {
    var guilds = KayoBot().client.guilds.cache.values.toList();
    for (var guild in guilds) {
      for (var sticker in guild.stickerList) {
        if (sticker.name == stickerName) {
          return sticker.id;
        }
      }
    }

    return Snowflake.zero;
  }
}

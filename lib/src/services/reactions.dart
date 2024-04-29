import 'dart:math';

import 'package:nyxx/nyxx.dart';

import '../events.dart';
import '../kayobot.dart';
import '../style.dart';
import '../util.dart';
import 'stickers.dart';

const penguinDiscord = Snowflake(895861645665009725);

class AutoreactService {
  static late final AutoreactService _instance;
  static final splitPattern = RegExp(r"\s+");

  static void init() {
    _instance = AutoreactService._();
  }

  factory AutoreactService() => _instance;

  final Map<String, Reaction> _index = {};
  final Logger logger = Logger("AutoreactService");

  AutoreactService._() {
    eventBus
        .on<MessageCreateEvent>()
        .where(messagePredicate)
        .listen(reactToMessage);

    _createIndex();
  }

  bool messagePredicate(MessageCreateEvent event) {
    // If discord didn't give us message content (due to insufficient permissions),
    // then don't pass to the react function
    if (event.message.content.isEmpty) {
      return false;
    }

    if (event.guildId == penguinDiscord) {
      return true;
    }

    // Check if we're mentioned
    if (event.mentions.any((u) => u.id == KayoBot().userId)) {
      return true;
    }

    return false;
  }

  /// Applies each reaction to the message [event.message]
  Future<void> reactToMessage(MessageCreateEvent event) async {
    var content = event.message.content;

    // Replace the neonbot mention with neonbot
    if (event.mentions.any((u) => u.id == KayoBot().userId)) {
      content =
          content.replaceFirst(KayoBot().userId.userMention ?? "", "neonbot");
    }

    var reactions = content
        .split(splitPattern)
        .map((word) => word.trim().toLowerCase())
        .map((word) => _index[word])
        .nonNulls
        .toSet(); // Remove duplicates

    for (var reaction in reactions) {
      await reaction.react(event.message);
    }
  }

  void _createIndex() {
    for (var reaction in Reactions.reactions) {
      _index[reaction.keyword] = reaction;
    }
  }
}

abstract class Reaction {
  final String keyword;

  Reaction(this.keyword);

  Future<void> react(Message message);

  @override
  int get hashCode => keyword.hashCode;

  @override
  bool operator ==(other) => other is Reaction && keyword == other.keyword;
}

class SingleReaction extends Reaction {
  final ReactionBuilder emoji;

  SingleReaction(super.keyword, this.emoji);

  @override
  Future<void> react(Message message) async {
    await message.react(emoji);
  }

  @override
  String toString() => "SingleReaction($keyword)";
}

class MultiReaction extends Reaction {
  final List<ReactionBuilder> emojis;

  MultiReaction(super.keyword, this.emojis);

  @override
  Future<void> react(Message message) async {
    for (var emoji in emojis) {
      await message.react(emoji);
    }
  }

  @override
  String toString() => "MultiReaction($keyword)";
}

class StickerReaction extends Reaction {
  final String stickerName;

  StickerReaction(super.keyword, this.stickerName);

  @override
  Future<void> react(Message message) async {
    var stickerId = await StickerService().getSticker(stickerName);

    if (stickerId != Snowflake.zero) {
      await message.channel
          .sendMessage(MessageBuilder(stickerIds: [stickerId]));
    }
  }
}

class RandomReaction extends MultiReaction {
  RandomReaction(super.keyword, super.emojis);

  @override
  Future<void> react(Message message) async {
    var index = Random().nextInt(emojis.length);
    await message.react(emojis[index]);
  }

  @override
  String toString() => "RandomReaction($keyword)";
}

class Reactions {
  static final List<Reaction> reactions = [
    SingleReaction("cornball", Emojis.discord("🌽")),
    SingleReaction("blastx", Emojis.discord("🤮")),
    SingleReaction("wukong", Emojis.thatsWukong),
    SingleReaction("ctf", Emojis.stop),
    StickerReaction("yoru", "yoru_roll")
  ];
}

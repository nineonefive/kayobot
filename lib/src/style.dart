import 'package:nyxx/nyxx.dart';

class Colors {
  static final primary = DiscordColor.parseHexString('#03fccf');
}

final botFooter = EmbedFooterBuilder(text: "Made with 💙 by 915");

class Emojis {
  static final thatsWukong =
      ReactionBuilder(name: 'thats_wukong', id: Snowflake(1215420386401849425));

  static final stop =
      ReactionBuilder(name: 'stop', id: Snowflake(1233542403038908417));

  static final isoUlt =
      ReactionBuilder(name: 'isoult', id: Snowflake(1234212228853534751));

  static final squidCopium =
      ReactionBuilder(name: 'squid_copium', id: Snowflake(1135074095764082769));

  static final oliveAngry =
      ReactionBuilder(name: 'OliveAngry', id: Snowflake(1003886681159635005));

  static final deadlockMoment = ReactionBuilder(
      name: 'deadlockmoment', id: Snowflake(1216586330801176606));

  static final gup =
      ReactionBuilder(name: 'gup', id: Snowflake(1159258536560304209));

  static final glazeWarrior =
      ReactionBuilder(name: 'glazewarrior', id: Snowflake(1197739759657811968));

  static final mh676 =
      ReactionBuilder(name: 'mh676', id: Snowflake(1106797249306050651));

  static final lethalCompanyBoombox = ReactionBuilder(
      name: 'LethalCompanyBoombox', id: Snowflake(1196684914221928518));

  static final jeffWhat =
      ReactionBuilder(name: 'jeffwhat', id: Snowflake(1164717515977527307));

  static ReactionBuilder discord(String unicode) =>
      ReactionBuilder(name: unicode, id: null);
}

extension Emoji on ReactionBuilder {
  String get emoteString => id == null ? build() : '<:${build()}>';
}

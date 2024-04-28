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

  static discord(String unicode) => ReactionBuilder(name: unicode, id: null);
}

extension Emoji on ReactionBuilder {
  String get emoteString => '<:${build()}>';
}

import 'package:nyxx/nyxx.dart';

class Colors {
  static final primary = DiscordColor.parseHexString('#03fccf');
}

final botFooter = EmbedFooterBuilder(text: "Made with 💙 by 915");

class Emojis {
  static discord(String unicode) => ReactionBuilder(name: unicode, id: null);
}

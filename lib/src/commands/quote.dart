import 'dart:async';
import 'dart:math';

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

import '../services/stickers.dart';
import '../style.dart';

final availableQuotes = [
  StringQuote("Cornball! ${Emojis.mh676.emoteString}"),
  StringQuote(
      "That's Wukong, from League of Legends! ${Emojis.thatsWukong.emoteString}"),
  StringQuote("Pistol rounds don't count ${Emojis.squidCopium.emoteString}"),
  StringQuote("It's so free! 🦑"),
  StringQuote("ez wp gf L ⚡"),
  StringQuote("NO ${Emojis.oliveAngry.emoteString}"),
  StringQuote("Deadlock moment ${Emojis.deadlockMoment.emoteString}"),
  StringQuote("Green Fortnite"),
  StringQuote("Any gup fans in the chat? ${Emojis.gup.emoteString}"),
  StringQuote(
      "Loot positive mindset ${Emojis.lethalCompanyBoombox.emoteString}"),
  StringQuote("🪿🥚${Emojis.glazeWarrior.emoteString}"),
  StringQuote("Mama mia"),
  StringQuote("Your tribe has spoken ${Emojis.jeffWhat.emoteString}"),
  StringQuote("Comcast moment ${Emojis.lag.emoteString}"),
  StickerQuote("5 nights at Breeze")
];

abstract class Quote {
  FutureOr<MessageBuilder> get message;
}

class StringQuote extends Quote {
  final String quote;

  StringQuote(this.quote);

  @override
  FutureOr<MessageBuilder> get message => MessageBuilder(content: quote);
}

class StickerQuote extends Quote {
  final String stickerName;

  StickerQuote(this.stickerName);

  @override
  FutureOr<MessageBuilder> get message async {
    var stickerId = await StickerService().getSticker(stickerName);
    return MessageBuilder(stickerIds: [stickerId]);
  }
}

final quote = ChatCommand(
    'quote',
    'Get a random quote',
    id('quote', (ChatContext context) async {
      var quote = availableQuotes[Random().nextInt(availableQuotes.length)];
      await context.respond(await quote.message);
    }));

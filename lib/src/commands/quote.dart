import 'dart:math';

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

import '../style.dart';

final availableQuotes = [
  "Cornball! ${Emojis.mh676.emoteString}",
  "That's Wukong, from League of Legends! ${Emojis.thatsWukong.emoteString}",
  "Pistol rounds don't count ${Emojis.squidCopium.emoteString}",
  "It's so free! 🦑",
  "ez wp gf L ⚡",
  "NO ${Emojis.oliveAngry.emoteString}",
  "Deadlock moment ${Emojis.deadlockMoment.emoteString}",
  "Green Fortnite",
  "Any gup fans in the chat? ${Emojis.gup.emoteString}",
  "Loot positive mindset ${Emojis.lethalCompanyBoombox.emoteString}",
  "🪿🥚${Emojis.glazeWarrior.emoteString}",
  "Mama mia",
  "Your tribe has spoken ${Emojis.jeffWhat.emoteString}"
];

final quote = ChatCommand(
    'quote',
    'Get a random quote',
    id('quote', (ChatContext context) async {
      var quote = availableQuotes[Random().nextInt(availableQuotes.length)];
      await context.respond(MessageBuilder(content: quote));
    }));

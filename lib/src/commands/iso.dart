import 'dart:math';

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

import '../style.dart';
import '../util.dart';

final isoUlt = ChatCommand(
    "ult",
    "Challenges your opponent to an Iso duel",
    id('iso-ult', (ChatContext context,
        @Description("The user to challenge") User user) async {
      var iso = context.user;
      var victor = Random().nextInt(2) == 0 ? iso : user;
      await context.respond(MessageBuilder(
          content:
              "${Emojis.isoUlt.emoteString} ${victor.id.userMention ?? 'error'} has won the duel!",
          allowedMentions: AllowedMentions.users([]),
          suppressNotifications: true));
    }));

final iso = ChatGroup('iso', 'Iso-related commands', children: [isoUlt]);

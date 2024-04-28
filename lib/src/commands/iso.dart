import 'dart:math';

import 'package:kayobot/src/util.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

final isoUlt = ChatCommand(
    "ult",
    "Challenges your opponent to an Iso duel",
    id('iso-ult', (ChatContext context,
        @Description("The user to challenge") User user) async {
      var iso = context.user;
      var victor = Random().nextInt(2) == 0 ? iso : user;
      await context.respond(MessageBuilder(
          content: "${victor.id.userMention ?? 'error'} has won the duel!"));
    }));

final iso = ChatGroup('iso', 'Iso-related commands', children: [isoUlt]);
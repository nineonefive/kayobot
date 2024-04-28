import 'dart:async';

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
export 'commands/iso.dart' show iso;

Future<void> errorHandler(error) async {
  if (error is CheckFailedException) {
    error.context.respond(
        MessageBuilder(content: ":x: Sorry, you can't use that command!"));
  }
}

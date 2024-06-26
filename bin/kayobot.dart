import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:kayobot/src/kayobot.dart';

const String version = '0.0.1';

ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'version',
      negatable: false,
      help: 'Print the tool version.',
    )
    ..addFlag('debug', negatable: false, help: 'Enable debug mode.');
}

void printUsage(ArgParser argParser) {
  print('Usage: dart kayobot.dart <flags> [arguments]');
  print(argParser.usage);
}

void main(List<String> arguments) async {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);
    if (results.wasParsed('version')) {
      print('kayobot version: $version');
      return;
    }

    // Configure logging
    Level logLevel = (results.wasParsed('debug')) ? Level.FINE : Level.INFO;
    configureLogging(logLevel);

    // Connect the bot to discord
    await KayoBot().connect();
  } on FormatException catch (e, stackTrace) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print(stackTrace);
    print('');
    printUsage(argParser);
  }
}

void configureLogging(Level logLevel) {
  hierarchicalLoggingEnabled = true;
  Logger.root.level = logLevel;
  KayoBot.logLevel = logLevel;
  Logger.root.onRecord.listen((record) {
    String msg;
    if (record.error != null) {
      msg =
          '[${record.loggerName}] ${record.level.name}: ${record.time}: ${record.message} ${record.error}';
    } else {
      msg =
          '[${record.loggerName}] ${record.level.name}: ${record.time}: ${record.message}';
    }
    print(msg);
  });
}

@Skip("Github doesn't have api keys")

import 'package:kayobot/src/services/credentials.dart';
import 'package:test/test.dart';

void main() {
  test('Test discord token', () async {
    // This should throw a StateError if none is found
    var discordToken = await CredentialsService().getToken("discord");
    expect(discordToken, isNotEmpty);
  });

  test('Test unknown token', () async {
    // This should throw a StateError
    expect(() => CredentialsService().getToken("unknown"), throwsStateError);
  });
}

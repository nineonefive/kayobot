# Update from github main branch
echo "Updating from github main branch"
git fetch && git reset --hard origin/main

# Generate deployment targets
echo "Building kayobot"
mkdir -p deploy
dart run nyxx_commands:compile -o kayobot.dart bin/kayobot.dart
mv kayobot.exe deploy/kayobot.exe
mv kayobot.dart deploy/kayobot.dart
cp api_keys.json deploy/api_keys.json

# Run kayobot in the deploy folder
echo "Running in deploy folder"
cd deploy
./kayobot.exe

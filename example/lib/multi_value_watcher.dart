import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watch All Example',
      home: UserSettingsPage(),
    );
  }
}

class UserSettingsPage extends StatelessWidget {
  final username = 'User123'.watcher;
  final notificationEnabled = true.watcher;
  final themeMode = ThemeMode.light.watcher;

  UserSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Settings'),
      ),
      body: WatchAll(
        watchers: [username, notificationEnabled, themeMode],
        builder: (context) {
          return ListView(
            children: [
              ListTile(
                title: Text('Username: ${username.value}'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    username.value = 'NewUser${1000.getRandom}';
                  },
                ),
              ),
              SwitchListTile(
                title: const Text('Notifications'),
                value: notificationEnabled.value,
                onChanged: (bool value) {
                  notificationEnabled.value = value;
                },
              ),
              ListTile(
                title: const Text('Theme Mode'),
                subtitle: Text(
                    'Current: ${themeMode.value.toString().split('.').last}'),
                onTap: () {
                  themeMode.value = themeMode.value == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

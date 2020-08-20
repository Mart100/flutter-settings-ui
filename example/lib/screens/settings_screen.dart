import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import 'languages_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings UI')),
      body: SettingsList(
        // backgroundColor: Colors.orange,
        sections: [
          SettingsSection(
            title: 'Common',
            // titleTextStyle: TextStyle(fontSize: 30),
            tiles: [
              SettingsTile(
                title: Text(
                  'Language',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  'English',
                  style: TextStyle(color: Colors.green),
                ),
                leading: Icon(Icons.language),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => LanguagesScreen()),
                  );
                },
              ),
              SettingsTile(
                title: Text('Environment'),
                subtitle: Text('Production'),
                leading: Icon(Icons.cloud_queue),
              ),
            ],
          ),
          SettingsSection(
            title: 'Account',
            tiles: [
              SettingsTile(title: Text('Phone number'), leading: Icon(Icons.phone)),
              SettingsTile(title: Text('Email'), leading: Icon(Icons.email)),
              SettingsTile(title: Text('Sign out'), leading: Icon(Icons.exit_to_app)),
            ],
          ),
          SettingsSection(
            title: 'Security',
            tiles: [
              SettingsTile.switchTile(
                title: Text('Lock app in background'),
                leading: Icon(Icons.phonelink_lock),
                switchValue: lockInBackground,
                switchActiveColor: Colors.green,
                onToggle: (bool value) {
                  setState(() {
                    lockInBackground = value;
                    notificationsEnabled = value;
                  });
                },
              ),
              SettingsTile.switchTile(
                title: Text('Use fingerprint'),
                leading: Icon(Icons.fingerprint),
                onToggle: (bool value) {},
                switchValue: false,
              ),
              SettingsTile.switchTile(
                title: Text('Change password'),
                leading: Icon(Icons.lock),
                switchValue: true,
                onToggle: (bool value) {},
              ),
              SettingsTile.switchTile(
                title: Text('Enable Notifications'),
                enabled: notificationsEnabled,
                leading: Icon(Icons.notifications_active),
                switchValue: true,
                onToggle: (value) {},
              ),
            ],
          ),
          SettingsSection(
            title: 'Misc',
            tiles: [
              SettingsTile(
                title: Text('Terms of Service'),
                leading: Icon(Icons.description),
              ),
              SettingsTile(
                title: Text('Open source licenses'),
                leading: Icon(Icons.collections_bookmark),
              ),
            ],
          )
        ],
      ),
    );
  }
}

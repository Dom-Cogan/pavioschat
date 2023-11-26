import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final storage = FlutterSecureStorage();
  bool useCustomDatabase = false; // Initialize with empty or saved password

  // Method to toggle custom database use
  void _toggleCustomDatabase(bool value) async {
    await storage.write(key: 'use_custom_database', value: value.toString());
    setState(() {
      useCustomDatabase = value;
    });
  }

  // Method to show setting input modal
  void _showSettingInputModal(String settingKey, String title) async {
    // Attempt to read the existing value from secure storage
    String? currentValue = await storage.read(key: settingKey);
    TextEditingController controller =
        TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter $settingKey"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () async {
                // Save the entered key in secure storage or state
                await storage.write(key: settingKey, value: controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadToggleState();
  }

  _loadToggleState() async {
    String? savedToggleValue = await storage.read(key: 'use_custom_database');
    bool savedToggle = savedToggleValue == 'true';
    setState(() {
      useCustomDatabase = savedToggle;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
            child: ElevatedButton(
              onPressed: () => _showSettingInputModal(
                  'Openai API Key', "Enter your Openai API Key"),
              child: Text('Openai APi Key'),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15), // Set the border radius here
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0),
              ),
            ),
          ),
          SwitchListTile(
            title: Text('Use Custom Database'),
            value: useCustomDatabase,
            onChanged: _toggleCustomDatabase,
          ),
          if (useCustomDatabase) ...[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Firebase Keys',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.count(
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 3 / 1,
              children: [
                'API Key',
                'App Id',
                'Messaging Sender Id',
                'Project Id',
                'Storage Bucket',
                'iOS Bundle Id',
                'Measurement Id',
                'Auth Domain'
              ].map((String key) {
                return GestureDetector(
                  onTap: () =>
                      _showSettingInputModal(key, "Enter your Firebase $key"),
                  child: Card(
                    elevation: 0,
                    color: Colors.grey,
                    margin: EdgeInsets.all(8),
                    child: Center(child: Text(key)),
                  ),
                );
              }).toList(),
            ),
          ],
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/auth');
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15), // Set the border radius here
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0),
              ),
              child:
                  Text(useCustomDatabase ? 'Log in to Default DB ' : 'Log in'),
            ),
          ),
        ],
      ),
    );
  }
}

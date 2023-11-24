import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pavischat/pages/settings.dart';
import 'package:pavischat/services/services.dart';

import './pages/newchat.dart';
import './services/firebaseService.dart';
import 'defaultFirebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: MyFirebaseOptions.options);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ChatService chatService = FirebaseChatService(); // Create the service

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pavios Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>
            ChatPage(chatService: chatService), // Inject the service
        '/settings': (context) =>
            SettingsPage(), // Define the settings page route
      },
    );
  }
}

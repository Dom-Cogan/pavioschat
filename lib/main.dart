import 'package:flutter/material.dart';
import 'package:pavischat/services/services.dart';
import './pages/newchat.dart';
import './pages/settings.dart'; // Import your settings page
import './services/firebaseService.dart';

void main() {
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
        '/': (context) => ChatPage(chatService: chatService), // Inject the service
        '/settings': (context) => SettingsPage(), // Define the settings page route
      },
    );
  }
}
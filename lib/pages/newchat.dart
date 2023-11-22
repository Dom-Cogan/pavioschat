import 'package:flutter/material.dart';
import '../components/menu.dart'; // Corrected import path
import '../services/services.dart'; // Import the ChatService interface

class ChatPage extends StatefulWidget {
  final ChatService chatService;

  ChatPage({required this.chatService}); // Accept the chatService as a parameter

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('New Chat'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: openDrawer,
        ),
        centerTitle: true,
      ),
      drawer: MenuDrawer(
        chatService: widget.chatService, // Pass the chatService to the MenuDrawer
        userName: 'User Name', // Replace with the actual user name from user profile
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                // Chat history log
                Text('Chat history log'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
            child: Row(
              children: <Widget>[
                // Attachment button
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {},
                ),
                // Input box
                Expanded(
                    child: Padding(
                      padding:  EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                      child:TextField(
                        style:  TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: const BorderSide(width: 2,), borderRadius: BorderRadius.circular(50)),
                          hintText: 'Start a new chat',
                        ),
                      ),
                    ),
                ),
                // Send button
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
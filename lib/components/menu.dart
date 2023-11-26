import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/authenticationService.dart'; // Import your authentication service
import '../services/services.dart'; // Import the ChatService interface

class MenuDrawer extends StatelessWidget {
  final ChatService chatService;
  final String userName;

  const MenuDrawer(
      {super.key, required this.chatService, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Other drawer headers or items can be added here
          Expanded(
            child: FutureBuilder<List<String>>(
              future: chatService.getChatNames(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  // List is empty
                  return const Center(
                      child: Text('No chats, create a new one'));
                } else {
                  // Data is fetched successfully, show your ListView
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(snapshot.data![index]),
                        onTap: () {
                          // Handle the chat item tap
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          FutureBuilder<User?>(
            future: Future.value(AuthenticationService().currentUser),
            builder: (context, AsyncSnapshot<User?> userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (userSnapshot.hasData && userSnapshot.data != null) {
                User currentUser = userSnapshot.data!;
                String userName =
                    currentUser.displayName ?? 'No Name'; // Use displayName
                return ListTile(
                  leading: CircleAvatar(child: Text(userName[0])),
                  title: Text(userName),
                  trailing:
                      Icon(Icons.schema_rounded), // Example: Database icon
                  onTap: () {
                    // Action on tap
                  },
                );
              } else {
                return ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

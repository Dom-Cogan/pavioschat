import 'package:flutter/material.dart';
import '../services/services.dart'; // Import the ChatService interface

class MenuDrawer extends StatelessWidget {
  final ChatService chatService;
  final String userName;

  MenuDrawer({required this.chatService, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Other drawer headers or items can be added here
          Expanded(
            child: FutureBuilder<List<String>>(
              future: chatService.getChatNames(),
              builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  // List is empty
                  return Center(child: Text('No chats, create a new one'));
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
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(userName),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}

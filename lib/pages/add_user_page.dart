import 'package:flutter/material.dart';
import 'package:talk/components/user_tile.dart';
import 'package:talk/services/auth/auth_service.dart';
import 'package:talk/services/chat/chat_service.dart';
import 'package:talk/services/contact_storage.dart';

class AddUserPage extends StatelessWidget {
  AddUserPage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  final storage = ContactStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Add User"),
        foregroundColor: Colors.grey.shade600,
        elevation: 0,
      ),
      body: _buildUserList(),
    );
  }

Widget _buildUserList() {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: storage.loadContacts(),
    builder: (context, contactSnapshot) {
      if (contactSnapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (contactSnapshot.hasError) {
        return const Center(child: Text("Error loading contacts"));
      }

      final contacts = contactSnapshot.data ?? [];

      final myEmails = contacts
          .map((contact) => contact['email'].toString().toLowerCase())
          .toSet();

      return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading users"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data ?? [];
          final currentEmail = _authService
              .getCurrentUser()
              ?.email
              ?.toLowerCase();

          final filteredUsers = users.where((userData) {
            final email = userData['email']?.toString().toLowerCase();

            return email != null &&
                email != currentEmail &&
                !myEmails.contains(email);
          }).toList();

          if (filteredUsers.isEmpty) {
            return const Center(
              child: Text("No new users to add"),
            );
          }

          return ListView(
            children: filteredUsers
                .map<Widget>(
                  (userData) => _buildUserListItem(userData, context),
                )
                .toList(),
          );
        },
      );
    },
  );
}


  // button list indivisual list tile for user
  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    // display all user exept current user
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () async {
          final contacts = await storage.loadContacts();

          final email = userData['email'].toString();

          final exists = contacts.any(
            (contact) =>
                contact['email'].toString().toLowerCase() ==
                email.toLowerCase(),
          );

          if (!exists) {
            contacts.add({'email': email});
            await storage.saveContacts(contacts);
          }

          if (context.mounted) {
            Navigator.pop(context);
          }
        },
      );
    } else {
      return Container();
    }
  }
}


import 'package:flutter/material.dart';
import 'package:talk/components/my_drawer.dart';
import 'package:talk/components/user_tile.dart';
import 'package:talk/pages/add_user_page.dart';
import 'package:talk/pages/chat_page.dart';
import 'package:talk/services/auth/auth_service.dart';
import 'package:talk/services/chat/chat_service.dart';
import 'package:talk/services/contact_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  final ContactStorage storage = ContactStorage();

  late Future<List<Map<String, dynamic>>> _contactsFuture;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() {
    _contactsFuture = storage.loadContacts();
  }

  void _refreshContacts() {
    setState(() {
      _loadContacts();
    });
  }

  Future<void> _openAddUserPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUserPage(),
      ),
    );

    if (!mounted) return;

    _refreshContacts();
  }

  Future<void> _openChat(Map<String, dynamic> userData) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          reciverEmail: userData['email'],
          reciverId: userData['uid'],
        ),
      ),
    );

    if (!mounted) return;

    // Refresh contacts after returning from ChatPage
    _refreshContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Home"),
        foregroundColor: Colors.grey.shade600,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddUserPage,
        child: const Icon(Icons.add),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _contactsFuture,
      builder: (context, contactSnapshot) {
        if (contactSnapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (contactSnapshot.hasError) {
          return const Center(
            child: Text("Error loading contacts"),
          );
        }

        final contacts = contactSnapshot.data ?? [];

        final myEmails = contacts
            .map(
              (contact) =>
                  contact['email'].toString().toLowerCase(),
            )
            .toSet();

        return StreamBuilder(
          stream: _chatService.getUsersStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error loading users"),
              );
            }

            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final users = snapshot.data ?? [];

            final currentEmail = _authService
                .getCurrentUser()
                ?.email
                ?.toLowerCase();

            final filteredUsers = users.where((userData) {
              final email =
                  userData['email']?.toString().toLowerCase();

              return email != null &&
                  email != currentEmail &&
                  myEmails.contains(email);
            }).toList();

            if (filteredUsers.isEmpty) {
              return const Center(
                child: Text("No contacts yet"),
              );
            }

            return ListView(
              children: filteredUsers
                  .map<Widget>(
                    (userData) => _buildUserListItem(
                      userData,
                    ),
                  )
                  .toList(),
            );
          },
        );
      },
    );
  }

  Widget _buildUserListItem(
    Map<String, dynamic> userData,
  ) {
    return UserTile(
      text: userData['email'] ?? '',
      onTap: () {
        _openChat(userData);
      },
    );
  }
}

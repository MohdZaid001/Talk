import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ContactStorage {
  static const String _key = 'chat_contacts';

  Future<void> saveContacts(
    List<Map<String, dynamic>> contacts,
  ) async {
    final prefs = SharedPreferencesAsync();

    await prefs.setString(
      _key,
      jsonEncode(contacts),
    );
  }

  Future<List<Map<String, dynamic>>> loadContacts() async {
    final prefs = SharedPreferencesAsync();
    final data = await prefs.getString(_key);

    if (data == null) return [];

    return List<Map<String, dynamic>>.from(
      (jsonDecode(data) as List).map(
        (item) => Map<String, dynamic>.from(item),
      ),
    );
  }

  Future<void> removeContact(String email) async {
  final contacts = await loadContacts();

  contacts.removeWhere(
    (contact) =>
        contact['email'].toString().toLowerCase() ==
        email.toLowerCase(),
  );

  await saveContacts(contacts);
}
}
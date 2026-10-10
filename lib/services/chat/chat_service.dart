import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talk/models/message.dart';

class ChatService {
  // Get instance of chat service
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get user streat
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go through each indivisual user
        final user = doc.data();

        // return user
        return user;
      }).toList();
    });
  }

  // send messages
  Future<void> sendMessage(String reciverId, message) async {
    // Get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      reciverId: reciverId,
      message: message,
      timestamp: timestamp,
    );

    // construct new chat room id for user ensure uniqueness
    List<String> ids = [currentUserId, reciverId];
    ids.sort(); //sort the ids (this ensure the current roomId is same for that 2 persons)
    String chatRoomId = ids.join("_");

    // add new message to the database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get messages
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    // construct a chatroom id for the 2 users
    List<String> ids = [userId, otherUserId];
    ids.sort(); //sort the ids (this ensure the current roomId is same for that 2 persons)
    String chatRoomId = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}

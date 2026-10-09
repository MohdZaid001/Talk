import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  // Get instance of chat service
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get user streat
  Stream<List<Map<String,dynamic>>> getUsersStream(){
    return _firestore.collection("Users").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        // go through each indivisual user
        final user = doc.data();

        // return user
        return user;
      }).toList();
    });
  }
  // send messages

  // get messages
}
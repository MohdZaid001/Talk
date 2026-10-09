import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  // instance off auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser(){
    return _auth.currentUser;
  }

  // sign in
  Future<UserCredential> signInWithEamailAndPassword(String email, password) async{
    try{
      // login user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password,);
      
      // save user info if user not exist already
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {'uid': userCredential.user!.uid,
         'email':email,
        },
      );
      return userCredential;
    }on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }

  // sign up
  Future<UserCredential> signUpWithEmailAndPassword(String email, password) async{
    try{
      // Create User
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password,);
      
      // save user info in doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {'uid': userCredential.user!.uid,
         'email':email,
        },
      );
      
      return userCredential;
    }on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }

  // sign out
  Future<void> signOut() async{
    return await _auth.signOut();
  }
  // errors
}
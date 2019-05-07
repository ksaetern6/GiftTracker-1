import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

//abstract defines an interface for classes to implement
abstract class BaseAuth {
  Future<String> signInEmailAndPass(String email, String pass);
  Future<String> registerEmailAndPass(String email, String pass);
  Future<String> currentUser();
  Future<FirebaseUser> getCurrentUser();
  Future<void> signOut();
}

//if changing Authentication method (i.e not firebase) we just need to
//change the class but still implement to BaseAuth...modularity!
class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signInEmailAndPass(String email, String pass) async {
    FirebaseUser user = await _firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: pass,
    );
    return user.uid;
  } //signInEmailAndPass

  Future<String> registerEmailAndPass(String email, String pass) async {
    FirebaseUser user = await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: pass,
    );
    return user.uid;
  }//registerEmailAndPass

  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }//currentUser

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

}
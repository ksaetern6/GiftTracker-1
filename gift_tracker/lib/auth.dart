import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

//abstract defines an interface for classes to implement
abstract class BaseAuth {
  Future<String> signInEmailAndPass(String email, String pass);
  Future<String> registerEmailAndPass(String email, String pass);
}

//if changing Authentication method (i.e not firebase) we just need to
//change the class but still implement to BaseAuth...modularity!
class Auth implements BaseAuth {

  Future<String> signInEmailAndPass(String email, String pass) async {
    FirebaseUser user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: pass,
    );
    return user.uid;
  } //signInEmailAndPass

  Future<String> registerEmailAndPass(String email, String pass) async {
    FirebaseUser user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: pass,
    );
    return user.uid;
  }//registerEmailAndPass
}
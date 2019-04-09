import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'auth.dart';

class initialPage extends StatefulWidget {
  //require widget.auth in HomePage call
  initialPage({this.auth});
  final BaseAuth auth;
  @override
  _initialPageState createState() => _initialPageState();
}

enum AuthStatus {
  notSignedIn,
  SignedIn
}
class _initialPageState extends State<initialPage> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  //called every time stateful widget is created (before build)
  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
//        _authStatus = userId == null ? AuthStatus.notSignedIn
//            : AuthStatus.SignedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.notSignedIn:
        return LoginPage(
            auth: widget.auth,
            onSignedIn: _signedIn,
        ); //passing in same auth object
      case AuthStatus.SignedIn:
        return Scaffold(
            body: Container(
            child: Text('Welcome'),
          )
        );
    } //switch
  }//build
}
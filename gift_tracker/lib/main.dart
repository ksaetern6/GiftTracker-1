import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'auth.dart';
import 'NavDrawer.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
        title: "GiftTracker",
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),

        home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget
{
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage>
{
  //AuthGoogle authService = AuthGoogle();
  @override
  Widget build(BuildContext context) {
    // forces portrait usage of this page/widget
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text("GiftTracker"),
      ),

      drawer: NavDrawer(),

      body: Center(
        child: Column(
          children: <Widget>[
            Login(),
            //element 1
            //add a function to open a new page for google SignIn
//            RaisedButton(
//              child: Text("Sign In"),
//              onPressed: () => authService.googleSignIn(),
//            ),
//
//            //element 2
//            RaisedButton(
//              child: Text("Sign Out"),
//              onPressed: () => authService.signOut(),
//            ),

          ],
        )
      )

    );
  }

} //_HomePage

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialButton(
            onPressed: () => authService.signOut(),
            child: Text("Signout"),
          );
        }//if
        else {
          return MaterialButton(
            onPressed: () => authService.googleSignIn(),
            child: Text('Login with Google'),
          );
        }//else
      },
    );
  }
}

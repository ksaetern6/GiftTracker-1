import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'NavDrawer.dart';
//import 'loginPage.dart';
import 'auth.dart';
import 'initialPage.dart';

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

        home: initialPage(auth: Auth(),)
    );
  }
}


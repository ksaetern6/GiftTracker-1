import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'GiftListPage.dart';
import 'main.dart';

class NavDrawer extends StatelessWidget
{
  @override
  Widget build(BuildContext context){
    // forces portrait usage of this page/widget
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              //child: Text("Actions\n <ADD LOGIN TEXT AND PROFILE PICTURE HERE>"),
              decoration: BoxDecoration(
                  color: Colors.yellow
              ),
            ),

            ListTile(
              title: Text(
                "Home Page",
                style: TextStyle(fontSize: 20.0)
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => new HomePage()));
              },
            ),

            ListTile(
              title: Text(
                "Gift List",
                style: TextStyle(fontSize: 20.0),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => new GiftListPage()));
              },
            ),
          ],
        )
    );
  }
}
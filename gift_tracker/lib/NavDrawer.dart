import 'package:flutter/material.dart';
import 'GiftListPage.dart';

class NavDrawer extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
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
              title: Text("Gift List"),
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
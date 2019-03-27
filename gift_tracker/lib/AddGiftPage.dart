import 'package:flutter/material.dart';
import 'Gift.dart';

class AddGiftPage extends StatefulWidget
{
  @override
  _AddGiftPage createState() => _AddGiftPage();
}

// page to add, track, and edit goals
class _AddGiftPage extends State<AddGiftPage>
{
  // -- Variables -- //


  // -- Functions -- //


  // -- Main Widget Builder --//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Gift")
      ),

    );
  }
}


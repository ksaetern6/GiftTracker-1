import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'GiftList.dart';

class AddGiftPage extends StatefulWidget
{
  @override
  _AddGiftPage createState() => _AddGiftPage();
}

class _AddGiftPage extends State<AddGiftPage>
{
  // -- Variables -- //

  //TODO Is there a better way to do this? So many controllers is annoying
  final giftNameController = new TextEditingController();
  final giftDescriptionController = new TextEditingController();
  final giftLinkController = new TextEditingController();
  final giftDateAddedController = new TextEditingController();
  final giftPriorityController = new TextEditingController();
  final giftPriceController = new TextEditingController();

  final FocusNode giftNameFocus = FocusNode();
  final FocusNode giftDescriptionFocus = FocusNode();
  final FocusNode giftLinkFocus = FocusNode();
  final FocusNode giftDateAddedFocus = FocusNode();
  final FocusNode giftPriorityFocus = FocusNode();
  final FocusNode giftPriceFocus = FocusNode();

  var tempList = new GiftList();

  // -- Functions -- //

  addGift()
  {
    tempList.addGiftToList(giftNameController.text,
                           giftDescriptionController.text,
                           int.parse(giftPriorityController.text),
                           double.parse(giftPriceController.text),
                           giftLinkController.text,
                           giftDateAddedController.text,
                           false);

    tempList.printList(); // for checking

    Navigator.pop(context);
  }

  // -- Main Widget Builder --//

  @override
  Widget build(BuildContext context) {
    // forces portrait usage of this page/widget
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Gift")
      ),

      // TODO it might be nice to eventually make this page look nicer,
      // TODO   having the text form fields line up with each other would be good
      body: Column(
        children: <Widget>[
          SizedBox(height: 15),
          Row(
            children: <Widget>[
              SizedBox(width: 7),
              Text("Gift Name", style: TextStyle(fontSize: 20.0)),
              SizedBox(width: 10),
              Flexible( // flexible means the text field can take up the rest of the window
                child: TextFormField(
                  controller: giftNameController,
                  textInputAction: TextInputAction.next,
                  focusNode: giftNameFocus,
                  onFieldSubmitted: (term){
                    FocusScope.of(context).requestFocus(giftDescriptionFocus);
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5.0),
                  ),
                )
              ),
              SizedBox(width: 10)
            ],
          ),

          SizedBox(height: 15),
          Row(
            children: <Widget>[
              SizedBox(width: 7),
              Text("Description", style: TextStyle(fontSize: 20.0)),
              SizedBox(width: 10),
              Flexible(
                  child: TextFormField(
                    controller: giftDescriptionController,
                    textInputAction: TextInputAction.next,
                    focusNode: giftDescriptionFocus,
                    onFieldSubmitted: (term){
                      FocusScope.of(context).requestFocus(giftPriorityFocus);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5.0),
                    ),
                  )
              ),
              SizedBox(width: 10)
            ],
          ),

          SizedBox(height: 15),
          Row( //TODO later make this a dropdown or something better
            children: <Widget>[
              SizedBox(width: 7),
              Text("Priority (1 - 10)", style: TextStyle(fontSize: 20.0)),
              SizedBox(width: 10),
              Flexible(
                  child: TextFormField(
                    controller: giftPriorityController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: giftPriorityFocus,
                    onFieldSubmitted: (term){
                      FocusScope.of(context).requestFocus(giftPriceFocus);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5.0),
                    ),
                  )
              ),
              SizedBox(width: 10)
            ],
          ),

          //TODO this needs to have some kind of validation and a $ sign needs
          //TODO   to be appended
          SizedBox(height: 15),
          Row(
            children: <Widget>[
              SizedBox(width: 7),
              Text("Price", style: TextStyle(fontSize: 20.0)),
              SizedBox(width: 10),
              Flexible(
                  child: TextFormField(
                    controller: giftPriceController,
                    focusNode: giftPriceFocus,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (term){
                      FocusScope.of(context).requestFocus(giftDateAddedFocus);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5.0),
                      hintText: 'In Dollars, no \'\$\''
                    ),
                  )
              ),
              SizedBox(width: 10)
            ],
          ),

          SizedBox(height: 15),
          Row( //TODO later make this automatically fill with the current date
            children: <Widget>[
              SizedBox(width: 7),
              Text("Date Added", style: TextStyle(fontSize: 20.0)),
              SizedBox(width: 10),
              Flexible(
                  child: TextFormField(
                    controller: giftDateAddedController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.datetime,
                    focusNode: giftDateAddedFocus,
                    onFieldSubmitted: (term){
                      FocusScope.of(context).requestFocus(giftLinkFocus);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5.0),
                    ),
                  )
              ),
              SizedBox(width: 10)
            ],
          ),

          SizedBox(height: 15),
          Row(
            children: <Widget>[
              SizedBox(width: 7),
              Text("Link", style: TextStyle(fontSize: 20.0)),
              SizedBox(width: 10),
              Flexible(
                  child: TextFormField(
                    controller: giftLinkController,
                    textInputAction: TextInputAction.done,
                    focusNode: giftLinkFocus,
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5.0),
                    ),
                  )
              ),
              SizedBox(width: 10)
            ],
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text("Cancel"),
              color: Theme.of(context).accentColor,
              onPressed: () => {
                Navigator.pop(context)
              }
            ),
            RaisedButton(
                child: Text("Add Gift"),
                color: Theme.of(context).accentColor,
                onPressed: () => addGift()
            )
          ],
        ),
      ),

    );
  }
}


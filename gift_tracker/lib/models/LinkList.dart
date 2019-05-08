class LinkList
{
  // -- Variables -- //

  String _linkName = "";
  String _linkLink = "";

  LinkList.set(this._linkName, this._linkLink);

  LinkList();

  // -- Getters --
  String get linkName => _linkName;

  String get linkLink => _linkLink;

  // -- Setters --

  set linkName(name){
    this._linkName = name;
  }

  set linkLink(link){
    this._linkLink = link;
  }

  LinkList.fromMapObject(Map<String, dynamic> myMap) {
    this._linkName = myMap['name'];
    this._linkLink = myMap['link'];

  }

  Map<String, dynamic> toMap() {

    //empty map object
    var myMap = Map<String, dynamic>();

    myMap['name'] = _linkName;
    myMap['link'] = _linkLink;

    return myMap;
  }// toMap()

}


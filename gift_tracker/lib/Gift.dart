class Gift
{
  // -- Variables -- //

  String _giftName = "";
  String _giftDescription = "";
  int _giftPriority = -1;    // priority should be between 0 and 10
  double _giftPrice = -1.0;
  String _giftDateAdded = "";
  String _giftLink = "";
  bool _giftBought = false;  // if true, gift was bought by someone
  //TODO add image variable

  Gift.set(this._giftName, this._giftDescription, this._giftPriority,
            this._giftPrice, this._giftDateAdded, this._giftLink, this._giftBought);

  Gift();

  // -- Getters --
  String get giftName => _giftName;

  String get giftDescription => _giftDescription;

  int get giftPriority => _giftPriority;

  double get giftPrice => _giftPrice;

  String get giftDateAdded => _giftDateAdded;

  String get giftLink => _giftLink;

  bool get giftBought => _giftBought;

  // -- Setters --

  set giftName(name){
    this._giftName = name;
  }

  set giftDescription(desc){
    this._giftDescription = desc;
  }

  set giftPriority(prio){
    this._giftPriority = prio;
  }

  set giftPrice(price){
    this._giftPrice = price;
  }

  set giftDateAdded(date){
    this._giftDateAdded = date;
  }

  set giftLink(link){
    this._giftLink = link;
  }

  set giftBought(bought){
    this._giftBought = bought;
  }

  Gift.fromMapObject(Map<String, dynamic> myMap) {
    this._giftName = myMap['name'];
    this._giftDescription = myMap['description'];
    this._giftPriority = myMap['priority'];
    this._giftPrice = myMap['price'];
    this._giftDateAdded = myMap['dateAdded'];
    this._giftLink = myMap['link'];
    this._giftBought = myMap['bought'];
  }

  Map<String, dynamic> toMap() {

    //empty map object
    var myMap = Map<String, dynamic>();

    myMap['name'] = _giftName;
    myMap['description'] = _giftDescription;
    myMap['priority'] = _giftPriority;
    myMap['price'] = _giftPrice;
    myMap['dateAdded'] = _giftDateAdded;
    myMap['link'] = _giftLink;
    myMap['bought'] = _giftBought;

    return myMap;
  }// toMap()

}


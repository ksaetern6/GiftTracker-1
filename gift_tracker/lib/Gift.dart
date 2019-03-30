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

  // -- Functions -- //

  Gift(this._giftName, this._giftDescription, this._giftPriority, this._giftPrice,
       this._giftDateAdded, this._giftLink, this._giftBought);

  String getName()
  {
    return _giftName;
  }

  String getDescription()
  {
    return _giftDescription;
  }

  String getLink()
  {
    return _giftLink;
  }

  String getDateAdded()
  {
    return _giftDateAdded;
  }

  int getPriority()
  {
    return _giftPriority;
  }

  double getPrice()
  {
    return _giftPrice;
  }

  bool getBought()
  {
    return _giftBought;
  }

}
import 'Gift.dart';

class GiftList
{
  // -- Variables -- //

  var giftList = new List<Gift>();

  // -- Functions -- //

  addGiftToList(String name, String desc, int prio, double price, String date,
                String link, bool bought)
  {
    Gift addedGift = new Gift(name, desc, prio, price, date, link, bought);

    giftList.add(addedGift);
  }

  printList() // for checking
  {
    print(giftList.length);

    for(int i = 0; i < giftList.length; i++)
    {
      print("[$i]: ${giftList[i].getName()}, "
            "${giftList[i].getDescription()}, "
            "${giftList[i].getPriority()} , "
            "${giftList[i].getPrice()} , "
            "${giftList[i].getDateAdded()} , "
            "${giftList[i].getLink()} , "
            "${giftList[i].getBought()} ");
    }

  }

  int getLengthOfList()
  {
    if(giftList.isEmpty)
      return 1;

    return giftList.length;
  }

  bool isListEmpty()
  {
    return giftList.isEmpty;
  }

  String getName(int index)
  {
    return giftList[index].getName();
  }

  String getDescription(int index)
  {
    return giftList[index].getDescription();
  }

  int getPriority(int index)
  {
    return giftList[index].getPriority();
  }

  double getPrice(int index)
  {
    return giftList[index].getPrice();
  }

  String getDateAdded(int index)
  {
    return giftList[index].getDateAdded();
  }

  String getLink(int index)
  {
    return giftList[index].getLink();
  }

  bool getBought(int index)
  {
    return giftList[index].getBought();
  }

}
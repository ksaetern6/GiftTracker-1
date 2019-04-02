import 'Gift.dart';

class GiftList
{
  // -- Variables -- //

  //var giftList;

  // -- Functions -- //

  addGiftToList(List<Gift> giftList, String name, String desc, int prio, double price,
                String date, String link, bool bought)
  {
    Gift addedGift = new Gift(name, desc, prio, price, date, link, bought);

    giftList.add(addedGift);
  }

  printList(List<Gift> giftList) // for checking
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

  int getLengthOfList(List<Gift> giftList)
  {
    if(giftList.isEmpty)
      return 1;

    return giftList.length;
  }

  bool isListEmpty(List<Gift> giftList)
  {
    return giftList.isEmpty;
  }

  String getName(List<Gift> giftList, int index)
  {
    return giftList[index].getName();
  }

  String getDescription(List<Gift> giftList, int index)
  {
    return giftList[index].getDescription();
  }

  int getPriority(List<Gift> giftList, int index)
  {
    return giftList[index].getPriority();
  }

  double getPrice(List<Gift> giftList, int index)
  {
    return giftList[index].getPrice();
  }

  String getDateAdded(List<Gift> giftList, int index)
  {
    return giftList[index].getDateAdded();
  }

  String getLink(List<Gift> giftList, int index)
  {
    return giftList[index].getLink();
  }

  bool getBought(List<Gift> giftList, int index)
  {
    return giftList[index].getBought();
  }

}
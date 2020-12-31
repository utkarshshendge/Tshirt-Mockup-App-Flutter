import 'package:flutter/foundation.dart';

class Itemquantity with ChangeNotifier{

  int _itemsno=0;
  int get numberofitems=> _itemsno;
  display(int no){
    _itemsno=no;
    notifyListeners();

  }
}

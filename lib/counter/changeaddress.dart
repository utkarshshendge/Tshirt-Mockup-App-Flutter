import 'package:flutter/foundation.dart';

class Addresschanger extends ChangeNotifier{

  int counter=0;
  int get count=> counter;
  displayresult(int v){
    counter=v;
    notifyListeners();

  }
}
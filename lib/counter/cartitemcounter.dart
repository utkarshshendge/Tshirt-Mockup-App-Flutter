import 'package:EDI/config/config.dart';
import 'package:flutter/foundation.dart';
//import 'package:EDIapp/Config/config.dart';

class CartItemCounter extends ChangeNotifier{

  int _counter=EDIapp.sharedPreferences.getString(EDIapp.userCartList).length-1;
  int get count=> _counter;

  Future <void> displayresult() async{
      int _counter=EDIapp.sharedPreferences.getString(EDIapp.userCartList).length-1;
      await Future.delayed(const Duration(milliseconds: 100), (){
        notifyListeners();
      });


  }
}
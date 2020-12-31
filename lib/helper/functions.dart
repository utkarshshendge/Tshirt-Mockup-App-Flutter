import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String loggedInKey = "LOGGEDINKEY";

  static setUserLoginDetails({bool isLoggedIn}) async {
    SharedPreferences logged = await SharedPreferences.getInstance();
    logged.setBool("LOGGEDINKEY", isLoggedIn);
  }

  static Future<bool> getUserLoginDetails() async {
    print("GETTED");
    SharedPreferences logged = await SharedPreferences.getInstance();
    return logged.getBool("LOGGEDINKEY");
  }
}

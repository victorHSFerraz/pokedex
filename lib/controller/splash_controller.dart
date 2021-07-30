import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:victor_flutter/components/constants.dart';

class SplashController extends GetxController {
  SplashController() {
    Future.delayed(Duration(seconds: 3), () {
      checkAccount();
    });
  }

  Future checkAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasAccount = prefs.getBool(Constants.hasAccount);
    if (hasAccount == true) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/home');
    }
  }
}

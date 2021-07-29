import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../components/assets.dart';
import '../../components/default_container.dart';
import '../../controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return DefaultContainer(
      style: SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Theme.of(context).primaryColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.logoMain,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              Container(
                width: 100,
                child: LinearProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

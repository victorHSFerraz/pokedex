import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'components/app_theme.dart';
import 'view/splash/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    GetMaterialApp(
      title: 'VICTOR FLUTTER',
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      home: SplashPage(),
      // getPages: [
      //   GetPage(
      //     name: '/login',
      //     page: () => HomePage(),
      //   ),
      // ],
    ),
  );
}

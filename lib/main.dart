import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:victor_flutter/view/home/home_page.dart';

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
      getPages: [
        GetPage(
          name: '/home',
          page: () => HomePage(),
        ),
      ],
    ),
  );
}

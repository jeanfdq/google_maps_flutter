import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_trips/theme.dart';

import 'view/views.dart';

//#3253A2
void main() {
  runApp( GetMaterialApp(
    theme: defaultTheme(),
    debugShowCheckedModeBanner: false,
    title: "My Trips",
    home: const Home(),
    initialRoute: SplashScreen.id,
    getPages: [
      GetPage(name: SplashScreen.id, page: () => const SplashScreen()),
      GetPage(name: Home.id, page: () => const Home()),
      GetPage(name: Map.id, page: () => const Map()),
    ],
  ));
}


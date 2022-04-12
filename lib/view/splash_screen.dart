
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const id = "/splash_screen";

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 4), () => Get.offAllNamed(Home.id));

    return Container(
      width: Get.width,
      height: Get.height,
      color: Theme.of(context).colorScheme.primary,
      child: Center(
        child: Image(
          width: Get.width,
          image: const AssetImage("assets/images/logotipo.png")),
      ),
    );
  }
}

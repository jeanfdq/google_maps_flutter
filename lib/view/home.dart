import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_trips/view/views.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const id = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.public),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              child: const Icon(Icons.add_location_alt),
              onTap: () => Get.toNamed(Map.id),
            ),
          )
        ],
        title: const Text("My Trips"),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
      ),
    );
  }
}

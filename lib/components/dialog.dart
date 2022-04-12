
import 'package:flutter/material.dart';

class DialogConfirm extends StatelessWidget {
  const DialogConfirm({Key? key, required this.title, required this.content, required this.confirm }) : super(key: key);

  final String title;
  final String content;
  final VoidCallback confirm;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
              title: Text(title),
              content: Text(content),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Colors.white,
              actions: [
                ElevatedButton(
                  onPressed: confirm,
                  child: const Text("Confirmar"),
                ),
              ],
            );
  }
}
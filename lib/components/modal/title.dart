import 'package:flutter/material.dart';

class TitleModal extends StatelessWidget {
  String? title;
  TitleModal({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
          ),
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.close))
        ],
      ),
    );
  }
}

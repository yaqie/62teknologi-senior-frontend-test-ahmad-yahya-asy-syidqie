import 'package:enam_dua_teknologi/utils/colors.dart';
import 'package:flutter/material.dart';

class SelectedButton extends StatelessWidget {
  bool? isActive = false;
  String? name;
  VoidCallback? callback;
  SelectedButton(
      {super.key,
      required this.name,
      required this.callback,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5, bottom: 5),
      child: InkWell(
        onTap: callback!,
        child: Container(
          decoration: BoxDecoration(
              color: isActive! ? primaryColor : greyColor,
              borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.all(10),
          child: Text(
            name!,
            style: TextStyle(color: isActive! ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}

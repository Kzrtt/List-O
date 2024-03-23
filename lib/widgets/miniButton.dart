import 'package:flutter/material.dart';
import 'package:prj_list_app/constants/appPalette.dart';

class MiniButton extends StatelessWidget {
  void Function() onTap;
  IconData icon;

  MiniButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: LightColorPalette.buttonColor,
        ),
        child: Center(
          child: Icon(
            icon,
            color: LightColorPalette.titleColor,
            size: 25,
          ),
        ),
      ),
    );
  }
}

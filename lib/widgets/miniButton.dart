import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj_list_app/constants/apppalette.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';
import 'package:prj_list_app/utils/AppController.dart';

class MiniButton extends StatelessWidget {
  void Function() onTap;
  IconData icon;
  Color buttonColor;
  Color titleColor;
  double? height;
  double? width;

  MiniButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.buttonColor,
    required this.titleColor,
    this.height = 40,
    this.width = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return InkWell(
          onTap: onTap,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: buttonColor,
            ),
            child: Center(
              child: Icon(
                icon,
                color: titleColor,
                size: 25,
              ),
            ),
          ),
        );
      },
    );
  }
}

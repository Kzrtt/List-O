import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';
import 'package:prj_list_app/controllers/userProvider.dart';
import 'package:prj_list_app/utils/AppController.dart';

class ButtonWithIcon extends StatelessWidget {
  String buttonText;
  double height;
  double width;
  double borderRadius;
  void Function() onTap;
  IconData icon;
  double? iconSize;
  Color? iconColor;
  Color? buttonColor;
  Color? textColor;
  bool? isTrailing;

  ButtonWithIcon({
    super.key,
    required this.buttonText,
    required this.height,
    required this.width,
    required this.borderRadius,
    required this.onTap,
    required this.icon,
    this.buttonColor,
    this.iconColor,
    this.iconSize,
    this.textColor,
    this.isTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        late final AppPalette? palette;
        final user = ref.watch(userProvider).value;

        if (user.isAdvanced) {
          palette = ref.watch(userProvider).value.palette;
        } else {
          palette = ref.watch(themeProvider).value;
        }

        return InkWell(
          onTap: onTap,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
              color: buttonColor ?? palette!.buttonColor.withOpacity(.5),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isTrailing!
                      ? const Center()
                      : Icon(
                          icon,
                          size: iconSize ?? 16,
                          color: iconColor ?? palette!.titleColor,
                        ),
                  isTrailing! ? const Center() : const SizedBox(width: 10),
                  Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor ?? palette!.titleColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  isTrailing! ? const SizedBox(width: 10) : const Center(),
                  isTrailing!
                      ? Icon(
                          icon,
                          size: iconSize ?? 16,
                          color: palette!.titleColor,
                        )
                      : const Center()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

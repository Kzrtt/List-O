import 'package:flutter/material.dart';
import 'package:prj_list_app/constants/appPalette.dart';

class Header extends StatelessWidget {
  BoxConstraints constraints;
  String text;

  Header({
    super.key,
    required this.constraints,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            width: constraints.maxWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.brightness_3_outlined,
                      color: LightColorPalette.titleColor,
                      size: 25,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.menu,
                      color: LightColorPalette.titleColor,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              color: LightColorPalette.titleColor,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "Segunda, 29 de Janeiro",
            style: TextStyle(
              color: LightColorPalette.subTitleColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

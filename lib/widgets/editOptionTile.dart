import 'package:flutter/material.dart';
import 'package:prj_list_app/constants/appPalette.dart';

class EditOptionButton extends StatelessWidget {
  BoxConstraints constraints;
  String title;
  String content;
  IconData icon;
  Color color;
  Color iconColor;

  EditOptionButton({
    super.key,
    required this.constraints,
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: constraints.maxHeight < 550 ? 90 : 80,
      width: constraints.maxWidth * .95,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            height: constraints.maxHeight < 550 ? 100 : 90,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              color: color!,
            ),
            child: Center(
              child: Icon(
                icon,
                size: 50,
                color: iconColor,
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight < 550 ? 100 : 90,
            width: (constraints.maxWidth * .75) - 80,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    content,
                    style: TextStyle(
                      color: Colors.black.withOpacity(.6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

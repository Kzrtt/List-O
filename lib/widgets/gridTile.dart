import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';
import 'package:prj_list_app/widgets/miniButton.dart';

class CustomGridTile extends StatefulWidget {
  BoxConstraints constraints;
  String list;
  String details;
  String alteredIn;
  bool isFinished;
  void Function() delete;
  void Function() edit;
  String text;

  CustomGridTile({
    super.key,
    required this.constraints,
    required this.list,
    required this.details,
    required this.alteredIn,
    required this.delete,
    required this.isFinished,
    required this.edit,
    required this.text,
  });

  @override
  State<CustomGridTile> createState() => _CustomGridTileState();
}

class _CustomGridTileState extends State<CustomGridTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final palette = ref.watch(themeProvider).value;

        return Container(
          height: 160,
          width: 160,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            color: widget.isFinished ? AppPalette.disabledColor.tileColor : palette.tileColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  widget.list,
                  style: TextStyle(
                    color: widget.isFinished ? AppPalette.disabledColor.titleColor : palette.titleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.details,
                  style: TextStyle(
                    color: widget.isFinished ? AppPalette.disabledColor.subTitleColor : palette.subTitleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "${widget.text}: ${widget.alteredIn}",
                  style: TextStyle(
                    color: widget.isFinished ? AppPalette.disabledColor.titleColor : palette.titleColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 40,
                  width: widget.constraints.maxWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MiniButton(
                          onTap: () {},
                          height: 40,
                          width: 60,
                          icon: Icons.delete,
                          buttonColor: widget.isFinished ? AppPalette.disabledColor.buttonColor : palette.buttonColor,
                          titleColor: widget.isFinished ? AppPalette.disabledColor.titleColor : palette.titleColor,
                        ),
                        MiniButton(
                          onTap: () {},
                          height: 40,
                          width: 60,
                          icon: Icons.edit,
                          buttonColor: widget.isFinished ? AppPalette.disabledColor.buttonColor : palette.buttonColor,
                          titleColor: widget.isFinished ? AppPalette.disabledColor.titleColor : palette.titleColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

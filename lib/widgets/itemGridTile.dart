import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';
import 'package:prj_list_app/utils/AppController.dart';
import 'package:prj_list_app/widgets/miniButton.dart';

class ItemGridTile extends StatefulWidget {
  BoxConstraints constraints;
  String list;
  String details;
  String index;
  void Function()? onTap1;
  void Function()? onTap2;
  bool isChecked;

  ItemGridTile({
    super.key,
    required this.constraints,
    required this.list,
    required this.details,
    required this.index,
    required this.onTap1,
    required this.onTap2,
    required this.isChecked,
  });

  @override
  State<ItemGridTile> createState() => _ItemGridTileState();
}

class _ItemGridTileState extends State<ItemGridTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final palette = ref.watch(themeProvider).value;

        return Container(
          height: 130,
          width: 160,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            color: widget.isChecked ? AppPalette.disabledColor.tileColor : palette.tileColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.list,
                      style: TextStyle(
                        color: widget.isChecked ? AppPalette.disabledColor.titleColor : palette.titleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.details,
                      style: TextStyle(
                        color: widget.isChecked ? AppPalette.disabledColor.subTitleColor : palette.subTitleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 40,
                width: widget.constraints.maxWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MiniButton(
                      onTap: () => widget.onTap1!(),
                      height: 40,
                      width: 60,
                      icon: Icons.refresh,
                      buttonColor: widget.isChecked ? AppPalette.disabledColor.buttonColor : palette.buttonColor,
                      titleColor: widget.isChecked ? AppPalette.disabledColor.titleColor : palette.titleColor,
                    ),
                    MiniButton(
                      onTap: () => widget.onTap2!(),
                      height: 40,
                      width: 60,
                      icon: widget.isChecked ? Icons.delete : Icons.check,
                      buttonColor: widget.isChecked ? AppPalette.disabledColor.buttonColor : palette.buttonColor,
                      titleColor: widget.isChecked ? AppPalette.disabledColor.titleColor : palette.titleColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

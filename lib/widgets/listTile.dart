import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';
import 'package:prj_list_app/utils/AppController.dart';
import 'package:prj_list_app/widgets/miniButton.dart';

class CustomListTile extends StatefulWidget {
  BoxConstraints constraints;
  String list;
  String details;
  String alteredIn;
  bool isFinished;
  void Function() delete;
  void Function() edit;

  CustomListTile({
    super.key,
    required this.constraints,
    required this.list,
    required this.details,
    required this.alteredIn,
    required this.delete,
    required this.isFinished,
    required this.edit,
  });

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final palette = ref.watch(themeProvider).value;

        return Container(
          height: 80,
          width: widget.constraints.maxWidth * .9,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            color: widget.isFinished ? AppPalette.disabledColor.tileColor : palette.tileColor,
          ),
          child: Row(
            children: [
              //? Container icon item
              SizedBox(
                height: 80,
                width: widget.constraints.maxWidth * .2,
                child: Center(
                  child: Container(
                    height: 60,
                    width: widget.constraints.maxWidth * .15,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                      color: widget.isFinished ? AppPalette.disabledColor.titleColor : palette.titleColor.withOpacity(.8),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.shopping_cart,
                        size: 40,
                        color: widget.isFinished ? AppPalette.disabledColor.buttonColor : palette.buttonColor,
                      ),
                    ),
                  ),
                ),
              ),
              //? Container textos
              SizedBox(
                height: 80,
                width: widget.constraints.maxWidth * .45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                      "Alterado em: ${widget.alteredIn}",
                      style: TextStyle(
                        color: widget.isFinished ? AppPalette.disabledColor.titleColor : palette.titleColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              //? Container Botões
              SizedBox(
                height: 80,
                width: widget.constraints.maxWidth * .25,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MiniButton(
                        onTap: () => widget.delete(),
                        icon: Icons.delete,
                        buttonColor: widget.isFinished ? AppPalette.disabledColor.buttonColor : palette.buttonColor,
                        titleColor: widget.isFinished ? AppPalette.disabledColor.titleColor : palette.titleColor,
                      ),
                      MiniButton(
                        onTap: () => widget.edit(),
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
        );
      },
    );
  }
}

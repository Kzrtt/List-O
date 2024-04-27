import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';
import 'package:prj_list_app/controllers/userProvider.dart';
import 'package:prj_list_app/utils/AppController.dart';
import 'package:prj_list_app/widgets/miniButton.dart';

class ItemTile extends StatefulWidget {
  BoxConstraints constraints;
  String list;
  String details;
  String index;
  void Function()? onTap1;
  void Function()? onTap2;
  bool isChecked;

  ItemTile({
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
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        late final AppPalette? palette;
        final user = ref.watch(userProvider).value;

        if (user.isAdvanced) {
          palette = ref.watch(themeProvider).value;
        } else {
          palette = ref.watch(userProvider).value.palette;
        }

        return Container(
          height: 80,
          width: widget.constraints.maxWidth * .9,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            color: widget.isChecked ? AppPalette.disabledColor.tileColor : palette!.tileColor,
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
                      color: widget.isChecked ? AppPalette.disabledColor.titleColor.withOpacity(.8) : palette!.titleColor.withOpacity(.8),
                    ),
                    child: Center(
                      child: Text(
                        widget.index,
                        style: TextStyle(
                          color: widget.isChecked ? AppPalette.disabledColor.buttonColor : palette!.buttonColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //? Container textos
              SizedBox(
                height: 80,
                width: widget.constraints.maxWidth * .44,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.list,
                      style: TextStyle(
                        color: widget.isChecked ? AppPalette.disabledColor.titleColor : palette!.titleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.details,
                      style: TextStyle(
                        color: widget.isChecked ? AppPalette.disabledColor.subTitleColor : palette!.subTitleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              //? Container Botões
              SizedBox(
                height: 80,
                width: widget.constraints.maxWidth * .26,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      widget.isChecked
                          ? MiniButton(
                              onTap: () => widget.onTap1!(),
                              icon: Icons.refresh,
                              buttonColor: AppPalette.disabledColor.buttonColor,
                              titleColor: AppPalette.disabledColor.titleColor,
                            )
                          : const Center(),
                      MiniButton(
                        onTap: () => widget.onTap2!(),
                        icon: widget.isChecked ? Icons.delete : Icons.check,
                        buttonColor: widget.isChecked ? AppPalette.disabledColor.buttonColor : palette!.buttonColor,
                        titleColor: widget.isChecked ? AppPalette.disabledColor.titleColor : palette!.titleColor,
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

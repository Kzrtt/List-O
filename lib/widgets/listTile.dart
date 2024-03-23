import 'package:flutter/material.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/widgets/miniButton.dart';

class CustomListTile extends StatefulWidget {
  BoxConstraints constraints;
  String list;
  String details;
  String alteredIn;

  CustomListTile({
    super.key,
    required this.constraints,
    required this.list,
    required this.details,
    required this.alteredIn,
  });

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: widget.constraints.maxWidth * .9,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: LightColorPalette.tileColor,
      ),
      child: Row(
        children: [
          //? Container icon item
          SizedBox(
            height: 120,
            width: widget.constraints.maxWidth * .2,
            child: Center(
              child: Container(
                height: 70,
                width: widget.constraints.maxWidth * .15,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  color: LightColorPalette.titleColor,
                ),
              ),
            ),
          ),
          //? Container textos
          SizedBox(
            height: 120,
            width: widget.constraints.maxWidth * .55,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Nome Tarefa",
                  style: TextStyle(
                    color: LightColorPalette.titleColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Detalhes sobre a tarefa",
                  style: TextStyle(
                    color: LightColorPalette.subTitleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Alterado em: 20/04/2024",
                  style: TextStyle(
                    color: LightColorPalette.titleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          //? Container Botões
          SizedBox(
            height: 120,
            width: widget.constraints.maxWidth * .15,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MiniButton(
                    onTap: () {},
                    icon: Icons.done,
                  ),
                  MiniButton(
                    onTap: () {},
                    icon: Icons.edit,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

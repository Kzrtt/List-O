import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/controllers/listProvider.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';
import 'package:prj_list_app/models/List.dart';
import 'package:prj_list_app/utils/validators.dart';
import 'package:prj_list_app/widgets/buttonWithIcon.dart';
import 'package:prj_list_app/widgets/header.dart';
import 'package:prj_list_app/widgets/itemTile.dart';
import 'package:prj_list_app/widgets/listTile.dart';
import 'package:prj_list_app/widgets/textForms.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ListDetailsScreen extends StatefulWidget {
  final String listId;

  const ListDetailsScreen({
    super.key,
    required this.listId,
  });

  @override
  State<ListDetailsScreen> createState() => _ListDetailsScreenState();
}

class _ListDetailsScreenState extends State<ListDetailsScreen> {
  final addItemFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer(
        builder: (context, ref, child) {
          final palette = ref.watch(themeProvider).value;
          final lists = ref.watch(itemListProvider).value;

          ItemList list = ItemList(alteredIn: DateTime.now());
          for (var i = 0; i < lists.length; i++) {
            if (lists[i].itemId == widget.listId) {
              list = lists[i];
            }
          }

          showModal(AppPalette palette) {
            Item item = Item();
            String selectedUn = "";

            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      height: 750,
                      width: constraints.maxWidth,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 160,
                            width: constraints.maxWidth,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: palette.titleColor.withOpacity(.8),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add_shopping_cart_outlined,
                                color: palette.tileColor,
                                size: 100,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Adicionar Item :",
                                    style: TextStyle(
                                      color: palette.titleColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Form(
                                    key: addItemFormKey,
                                    child: Column(
                                      children: [
                                        CustomTextFormField(
                                          width: .95,
                                          constraints: constraints,
                                          hintText: "Nome do Item",
                                          label: "Nome",
                                          palette: palette,
                                          onSaved: (text) => item.name = text!,
                                          validator: (text) => Validator.validateNotEmpty(text),
                                        ),
                                        const SizedBox(height: 20),
                                        CustomTextFormField(
                                          width: .95,
                                          constraints: constraints,
                                          hintText: "Quantidade Item",
                                          label: "Detalhes",
                                          palette: palette,
                                          onSaved: (text) => item.quantity = text!,
                                          validator: (text) => Validator.validateNotEmpty(text),
                                        ),
                                        const SizedBox(height: 20),
                                        DropdownTextForm(
                                          constraints: constraints,
                                          dropdownItems: const [
                                            "Unidades",
                                            "gramas",
                                            "kilos",
                                            "litros",
                                          ],
                                          hintText: "Unidade de Medida",
                                          selectedItem: selectedUn,
                                          label: "Selecione a unidade de medida",
                                          palette: palette,
                                          width: .95,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedUn = value!;
                                            });
                                          },
                                          onSaved: (text) => item.measurementUnity = text!,
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ButtonWithIcon(
                                        buttonText: "Voltar",
                                        height: 40,
                                        width: constraints.maxWidth * .4,
                                        borderRadius: 10,
                                        onTap: () => Navigator.of(context).pop(),
                                        icon: Icons.close,
                                        buttonColor: Colors.red.withOpacity(.5),
                                        iconColor: Colors.red,
                                        textColor: Colors.red,
                                      ),
                                      ButtonWithIcon(
                                        buttonText: "Salvar",
                                        height: 40,
                                        width: constraints.maxWidth * .4,
                                        borderRadius: 10,
                                        onTap: () {
                                          if (addItemFormKey.currentState!.validate()) {
                                            addItemFormKey.currentState!.save();
                                            item.isChecked = false;
                                            item.id = list.items!.length.toString();
                                            ref.read(itemListProvider.notifier).addItemInList(
                                                  item,
                                                  widget.listId,
                                                );
                                            Navigator.of(context).pop();
                                          } else {
                                            QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.error,
                                              title: "Erro ao Criar",
                                              text: "Preencha os campos corretamente...",
                                              disableBackBtn: true,
                                              onConfirmBtnTap: () => Navigator.of(context).pop(),
                                            );
                                          }
                                        },
                                        icon: Icons.save,
                                        buttonColor: palette.buttonColor.withOpacity(.5),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }

          return Scaffold(
            backgroundColor: palette.backgroundColor,
            persistentFooterButtons: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonWithIcon(
                    buttonText: "Adicionar Item",
                    height: 40,
                    width: 300,
                    borderRadius: 10,
                    onTap: () => showModal(palette),
                    icon: Icons.add,
                  ),
                ],
              ),
            ],
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Header(
                          constraints: constraints,
                          text: list.name!,
                          secondText: "Ultima Alteração: ${DateFormat('dd/MM/yyyy').format(list.alteredIn)}",
                          hasBackArrow: true,
                        ),
                        const SizedBox(height: 20),
                        ...List.generate(
                          list.items!.length,
                          (index) {
                            Item item = list.items![index];

                            return Column(
                              children: [
                                ItemTile(
                                    constraints: constraints,
                                    list: item.name!,
                                    details: "${item.quantity} ${item.measurementUnity}",
                                    index: (index + 1).toString(),
                                    isChecked: item.isChecked!,
                                    onTap: () {
                                      if (!item.isChecked!) {
                                        ref.read(itemListProvider.notifier).checkItemInList(
                                              item.id!,
                                              widget.listId,
                                            );
                                      } else {
                                        ref.read(itemListProvider.notifier).removeItemInList(
                                              item.id!,
                                              widget.listId,
                                            );
                                      }
                                    }),
                                const SizedBox(height: 20),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

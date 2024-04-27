import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/controllers/orientationProvider.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';
import 'package:prj_list_app/controllers/userProvider.dart';
import 'package:prj_list_app/utils/AppController.dart';
import 'package:prj_list_app/utils/utilsMethods.dart';
import 'package:prj_list_app/widgets/selectColor.dart';

class SimpleHeader extends StatelessWidget {
  BoxConstraints constraints;
  String secondText;
  bool? hasBackArrow;
  String headerTitle;
  bool? hasSecondText;
  bool? hasSpacing;

  SimpleHeader({
    super.key,
    required this.constraints,
    required this.secondText,
    required this.headerTitle,
    this.hasBackArrow = false,
    this.hasSecondText = true,
    this.hasSpacing = true,
  });

  void showTransparentPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false, // Importante para a transparência
        pageBuilder: (BuildContext context, _, __) => const SelectColor(),
      ),
    );
  }

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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      color: palette!.tileColor.withOpacity(.7),
                      height: 120,
                      width: constraints.maxWidth,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                hasBackArrow!
                                    ? Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: InkWell(
                                          onTap: () => Navigator.of(context).pop(),
                                          child: SizedBox(
                                            width: 60,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.arrow_back_ios,
                                                  color: palette.titleColor,
                                                  size: 30,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : const Center(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: .1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 60,
                      width: constraints.maxWidth * .9,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: UtilsMethods.getMixedColor(palette.titleColor.withOpacity(.9)),
                      ),
                      child: Center(
                        child: Text(
                          headerTitle,
                          style: TextStyle(
                            color: palette.titleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            hasSpacing! ? const SizedBox(height: 20) : const Center(),
            hasSecondText!
                ? Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          secondText,
                          style: TextStyle(
                            color: palette.subTitleColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(),
          ],
        );
      },
    );
  }
}

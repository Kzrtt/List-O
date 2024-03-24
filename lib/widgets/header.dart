import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';
import 'package:prj_list_app/utils/AppController.dart';

class Header extends StatelessWidget {
  BoxConstraints constraints;
  String text;
  String secondText;
  bool? hasBackArrow;

  Header({
    super.key,
    required this.constraints,
    required this.text,
    required this.secondText,
    this.hasBackArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final palette = ref.watch(themeProvider).value;

        return Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 140,
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
                              ? InkWell(
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
                                )
                              : const Center(),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: InkWell(
                              onTap: () => ref.read(themeProvider.notifier).toggleTheme(),
                              child: SizedBox(
                                width: 60,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      palette.icon,
                                      color: palette.titleColor,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: InkWell(
                          onTap: () {},
                          child: SizedBox(
                            width: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.menu,
                                  color: palette.titleColor,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  color: palette.titleColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
        );
      },
    );
  }
}

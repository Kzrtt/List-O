import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';
import 'package:prj_list_app/widgets/buttonWithIcon.dart';

class Page01 extends StatelessWidget {
  BoxConstraints constraints;

  Page01({
    super.key,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer(
        builder: (context, ref, child) {
          final palette = ref.watch(themeProvider).value;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Introdução",
                  style: TextStyle(
                    color: palette.titleColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "O modo avançado do List-O consiste de uma adição de diversas novas funcionalidades planejadas para te auxiliar a manter uma rotina saudavel e se organizar melhor academicamene.",
                    style: TextStyle(
                      color: palette.titleColor.withOpacity(.8),
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20),
                  child: SizedBox(
                    height: 250,
                    width: constraints.maxWidth * .8,
                    child: SvgPicture.asset(
                      "assets/undraw_blog_post_re_fy5x.svg",
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                      colorFilter: ColorFilter.mode(palette.titleColor, BlendMode.modulate),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

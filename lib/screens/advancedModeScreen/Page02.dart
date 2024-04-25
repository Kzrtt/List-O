import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';

class Page02 extends StatelessWidget {
  BoxConstraints constraints;

  Page02({
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
                const SizedBox(height: 20),
                Text(
                  "Porque usar?",
                  style: TextStyle(
                    color: palette.titleColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Caso você queira apenas fazer listas o modo básico é suficiente, porém ao usar o Modo Avançado que é 100% gratuito você consegue muito mais funcionalidades legais!",
                    style: TextStyle(
                      color: palette.titleColor.withOpacity(.8),
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30),
                  child: SizedBox(
                    height: 250,
                    width: constraints.maxWidth,
                    child: SvgPicture.asset(
                      "assets/undraw_business_plan_re_0v81.svg",
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

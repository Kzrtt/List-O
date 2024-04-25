import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/controllers/userProvider.dart';
import 'package:prj_list_app/utils/routes.dart';
import 'package:prj_list_app/utils/validators.dart';
import 'package:prj_list_app/widgets/buttonWithIcon.dart';
import 'package:prj_list_app/widgets/loginHeader.dart';
import 'package:prj_list_app/widgets/simpleHeader.dart';
import 'package:prj_list_app/widgets/textForms.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";
  final loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        const palette = AppPalette.darkColorPalette;

        return LayoutBuilder(
          builder: (context, constraints) {
            return Scaffold(
              backgroundColor: palette.backgroundColor,
              body: SafeArea(
                child: Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  color: palette.tileColor.withOpacity(.7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Center(
                        child: Icon(
                          Icons.account_circle,
                          color: palette.titleColor,
                          size: 100,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Expanded(
                        child: Container(
                          width: constraints.maxWidth,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                            ),
                          ),
                          child: Form(
                            key: loginFormKey,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 40),
                                    Text(
                                      "Seja Bem Vindo!",
                                      style: TextStyle(
                                        color: palette.titleColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Efetue o login para acessar o App...",
                                      style: TextStyle(
                                        color: palette.tileColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 40),
                                    CustomTextFormFieldLogin(
                                      constraints: constraints,
                                      hintText: "seu_email@gmail.com",
                                      label: "Digite seu Email",
                                      onSaved: (text) {
                                        setState(() {
                                          email = text!;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    PasswordTextField(
                                      constraints: constraints,
                                      hintText: 'senha',
                                      validator: (text) => Validator.validateNotEmpty(text),
                                      label: "Senha",
                                      onSaved: (text) {
                                        setState(() {
                                          password = text!;
                                        });
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ButtonWithIcon(
                                            buttonText: "Visitante",
                                            height: 45,
                                            width: 160,
                                            borderRadius: 10,
                                            onTap: () async {
                                              GoRouter.of(context).push('/homeScreen');
                                            },
                                            iconSize: 22,
                                            icon: Icons.no_accounts_outlined,
                                          ),
                                          ButtonWithIcon(
                                            buttonText: "Login",
                                            height: 45,
                                            width: 160,
                                            borderRadius: 10,
                                            onTap: () async {
                                              if (loginFormKey.currentState!.validate()) {
                                                loginFormKey.currentState!.save();
                                                if (await ref.read(userProvider.notifier).login(email, password, context) == 1) {
                                                  GoRouter.of(context).push('/homeScreen');
                                                }
                                              }
                                            },
                                            iconSize: 20,
                                            icon: Icons.login,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 40),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Container(
                          height: 40,
                          width: constraints.maxWidth,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: palette.tileColor.withOpacity(.7),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () => GoRouter.of(context).push('/signUp'),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Não Possui Conta? Cadastre-se",
                                    style: TextStyle(
                                      color: palette.titleColor.withOpacity(.8),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

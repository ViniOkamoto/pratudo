import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/screens/login/login_store.dart';
import 'package:pratudo/features/widgets/app_primary_button.dart';
import 'package:pratudo/features/widgets/app_text_field.dart';
import 'package:pratudo/features/widgets/page_base_structure.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginStore _store = serviceLocator<LoginStore>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Observer(
            builder: (context) {
              return PageBaseStructurePage(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConverter.relativeWidth(24),
                ),
                children: [
                  Spacing(height: 64),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: AppTypo.p1(color: AppColors.darkerColor),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Bem vindo,\n',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: 'Entre com sua conta\npara continuar',
                        ),
                      ],
                    ),
                  ),
                  Spacing(height: 40),
                  AppTextField(
                    labelText: "Email",
                    onChanged: _store.setEmailText,
                    textEditingController: emailController,
                    hintText: "Insira seu email",
                  ),
                  Spacing(height: 16),
                  AppTextField(
                    labelText: "Senha",
                    onChanged: _store.setPassword,
                    textEditingController: passwordController,
                    hintText: "Insira sua senha",
                    isPassword: true,
                    onPressedIcon: () => _store.setObscurePassword(),
                    isObscure: _store.isObscurePassword,
                  ),
                  Spacing(height: 16),
                  GestureDetector(
                    child: Text(
                      "Esqueceu sua senha?",
                      style: AppTypo.p3(color: AppColors.lightGrayColor),
                    ),
                  ),
                  Spacing(height: 32),
                  AppPrimaryButton(
                    text: "Entrar",
                    isLoading: _store.isLoading,
                    onPressed: _store.isValid
                        ? () async {
                            if (!_store.isLoading) {
                              final result = await _store.login();
                              if (result) Navigator.pushNamedAndRemoveUntil(context, Routes.main, (route) => false);
                            }
                          }
                        : null,
                  ),
                  Spacing(height: 152),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, Routes.register),
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: "Não tem uma conta? ",
                          style: AppTypo.p3(color: AppColors.greyColor),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Registre-se!',
                              style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.highlightColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

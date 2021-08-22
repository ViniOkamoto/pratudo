import 'package:flutter/material.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/app_primary_button.dart';
import 'package:pratudo/features/widgets/app_text_field.dart';
import 'package:pratudo/features/widgets/page_base_structure.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: PageBaseStructurePage(
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
                onChanged: (value) {},
                textEditingController: TextEditingController(),
                hintText: "Insira seu email",
              ),
              Spacing(height: 16),
              AppTextField(
                labelText: "Senha",
                onChanged: (value) {},
                textEditingController: TextEditingController(),
                hintText: "Insira sua senha",
                isPassword: true,
                onPressedIcon: () {},
                isObscure: true,
              ),
              Spacing(height: 16),
              GestureDetector(
                child: Text(
                  "Esqueceu sua senha?",
                  style: AppTypo.p3(color: AppColors.lightGrayColor),
                ),
              ),
              Spacing(height: 32),
              AppPrimaryButton(text: "Entrar"),
              Spacing(height: 152),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Routes.register),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: "Não tem uma conta? ",
                      style: AppTypo.p3(color: AppColors.grayColor),
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
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/screens/register/register_store.dart';
import 'package:pratudo/features/widgets/app_primary_button.dart';
import 'package:pratudo/features/widgets/app_text_field.dart';
import 'package:pratudo/features/widgets/clean_app_bar.dart';
import 'package:pratudo/features/widgets/page_base_structure.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterStore _registerStore = serviceLocator<RegisterStore>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  late FToast fToast;
  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CleanAppBar(),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Observer(
            builder: (context) {
              return PageBaseStructurePage(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConverter.relativeWidth(24),
                ),
                children: [
                  Spacing(height: 24),
                  Text(
                    "Para começarmos,\nprecisaremos dos seus dados",
                    style: AppTypo.p1(color: AppColors.darkerColor),
                  ),
                  Spacing(height: 24),
                  AppTextField(
                    labelText: "Nome",
                    onChanged: _registerStore.setNameText,
                    textEditingController: nameController,
                    errorText: _registerStore.nameError,
                    hintText: "Insira seu nome",
                  ),
                  Spacing(height: 24),
                  AppTextField(
                    labelText: "Email",
                    onChanged: _registerStore.setEmailText,
                    textEditingController: emailController,
                    errorText: _registerStore.emailError,
                    hintText: "Insira seu email",
                  ),
                  Spacing(height: 24),
                  AppTextField(
                    onChanged: _registerStore.setPassword,
                    textEditingController: passwordController,
                    errorText: _registerStore.passwordError,
                    labelText: "Senha",
                    hintText: "Insira sua senha",
                    isPassword: true,
                    onPressedIcon: () => _registerStore.setObscurePassword(),
                    isObscure: _registerStore.isObscurePassword,
                  ),
                  Spacing(height: 24),
                  AppTextField(
                    onChanged: _registerStore.setConfirmPassword,
                    textEditingController: confirmPasswordController,
                    errorText: _registerStore.confirmPasswordError,
                    labelText: "Senha",
                    hintText: "Confirme sua senha",
                    isPassword: true,
                    onPressedIcon: () => _registerStore.setObscureConfirmPassword(),
                    isObscure: _registerStore.isObscureConfirmPassword,
                  ),
                  Spacing(height: 32),
                  AppPrimaryButton(
                    isLoading: _registerStore.isLoading,
                    text: "Cadastrar",
                    onPressed: _registerStore.isValid
                        ? () async {
                            if (!_registerStore.isLoading) {
                              final isRegistered = await _registerStore.registerUser();
                              if (isRegistered) {
                                final result = await _registerStore.login();
                                if (result) {
                                  Navigator.pushNamedAndRemoveUntil(context, Routes.main, (route) => false);
                                  return;
                                }
                                fToast.showToast(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: SizeConverter.relativeWidth(24),
                                      vertical: SizeConverter.relativeHeight(12),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      color: Colors.greenAccent,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(LineAwesomeIcons.check),
                                        Spacing(width: 8),
                                        Text("Usuário criado com sucesso!"),
                                      ],
                                    ),
                                  ),
                                  gravity: ToastGravity.BOTTOM,
                                  toastDuration: Duration(seconds: 3),
                                );
                                return Navigator.pop(context);
                              }
                            }
                          }
                        : null,
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

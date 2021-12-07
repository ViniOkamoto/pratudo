import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/screens/main/views/profile/widgets/profile_button.dart';
import 'package:pratudo/features/screens/main/views/profile/widgets/user_info_section.dart';
import 'package:pratudo/features/stores/shared/user_information_store.dart';
import 'package:pratudo/features/stores/shared/user_progress_store.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class ProfileView extends StatelessWidget {
  final UserInformationStore _userInformationStore =
      serviceLocator<UserInformationStore>();
  final UserProgressStore _userProgressStore =
      serviceLocator<UserProgressStore>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        vertical: SizeConverter.relativeHeight(16),
        horizontal: SizeConverter.relativeWidth(16),
      ),
      child: Column(
        children: [
          UserInfoSection(
            userProgressStore: _userProgressStore,
          ),
          Spacing(height: 24),
          ProfileButton(
            label: 'Meu Desempenho',
            icon: LineAwesomeIcons.trophy,
            onTap: () => Navigator.pushNamed(context, Routes.myPerformance),
          ),
          ProfileButton(
            label: 'Minhas Receitas',
            icon: LineAwesomeIcons.list,
            onTap: () => Navigator.pushNamed(context, Routes.myRecipes),
          ),
          ProfileButton(
            label: 'Minhas Informações',
            icon: LineAwesomeIcons.cog,
            onTap: () {},
          ),
          ProfileButton(
            label: 'Sair',
            icon: LineAwesomeIcons.door_open,
            onTap: () async {
              await _userInformationStore.logout();
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.splash, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}

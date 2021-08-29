import 'package:flutter/material.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/features/stores/user_information_store.dart';

class ProfileView extends StatelessWidget {
  final UserInformationStore _userInformationStore = serviceLocator<UserInformationStore>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _userInformationStore.logout();
        Navigator.pushNamedAndRemoveUntil(context, Routes.splash, (route) => false);
      },
      child: Container(
        child: Text("profile logout"),
      ),
    );
  }
}

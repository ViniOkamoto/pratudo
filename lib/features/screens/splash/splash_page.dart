import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/stores/shared/user_information_store.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final UserInformationStore _userInformationStore = serviceLocator<UserInformationStore>();
  double _opacity = 0;

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  void initState() {
    _loadSplash();
    super.initState();
  }

  _loadSplash() {
    Timer(
      Duration(seconds: 1),
      () => setState(
        () {
          _opacity = 1;
          Timer(
            Duration(seconds: 2),
            () async {
              final isLogged = await _userInformationStore.checkIfUserIsLogged();
              if (isLogged) {
                Navigator.pushNamedAndRemoveUntil(context, Routes.main, (route) => false);
                return;
              }
              Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
              return;
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.highlightColor,
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: SizeConverter.relativeWidth(140),
                          child: Image.asset('assets/images/logo.png'),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: SizeConverter.relativeHeight(98)),
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 1000),
                            opacity: _opacity,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'Ajudando você a criar os\n ',
                                style: AppTypo.p2(color: AppColors.whiteColor),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'melhores pratos',
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

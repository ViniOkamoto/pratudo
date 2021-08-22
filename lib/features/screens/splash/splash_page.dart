import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _opacity = 0;

  @override
  void initState() {
    Timer(
      Duration(seconds: 1),
      () => setState(
        () {
          _opacity = 1;
          Timer(
            Duration(seconds: 3),
            () => Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false),
          );
        },
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.highlightColor,
      body: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: SizeConverter.relativeWidth(129),
                  child: Image.asset('assets/images/logo.png'),
                ),
                Spacing(height: 48),
                AnimatedOpacity(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

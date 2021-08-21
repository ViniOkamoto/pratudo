import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pratudo/core/resources/constants.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/core/router.dart' as App;
import 'package:pratudo/core/theme/app_theme.dart';

class PratudoApp extends StatefulWidget {
  @override
  _PratudoAppState createState() => _PratudoAppState();
}

class _PratudoAppState extends State<PratudoApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      theme: appTheme,
      navigatorKey: Constants.appGlobalKey,
      debugShowCheckedModeBanner: false,
      title: 'Pratudo',
      onGenerateRoute: App.Router.generateRoute,
      initialRoute: Routes.splash,
    );
  }
}

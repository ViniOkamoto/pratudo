import 'package:pratudo/core/resources/constants.dart';

class NavigationWithoutContext {
  Future<dynamic> pushReplacementNamed(String routeName) {
    return Constants.appGlobalKey.currentState!.pushReplacementNamed(routeName);
  }

  Future<dynamic> pushNamed(String routeName) {
    return Constants.appGlobalKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName) {
    return Constants.appGlobalKey.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false);
  }
}

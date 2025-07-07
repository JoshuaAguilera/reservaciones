import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void navigateToLoginAndReplace() {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      'login',
      (route) => false,
      arguments: const Tuple2(
        true,
        "Tu sesión ha expirado. Inicia sesión nuevamente.",
      ),
    );
  }

  void navigateTo(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  void pushReplacement(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }
}

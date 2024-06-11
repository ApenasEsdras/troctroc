// ignore_for_file: overridden_fields

import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

class GuardOnBoardingScreen extends RouteGuard {
  @override
  final String redirectTo;
  final Box settingsBox;

  GuardOnBoardingScreen({
    required this.redirectTo,
    required this.settingsBox,
  });

  @override
  FutureOr<bool> canActivate(String path, ModularRoute route) async {
    final hasData = settingsBox.isNotEmpty;

    if (hasData) {
      Modular.to.navigate(redirectTo);
      return false;
    }

    return true;
  }
}

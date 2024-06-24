import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'styles/theme/theme_config.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/');
    return MaterialApp.router(
      title: 'AppInnovaro',
      theme: ThemeConfig.temaInnovaro,
      routerConfig: Modular.routerConfig,
      debugShowCheckedModeBanner: false,
    );
  }
}

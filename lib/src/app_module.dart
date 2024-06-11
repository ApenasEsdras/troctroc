import 'package:flutter_modular/flutter_modular.dart';
import 'config/hive_config.dart';
import 'features/home/screen/home_screen.dart';
import 'features/onboarding/onboarding_screen_guard.dart';
import 'features/onboarding/screen/onboarding_screen.dart';
import 'features/onboarding/screen/onboarding_screen_success.dart';
import 'repo_testes_widgets/notifi_service.dart';

class AppModule extends Module {
  final AppSettings appSettings;
  AppModule(this.appSettings);
  @override
  void binds(i) {
    NotificationService();
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const OnBoardingScreen(),
      guards: [
        GuardOnBoardingScreen(
          redirectTo: '/home',
          settingsBox: appSettings.box,
        ),
      ],
      transition: TransitionType.rightToLeft,
    );

    r.child(
      '/home',
      child: (context) => const HomePage(),
    );

    r.child(
      '/tokenActivationSuccess',
      child: (context) => const OnBoardingScreenSuccess(),
      transition: TransitionType.rightToLeft,
    );
  }
}

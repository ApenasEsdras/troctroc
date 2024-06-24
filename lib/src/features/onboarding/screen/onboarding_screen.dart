// ignore_for_file: unused_element, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../config/hive_config.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/text_strings.dart';
import '../../../helpers/custom_snackbar.dart';
import '../../../styles/colors_app.dart';
import '../../../styles/text_styles.dart';
import '../onboarding_service.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _chaveController = TextEditingController();
  final onboardingServiceExecult = OnboardingService();
  bool hasRestarted = false;
  late AppSettings appSettings;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    appSettings = AppSettings();
    appSettings.startSettings();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pages = [
      buildPage(
        context,
        image: onBoardingImage1,
        title: OnBoardingTitle1,
        text: OnBoardingText1,
        imageSize: size.height * 0.32,
      ),
      buildPage(
        context,
        image: onBoardingImage2,
        title: OnBoardingTitle2,
        text: OnBoardingText2,
        imageSize: size.height * 0.37,
      ),
      buildLastPage(context, size),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            children: pages,
          ),
          Positioned(
            bottom: 60.0,
            child: OutlinedButton(
              onPressed: () async {
                if (currentPage == 2) {
                  final firebaseData = await onboardingServiceExecult
                      .readDataFirebase(_chaveController);
                  if (!firebaseData.isNotEmpty) {
                    CustomAlertDialog.mostraSnackBar(
                      context,
                      'Chave inválida ou não existente.',
                    );
                  }
                  await appSettings.startSettings();
                  await appSettings.setFirebaseData(firebaseData);
                  if (appSettings.box.isNotEmpty && !hasRestarted) {
                    Modular.to.pushNamed('/tokenActivationSuccess');
                  }
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(color: ColorsApp.instance.Laranja),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: ColorsApp.instance.Laranja,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: TextButton(
              onPressed: () => _pageController.jumpToPage(2),
              child: Text(
                'Pular',
                style: TextStyles.instance.textMedium16Laranja,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: AnimatedSmoothIndicator(
              activeIndex: currentPage,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: ColorsApp.instance.Laranja,
                dotHeight: 5.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(BuildContext context,
      {required String image,
      required String title,
      required String text,
      required double imageSize}) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: ColorsApp.instance.Branco,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage(image),
            height: imageSize,
          ),
          Column(
            children: [
              Text(
                title,
                style: TextStyles.instance.textBold36,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                text,
                style: TextStyles.instance.textMedium20,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 120),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildLastPage(BuildContext context, Size size) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: ColorsApp.instance.Branco,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: const AssetImage(onBoardingImage3),
            height: size.height * 0.35,
          ),
          Column(
            children: [
              Text(
                OnBoardingTitle3,
                style: TextStyles.instance.textBold36,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _chaveController,
                style: TextStyle(
                  color: ColorsApp.instance.CinzaEscuro,
                ),
                decoration: InputDecoration(
                  floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                    (Set<MaterialState> states) {
                      final Color color =
                          states.contains(MaterialState.focused)
                              ? ColorsApp.instance.Laranja
                              : ColorsApp.instance.CinzaMedio2;
                      return TextStyle(color: color);
                    },
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsApp.instance.Laranja,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: Icon(
                    Icons.key,
                    color: ColorsApp.instance.CinzaEscuro,
                  ),
                  labelText: 'Chave',
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 200),
            ],
          ),
        ],
      ),
    );
  }
}

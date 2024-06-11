// ignore_for_file: unused_element, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../config/hive_config.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/text_strings.dart';
import '../../../helpers/custom_snackbar.dart';
import '../../../styles/colors_app.dart';
import '../../../styles/text_styles.dart';
import '../onboarding_service.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = LiquidController();
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
      Container(
        padding: const EdgeInsets.all(20),
        color: ColorsApp.instance.Branco,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Imagem
            Image(
              image: const AssetImage(onBoardingImage1),
              height: size.height * 0.32,
            ),
            //Título + Texto
            Column(
              children: [
                Text(
                  OnBoardingTitle1,
                  style: TextStyles.instance.textBold36,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  OnBoardingText1,
                  style: TextStyles.instance.textMedium20,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 120),
              ],
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(20),
        color: ColorsApp.instance.Branco,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Imagem
            Image(
              image: const AssetImage(onBoardingImage2),
              height: size.height * 0.37,
            ),
            //Título + Texto
            Column(
              children: [
                Text(
                  OnBoardingTitle2,
                  style: TextStyles.instance.textBold36,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  OnBoardingText2,
                  style: TextStyles.instance.textMedium20,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 120),
              ],
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(30),
        color: ColorsApp.instance.Branco,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Imagem
            Image(
              image: const AssetImage(onBoardingImage3),
              height: size.height * 0.35,
            ),
            //Título + Input
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
                  //controller: ,
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
      ),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: pages,
            liquidController: controller,
            onPageChangeCallback: onPageChangedCallback,
          ),
          //Botão
          Positioned(
            bottom: 60.0,
            child: OutlinedButton(
              // No método onPressed do botão de avançar no OnBoardingScreen
              onPressed: () async {
                if (controller.currentPage == 2) {
                  final firebaseData = await onboardingServiceExecult
                      .readDataFirebase(_chaveController);
                  // Validação caso o firebase não obtenha dados
                  if (!firebaseData.isNotEmpty) {
                    CustomAlertDialog.mostraSnackBar(
                      context,
                      'Chave inválida ou não existente.',
                    );
                  }
                  await appSettings
                      .startSettings(); // Garante que o box do Hive está inicializado
                  await appSettings.setFirebaseData(firebaseData);
                  if (appSettings.box.isNotEmpty && !hasRestarted) {
                    Modular.to.pushNamed('/tokenActivationSuccess');
                  }
                } else {
                  final int nextPage = controller.currentPage + 1;
                  controller.jumpToPage(page: nextPage);
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
          //Pular
          Positioned(
            top: 15,
            right: 15,
            child: TextButton(
              onPressed: () => controller.jumpToPage(page: 2),
              child: Text(
                'Pular',
                style: TextStyles.instance.textMedium16Laranja,
              ),
            ),
          ),
          //PageIndicator
          Positioned(
            bottom: 10,
            child: AnimatedSmoothIndicator(
              activeIndex: controller.currentPage,
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

  void onPageChangedCallback(int activePageIndex) {
    setState(() {
      currentPage = activePageIndex;
    });
  }
}

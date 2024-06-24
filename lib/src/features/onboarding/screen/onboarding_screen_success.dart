import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/text_strings.dart';
import '../../../styles/colors_app.dart';
import '../../../styles/text_styles.dart';

class OnBoardingScreenSuccess extends StatelessWidget {
  const OnBoardingScreenSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: ColorsApp.instance.Branco,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Imagem
                Image(
                  image: const AssetImage(onBoardingImage4),
                  height: size.height * 0.32,
                ),
                const SizedBox(
                  height: 15,
                ),
                //Título + Texto + Token
                Column(
                  children: [
                    Text(
                      OnBoardingTitle4,
                      style: TextStyles.instance.textBold36,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      OnBoardingText3,
                      style: TextStyles.instance.textMedium20,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 110),
                  ],
                ),
                //Botão
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      Restart.restartApp();
                    },
                    child: const Text('Continuar'),
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

import 'package:flutter/material.dart';
import 'colors_app.dart';
import 'text_styles.dart';
import 'theme/theme_config.dart';

class AppStyles {
  static AppStyles? _instance;

  AppStyles._();

  static AppStyles get instance {
    _instance ??= AppStyles._();
    return _instance!;
  }

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        backgroundColor: ColorsApp.instance.Laranja,
        textStyle: TextStyles.instance.textMedium20,
        foregroundColor: Colors.white,
      );
}

InputDecoration decorationInput(String labelText) {
  return InputDecoration(
    fillColor: ColorsApp.instance.Branco,
    labelText: labelText,
    labelStyle: TextStyle(
      fontFamily: 'roboto',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: ColorsApp.instance.CinzaEscuro,
    ),
    floatingLabelStyle: MaterialStateTextStyle.resolveWith(
      (Set<MaterialState> states) {
        final Color color = ColorsApp.instance.CinzaMedio2;
        return TextStyle(color: color);
      },
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: ThemeConfig.themeInitial.primaryColor,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.8,
        color: ColorsApp.instance.CinzaMedio,
      ),
    ),
  );
}

InputDecoration decorationReadOnly(String labelText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: TextStyle(
      fontFamily: 'roboto',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: ColorsApp.instance.CinzaEscuro,
    ),
    floatingLabelStyle: MaterialStateTextStyle.resolveWith(
      (Set<MaterialState> states) {
        final Color color = ColorsApp.instance.CinzaMedio2;
        return TextStyle(
          fontFamily: 'roboto',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: color,
        );
      },
    ),
    fillColor: ColorsApp.instance.CinzaClaro,
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.8,
        color: ColorsApp.instance.CinzaMedio,
      ),
    ),
  );
}

extension AppStylesExtension on BuildContext {
  AppStyles get appStyles => AppStyles.instance;
}

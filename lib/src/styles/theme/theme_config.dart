// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '../colors_app.dart';
import '../text_styles.dart';

class ThemeConfig {

  static Color laranja = const Color(0xFFF6A200);
  static Color verde = const Color(0xFF7AC74F);
  static Color vermelho = const Color(0xFFE71D36);
  static Color vermelhoFortes = const Color(0xFFCE1719);

  Color get CinzaEscuro => const Color.fromRGBO(69, 69, 69, 1);
  Color get CinzaMedio => const Color.fromRGBO(205, 205, 205, 1);
  Color get CinzaMedio2 => const Color.fromRGBO(69, 69, 69, 0.7);
  Color get CinzaClaro => const Color.fromRGBO(69, 69, 69, 0.1);

  static Color branco = const Color(0xFFFDFDFD);
  static Color preto = const Color(0xFF454545);

  static final themeInitial = ThemeData(
    scaffoldBackgroundColor: ThemeConfig.branco,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: ThemeConfig.laranja,
      primary: ThemeConfig.laranja,
      background: ThemeConfig.branco,
      surface: ThemeConfig.branco,
      error: ThemeConfig.vermelho,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ThemeConfig.branco,
      foregroundColor: ThemeConfig.laranja,
      surfaceTintColor: ThemeConfig.branco,
      elevation: 0,
      iconTheme: IconThemeData(
        color: ThemeConfig.laranja,
        size: 35,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        backgroundColor: ThemeConfig.laranja,
        textStyle: TextStyles.instance.textMedium20,
        foregroundColor: ThemeConfig.branco,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: ThemeConfig.branco,
      filled: true,
      isDense: true,
      iconColor: ThemeConfig.preto,
      contentPadding: const EdgeInsets.all(20),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: ColorsApp.instance.CinzaMedio),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: ThemeConfig.laranja),
      ),
      labelStyle:
          TextStyles.instance.textMedium.copyWith(color: ThemeConfig.preto),
      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
        (Set<MaterialState> states) {
          final Color color = ColorsApp.instance.CinzaMedio2;
          return TextStyle(color: color);
        },
      ),
      errorStyle:
          TextStyles.instance.textRegular.copyWith(color: ThemeConfig.vermelho),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: ThemeConfig.branco,
      surfaceTintColor: ThemeConfig.branco,
    ),
    dialogTheme: DialogTheme(
      surfaceTintColor: ThemeConfig.branco,
      backgroundColor: ThemeConfig.branco,
    ),
    iconTheme: IconThemeData(
      color: ThemeConfig.preto,
    ),
  );
}

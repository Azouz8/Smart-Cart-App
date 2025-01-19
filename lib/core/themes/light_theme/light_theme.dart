import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';
import 'package:smart_cart_app/core/themes/light_theme/text_styles_light.dart';

ThemeData getLightTheme() => ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColorsLight.scaffoldBackgroundColor,
      textTheme: TextTheme(
        bodyLarge: TextStylesLight.getBodyLarge(),
        bodySmall: TextStylesLight.getBodySmall(),
        bodyMedium: TextStylesLight.getBodyMedium(),
        labelLarge: TextStylesLight.getLabelLarge(),
        titleMedium: TextStylesLight.getTitleMedium(),
        titleSmall: TextStylesLight.getTitleSmall(),
        headlineSmall: TextStylesLight.getHeadlineSmall(),
        headlineMedium: TextStylesLight.getHeadlineMedium(),
        headlineLarge: TextStylesLight.getHeadlineLarge(),
        displaySmall: TextStylesLight.getDisplaySmall(),
        displayMedium: TextStylesLight.getDisplayMedium(),
        displayLarge: TextStylesLight.getDisplayLarge(),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: AppColorsLight.appBarCompsColor),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColorsLight.appBarCompsColor),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white70,
        selectedIconTheme: IconThemeData(color: Color(0xffff5d65)),
        selectedItemColor: Color(0xffff5d65),
      ),
      appBarTheme: const AppBarTheme(
        color: AppColorsLight.scaffoldBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: AppColorsLight.scaffoldBackgroundColor,
        ),
      ),
    );

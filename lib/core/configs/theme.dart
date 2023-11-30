import 'package:flutter/material.dart';
import 'package:taskmanager/core/configs/appcolor.dart';
import 'package:taskmanager/core/configs/apptextstyle.dart';

////////////////////////App Themes////////////////////////////////
class AppThemes {
  static ThemeData get lightTheme => ThemeData(
      brightness: Brightness.light,
      disabledColor: AppColors.black,
      unselectedWidgetColor: AppColors.unselcetedlight,
      primaryIconTheme: Icontheme.lightIconTheme,
      textTheme: TextThemes.primaryTextTheme,
      primaryColor: AppColors.blue,
      cardColor: AppColors.white,
      colorScheme: const ColorScheme.light(
          brightness: Brightness.light,
          primary: Colors.teal,
          secondary: AppColors.red,
          background: AppColors.white),
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: AppBarTheme(
          elevation: 0,
          titleTextStyle: TextThemes.primaryTextTheme.bodyMedium,
          backgroundColor: AppColors.white,
          iconTheme: Icontheme.lightIconTheme));
}

////////////////////////Text Theme////////////////////////////////
class TextThemes {
  static TextTheme get textTheme {
    return TextTheme(
      bodyLarge: AppTextStyles.bodylg,
      bodyMedium: AppTextStyles.body,
      titleMedium: AppTextStyles.bodysm,
      titleSmall: AppTextStyles.bodyesm,
      displayLarge: AppTextStyles.h1,
      displayMedium: AppTextStyles.h2,
      displaySmall: AppTextStyles.h3,
      headlineMedium: AppTextStyles.h4,
    );
  }

  static TextTheme get primaryTextTheme {
    Color textColor = AppColors.black;
    return TextTheme(
      bodyLarge: AppTextStyles.bodylg.copyWith(color: textColor),
      bodyMedium: AppTextStyles.body.copyWith(color: textColor),
      titleMedium: AppTextStyles.bodysm.copyWith(color: textColor),
      titleSmall: AppTextStyles.bodyesm.copyWith(color: textColor),
      displayLarge: AppTextStyles.h1.copyWith(color: textColor),
      displayMedium: AppTextStyles.h2.copyWith(color: textColor),
      displaySmall: AppTextStyles.h3.copyWith(color: textColor),
      headlineMedium: AppTextStyles.h4.copyWith(color: textColor),
    );
  }
}

////////////////////////Icon Theme////////////////////////////////
class Icontheme {
  static IconThemeData get lightIconTheme =>
      const IconThemeData(size: 25, color: AppColors.black);
}

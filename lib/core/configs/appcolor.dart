import 'package:flutter/material.dart';

class AppColors {
  static const List<Color> colorList = [
    red,
    teal,
    yellow,
    Colors.orangeAccent,
    grey,
    Colors.indigo,
    Colors.lightGreen
  ];

  static const Color black = Color(0xff0D0D0D);

  static const Color white = Color(0xffffffff);

  static const Color yellow = Color(0xffFFEC42);

  static const Color purple = Color(0xff4B0082);

  static const Color teal = Color(0xff008080);

  static const Color pink = Color(0xffFFC0CB);

  static const Color red = Color(0xffFE2C55);

  static const Color grey = Color(0xff808080);

  static const Color blue = Color(0xff0015CE);

  static const Color unselcetedlight = Color(0xffC9D7EE);

  static const Color unselceteddark = Color(0xffF2F2F2);

  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1, 'shade values must be between 0 and 1');

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
      (darker ? (hsl.lightness - value) : (hsl.lightness + value))
          .clamp(0.0, 1.0),
    );

    return hslDark.toColor();
  }

  static MaterialColor getMaterialColorFromColor(Color color) {
    final colorShades = <int, Color>{
      50: getShade(color, value: 0.5),
      100: getShade(color, value: 0.4),
      200: getShade(color, value: 0.3),
      300: getShade(color, value: 0.2),
      400: getShade(color, value: 0.1),
      500: color,
      600: getShade(color, value: 0.1, darker: true),
      700: getShade(color, value: 0.15, darker: true),
      800: getShade(color, value: 0.2, darker: true),
      900: getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, colorShades);
  }
}

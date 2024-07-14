import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeService {
  // Princeton Orange (#FF7D29)
  static Color orange = const Color(0xffFF7D29);

  // Snow (#FFFAFA)
  static Color white = const Color(0xffFFFAFA);

  // Midnight Blue (#101720)
  static Color black = const Color(0xff101720);

  // Bright Gray (#EEEEEE)
  static Color bgGreyLight = const Color(0xffEEEEEE);

  // Dark Charcoal (#333333)
  static Color bgGreyDark = const Color(0xff333333);

  static ThemeData getLightTheme(context) {
    ThemeData lightTheme = ThemeData(
      primarySwatch: getMaterialColor(orange),
      brightness: Brightness.light,
      primaryColor: orange,
      colorScheme: Theme.of(context).colorScheme.copyWith(
            brightness: Brightness.light,
            primary: white,
            secondary: orange,
            tertiary: black,
          ),
      scaffoldBackgroundColor: bgGreyLight,
      textTheme: GoogleFonts.signikaNegativeTextTheme(
        Theme.of(context).textTheme,
      ),
      appBarTheme: AppBarTheme(titleTextStyle: TextStyle(color: black)),
    );
    return lightTheme;
  }

  static ThemeData getDarkTheme(context) {
    ThemeData darkTheme = ThemeData(
      primarySwatch: getMaterialColor(orange),
      brightness: Brightness.dark,
      primaryColor: orange,
      colorScheme: Theme.of(context).colorScheme.copyWith(
            brightness: Brightness.dark,
            primary: black,
            secondary: orange,
            tertiary: white,
          ),
      scaffoldBackgroundColor: bgGreyDark,
      textTheme: GoogleFonts.signikaNegativeTextTheme(
        Theme.of(context).textTheme,
      ),
      appBarTheme: AppBarTheme(titleTextStyle: TextStyle(color: white)),
    );
    return darkTheme;
  }

  static MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }
}

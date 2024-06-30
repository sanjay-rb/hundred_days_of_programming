import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeDataConstant {
  Color primayColor = const Color(0xffFF7D29);
  Color secondaryColor =
      const Color(0xffFFFAFA); // Snow (#FFFAFA): Softly Radiant
  Color tertiaryColor =
      const Color(0xff101720); // Midnight Blue (#101720): Cool and Calm

  ThemeData getLightTheme(context) {
    ThemeData lightTheme = ThemeData(
      primarySwatch: getMaterialColor(primayColor),
      brightness: Brightness.light,
      primaryColor: primayColor,
      colorScheme: Theme.of(context).colorScheme.copyWith(
            brightness: Brightness.light,
            primary: primayColor,
            onPrimary: secondaryColor,
            secondary: secondaryColor,
            onSecondary: tertiaryColor,
            tertiary: tertiaryColor,
            onTertiary: primayColor,
          ),
      textTheme: GoogleFonts.signikaNegativeTextTheme(
        Theme.of(context).textTheme,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(secondaryColor),
        ),
      ),
    );
    return lightTheme;
  }

  ThemeData getDarkTheme(context) {
    ThemeData darkTheme = ThemeData(
      primarySwatch: getMaterialColor(primayColor),
      brightness: Brightness.dark,
      primaryColor: primayColor,
      colorScheme: Theme.of(context).colorScheme.copyWith(
            brightness: Brightness.dark,
            primary: primayColor,
            onPrimary: tertiaryColor,
            secondary: tertiaryColor,
            onSecondary: secondaryColor,
            tertiary: secondaryColor,
            onTertiary: primayColor,
          ),
      textTheme: GoogleFonts.signikaNegativeTextTheme(
        Theme.of(context).textTheme,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(secondaryColor),
        ),
      ),
    );
    return darkTheme;
  }

  MaterialColor getMaterialColor(Color color) {
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

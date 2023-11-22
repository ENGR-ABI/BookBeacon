import 'package:bookbeacon/app/services/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/values.dart';
import 'color_schemes.g.dart';
import 'dart:ui' as ui;

class ThemeController extends GetxController {
  static ThemeController get inst => Get.find();

  late Rx<ThemeData> activeTheme;
  late ThemeData _lightTheme;
  ThemeData get lightTheme => _lightTheme;
  late ThemeData _darkTheme;
  ThemeData get darkTheme => _darkTheme;
  late Rx<ThemeMode> themeMode;

  Future<ThemeController> loadThemeData() async {
    _lightTheme = ThemeData.from(
      colorScheme: lightColorScheme,
      textTheme: Typography.englishLike2021.apply(
        fontFamily: 'Nunito',
        bodyColor: lightColorScheme.onBackground,
        displayColor: lightColorScheme.primary,
      ),
    ).copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          )),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            const Size(88, 36),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          )),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            const Size(88, 36),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          )),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              style: BorderStyle.solid,
              width: 2,
              color: lightColorScheme.primary,
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            const Size(88, 36),
          ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(14, 10, 14, 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );

    _darkTheme = ThemeData.from(
      colorScheme: darkColorScheme,
      textTheme: Typography.englishLike2021.apply(
        fontFamily: 'Nunito',
        bodyColor: darkColorScheme.onBackground,
        displayColor: darkColorScheme.primary,
      ),
    ).copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          )),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            const Size(88, 36),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          )),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            const Size(88, 36),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          )),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              style: BorderStyle.solid,
              width: 2,
              color: darkColorScheme.primary,
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            const Size(88, 36),
          ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(14, 10, 14, 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );

    final savedTheme = AppStorage.inst.fetch(THEME_MODE_KEY);
    Brightness deviceThemeMode = Brightness.light;
    if (savedTheme == THEME_MODE_LIGHT) {
      themeMode = Rx(ThemeMode.light);
      //themeMode = Rx(ThemeMode.dark);
    } else if (savedTheme == THEME_MODE_DARK) {
      themeMode = Rx(ThemeMode.dark);
    } else {
      deviceThemeMode = ui.PlatformDispatcher.instance.platformBrightness;
      themeMode = deviceThemeMode == Brightness.light
          ? Rx(ThemeMode.light)
          : Rx(ThemeMode.light); //Rx(ThemeMode.dark);
    }
    activeTheme =
        themeMode.value == ThemeMode.light ? Rx(lightTheme) : Rx(darkTheme);
    return this;
  }
}

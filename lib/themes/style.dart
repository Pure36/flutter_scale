// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_scale/themes/color.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'IBMPlexSansThai',
    primaryColor: primary,
    errorColor: Colors.red,
    hoverColor: Colors.grey,
    colorScheme: ColorScheme.light(primary: primary),
    iconTheme: IconThemeData(color: primary_text),
    scaffoldBackgroundColor: icons,
    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      foregroundColor: icons,
      iconTheme: IconThemeData(color: icons)
    )
  );
}
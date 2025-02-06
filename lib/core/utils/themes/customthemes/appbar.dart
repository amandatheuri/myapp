import 'package:flutter/material.dart';
import 'package:myapp/core/utils/themes/customthemes/texttheme.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static final AppBarTheme lightTheme =AppBarTheme(
    elevation: 0,
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.black, size: 18),
    titleTextStyle: TTexttheme.lightTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    actionsIconTheme: IconThemeData(color: Colors.black)
  );
  static final AppBarTheme darkTheme =AppBarTheme(
    elevation: 0,
    centerTitle: true,
    titleSpacing: 20,
    iconTheme: const IconThemeData(color: Colors.white, size: 20),
    titleTextStyle: TTexttheme.darkTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    actionsIconTheme: IconThemeData(color: Colors.white)
  );

}
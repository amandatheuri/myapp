import 'package:flutter/material.dart';
import 'package:myapp/core/utils/themes/customthemes/texttheme.dart';

class TAppTheme {
  TAppTheme._();

  static var lightTheme =AppBarTheme(
    elevation: 0,
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.black, size: 18),
    titleTextStyle: TTexttheme.lightTheme.bodySmall,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    actionsIconTheme: IconThemeData(color: Colors.black)
  );
  static var darkTheme =AppBarTheme(
  elevation: 0,
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.white, size: 18),
    titleTextStyle: TTexttheme.lightTheme.bodySmall,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    actionsIconTheme: IconThemeData(color: Colors.white)
  );

}
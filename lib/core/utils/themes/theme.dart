import 'package:flutter/material.dart';
import 'package:myapp/core/utils/constants/colors.dart';
import 'package:myapp/core/utils/themes/customthemes/appbar.dart';
import 'package:myapp/core/utils/themes/customthemes/bottomsheet.dart';
import 'package:myapp/core/utils/themes/customthemes/checkbox.dart';
import 'package:myapp/core/utils/themes/customthemes/elevatedbutton.dart';
import 'package:myapp/core/utils/themes/customthemes/outlinedbutton.dart';
import 'package:myapp/core/utils/themes/customthemes/textfield.dart';
import 'package:myapp/core/utils/themes/customthemes/texttheme.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: TColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTexttheme.lightTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightTheme,
    outlinedButtonTheme: TOutlinedButton.lightTheme,
    appBarTheme: TAppBarTheme.lightTheme,
    inputDecorationTheme: TTextField.allThemes,
    checkboxTheme: TCheckBox.lightTheme,
    bottomSheetTheme: TBottomsheet.darkTheme,
  );
  static ThemeData darkTheme = ThemeData(
     useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: TColors.primaryColor,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TTexttheme.darkTheme,
    appBarTheme: TAppBarTheme.darkTheme,
    outlinedButtonTheme: TOutlinedButton.darkTheme,
    checkboxTheme: TCheckBox.darkTheme,
    bottomSheetTheme: TBottomsheet.darkTheme,
    inputDecorationTheme: TTextField.allThemes,
    elevatedButtonTheme: TElevatedButtonTheme.darkTheme
  );
}

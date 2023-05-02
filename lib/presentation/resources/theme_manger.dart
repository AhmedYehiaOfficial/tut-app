import 'package:flutter/material.dart';
import 'package:flutter_adv/presentation/resources/color_manger.dart';
import 'package:flutter_adv/presentation/resources/font_manger.dart';
import 'package:flutter_adv/presentation/resources/styles_manger.dart';
import 'package:flutter_adv/presentation/resources/values_manger.dart';

getApplicationTheme() {
  return ThemeData(
    //main colors
    primaryColor: ColorManger.primary,
    primaryColorLight: ColorManger.lightPrimary,
    primaryColorDark: ColorManger.darkPrimary,
    disabledColor: ColorManger.grey1,
    splashColor: ColorManger.lightPrimary,
    //ripple effect color
    //card-view theme
    cardTheme: CardTheme(
        color: ColorManger.white,
        shadowColor: ColorManger.grey,
        elevation: AppSize.s4),
    //app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManger.primary,
        elevation: AppSize.s4,
        shadowColor: ColorManger.lightPrimary,
        titleTextStyle:
            getRegularStyle(color: ColorManger.white, fontSize: FontSize.s16)),
    //button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManger.grey1,
      buttonColor: ColorManger.primary,
      splashColor: ColorManger.lightPrimary,
    ),
    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
              color: ColorManger.white,
              fontSize: FontSize.s17,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppPadding.p12),
            ))),
    //Text Theme
    textTheme: TextTheme(
      displayLarge:
          getLightStyle(color: ColorManger.darkGrey, fontSize: FontSize.s16),
      headlineLarge:
          getSemiBoldStyle(color: ColorManger.darkGrey, fontSize: FontSize.s16),
      titleMedium:
          getMediumStyle(color: ColorManger.primary, fontSize: FontSize.s16),
      bodyLarge: getRegularStyle(color: ColorManger.grey1),
      bodySmall: getRegularStyle(color: ColorManger.grey),
      headlineMedium:
      getRegularStyle(color: ColorManger.darkGrey, fontSize: FontSize.s14),
    ),
    // input decoration theme (TF)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      //hint style
      hintStyle:
          getRegularStyle(color: ColorManger.grey, fontSize: FontSize.s14),
      labelStyle:
          getRegularStyle(color: ColorManger.grey, fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: ColorManger.error),
      //enable border style
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManger.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      //focused border style
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManger.grey, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      //Error border style
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManger.error, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      //focused Error border style
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManger.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
    ),
  );
}

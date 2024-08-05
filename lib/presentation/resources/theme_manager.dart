import 'package:flutter/material.dart';
import 'package:formation_app/presentation/resources/color_managrer.dart';
import 'package:formation_app/presentation/resources/font_manager.dart';
import 'package:formation_app/presentation/resources/styles_manager.dart';
import 'package:formation_app/presentation/resources/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors of the application
    
    primaryColor: ColorManagrer.primary,
    primaryColorLight: ColorManagrer.primaryOpacity70,
    primaryColorDark: ColorManagrer.darkPrimary,
    disabledColor: ColorManagrer.grey1,
    hintColor: ColorManagrer.grey,

    // ripple color
    splashColor: ColorManagrer.primaryOpacity70,
    //card view theme
    cardTheme: CardTheme(
      color: ColorManagrer.white,
      shadowColor: ColorManagrer.grey,
      elevation: AppSize.s4,
    ),
    // app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManagrer.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManagrer.primaryOpacity70,
      titleTextStyle: getRegularStyle(
        color: ColorManagrer.white,
        fontSize: FontSize.s16,
      ),
    ),
    //Button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManagrer.grey1,
      buttonColor: ColorManagrer.primary,
      splashColor: ColorManagrer.primaryOpacity70,
    ),
    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManagrer.white,
        ),
        // primary: ColorManagrer.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),
    //text theme
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(
          color: ColorManagrer.darkGrey, fontSize: FontSize.s16),
      //headlineLarge: getRegularStyle(color: ColorManagrer.lightGrey, fontSize: FontSize.s14),
      titleMedium:
          getMediumStyle(color: ColorManagrer.primary, fontSize: FontSize.s14),
      bodyLarge: getRegularStyle(color: ColorManagrer.grey1),
      bodySmall: getRegularStyle(color: ColorManagrer.grey),
      //caption:getRegularStyle(color: ColorManagrer.grey1),
    ),
    //Text theme
    //input decoration theme(text form field)
    inputDecorationTheme: InputDecorationTheme(
        //content padding
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        //hint style
        hintStyle: getRegularStyle(color: ColorManagrer.grey1),
        //label style
        labelStyle: getMediumStyle(color: ColorManagrer.darkGrey),
        //error style
        errorStyle: getRegularStyle(color: ColorManagrer.error),
        //enable border
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManagrer.grey, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
        //focused border
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManagrer.primary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
        //error border
        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManagrer.primary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
        //focused error border
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManagrer.error, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),

        //disabled border
        disabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManagrer.grey, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        )),
  );
}

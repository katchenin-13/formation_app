import 'package:flutter/material.dart';

import 'font_manager.dart';

//get text style
TextStyle _getTextStyle(
    double fontSize,
    String fontFamily,
    FontWeight fontWeight, 
    Color color) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    color: color,
  );
}

//regular text style
TextStyle getRegularStyle(
    {
      double fontSize = FontSize.s12, 
      required Color color
      }) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.regular, color);
}

//semi Bold text style
TextStyle getSemiBoldStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.semiBold, color);
}

//medium text style
TextStyle getMediumStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.medium, color);
}

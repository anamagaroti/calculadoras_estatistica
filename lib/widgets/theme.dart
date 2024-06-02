import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextThemeApp {
  static TextStyle textTheme(
    TextStyleNum textStyleNum,
    BuildContext context, {
    Color? headlineColor,
    Color? titleColor,
    Color? descriptionColor,
    Color? buttonColor,
    Color? buttonTextColor,
    FontWeightNum? fontWeightNum,
    TextDecoration? textDecoration,
    double? fontSize,
    Color? decorationColor,
    TextAlign? align,
  }) {
    switch (textStyleNum) {
      case TextStyleNum.headline0:
        return GoogleFonts.poppins(
          color: headlineColor ?? const Color(0xFF1D1C1C),
          fontSize: fontSize ?? 10,
          fontWeight: styledFontWeight(fontWeightNum ?? FontWeightNum.w600),
          decoration: textDecoration,
          decorationColor: decorationColor,
        );
      case TextStyleNum.headline1:
        return GoogleFonts.poppins(
          color: headlineColor ?? const Color(0xFF1D1C1C),
          fontSize: fontSize ?? 12,
          fontWeight: styledFontWeight(fontWeightNum ?? FontWeightNum.w600),
          decoration: textDecoration,
          decorationColor: decorationColor,
        );
      case TextStyleNum.headline2:
        return GoogleFonts.poppins(
          color: headlineColor ?? const Color(0xFF1D1C1C),
          fontSize: fontSize ?? 14,
          fontWeight: styledFontWeight(fontWeightNum ?? FontWeightNum.w700),
          decoration: textDecoration,
          decorationColor: decorationColor,
        );
      case TextStyleNum.headline3:
        return GoogleFonts.poppins(
          color: headlineColor ?? const Color(0xFF1D1C1C),
          fontSize: fontSize ?? 16,
          fontWeight: styledFontWeight(fontWeightNum ?? FontWeightNum.w700),
          decoration: textDecoration,
          decorationColor: decorationColor,
        );
      case TextStyleNum.headline4:
        return GoogleFonts.poppins(
          color: headlineColor ?? const Color(0xFF1D1C1C),
          fontSize: fontSize ?? 18,
          fontWeight: styledFontWeight(fontWeightNum ?? FontWeightNum.w700),
          decoration: textDecoration,
          decorationColor: decorationColor,
        );
      case TextStyleNum.headline5:
        return GoogleFonts.poppins(
          color: headlineColor ?? const Color(0xFF1D1C1C),
          fontSize: fontSize ?? 20,
          fontWeight: styledFontWeight(fontWeightNum ?? FontWeightNum.w700),
          decoration: textDecoration,
          decorationColor: decorationColor,
        );
      case TextStyleNum.headline6:
        return GoogleFonts.poppins(
          color: headlineColor ?? const Color(0xFF1D1C1C),
          fontSize: fontSize ?? 22,
          fontWeight: styledFontWeight(fontWeightNum ?? FontWeightNum.w700),
          decoration: textDecoration,
          decorationColor: decorationColor,
        );
      case TextStyleNum.headline7:
        return GoogleFonts.poppins(
          color: headlineColor ?? const Color(0xFF1D1C1C),
          fontSize: fontSize ?? 22,
          fontWeight: styledFontWeight(fontWeightNum ?? FontWeightNum.w400),
          decoration: textDecoration,
          decorationColor: decorationColor,
        );
      case TextStyleNum.button:
        return GoogleFonts.poppins(
          color: buttonColor ?? const Color(0xFF1D1C1C),
          fontSize: fontSize ?? 18,
          fontWeight: styledFontWeight(fontWeightNum ?? FontWeightNum.w700),
          decoration: textDecoration,
          decorationColor: decorationColor,
        );
      case TextStyleNum.titleLarge:
        return GoogleFonts.poppins(
          color: titleColor ?? const Color(0xFF1D1C1C),
          fontSize: fontSize ?? 20,
          fontWeight: styledFontWeight(fontWeightNum ?? FontWeightNum.w700),
          decoration: textDecoration,
          decorationColor: decorationColor,
        );
      case TextStyleNum.titleMedium:
        return GoogleFonts.poppins(
          color: titleColor ?? const Color(0xFF1D1C1C),
          fontSize: fontSize ?? 28,
          fontWeight: styledFontWeight(fontWeightNum ?? FontWeightNum.w600),
          decoration: textDecoration,
          decorationColor: decorationColor,
        );
      case TextStyleNum.title:
        return GoogleFonts.poppins(
          color: titleColor ?? const Color(0xFF1D1C1C),
          fontSize: fontSize ?? 16,
          fontWeight: styledFontWeight(fontWeightNum ?? FontWeightNum.w500),
          decoration: textDecoration,
          decorationColor: decorationColor,
        );
      case TextStyleNum.titleBold:
        return GoogleFonts.poppins(
          color: titleColor ?? const Color(0xFF1D1C1C),
          fontSize: fontSize ?? 16,
          fontWeight: styledFontWeight(fontWeightNum ?? FontWeightNum.w700),
          decoration: textDecoration,
          decorationColor: decorationColor,
        );
      case TextStyleNum.bodyLarge:
        return GoogleFonts.poppins(
          color: descriptionColor ?? const Color(0xFF1D1C1C),
          fontSize: fontSize ?? 17,
          fontWeight: styledFontWeight(fontWeightNum ?? FontWeightNum.w400),
          decoration: textDecoration,
          decorationColor: decorationColor,
        );
      case TextStyleNum.bodyMedium:
        return GoogleFonts.poppins(
          color: descriptionColor ?? Colors.black54,
          fontSize: fontSize ?? 15,
          fontWeight: styledFontWeight(fontWeightNum ?? FontWeightNum.w400),
          decoration: textDecoration,
          decorationColor: decorationColor,
        );

      case TextStyleNum.description:
        return GoogleFonts.poppins(
          color: descriptionColor ?? const Color(0xFF1D1C1C),
          fontSize: fontSize ?? 15,
          fontWeight: styledFontWeight(fontWeightNum ?? FontWeightNum.w400),
          decoration: textDecoration,
          decorationColor: decorationColor,
        );
      case TextStyleNum.buttonText:
        return GoogleFonts.poppins(
          color: buttonTextColor ?? const Color(0xFF1D1C1C),
          fontSize: fontSize ?? 14,
          fontWeight: styledFontWeight(fontWeightNum ?? FontWeightNum.w600),
          decoration: textDecoration,
          decorationColor: decorationColor,
        );
    }
  }
}

FontWeight styledFontWeight(FontWeightNum fontWeightNum) {
  switch (fontWeightNum) {
    case FontWeightNum.w400:
      return FontWeight.w400;
    case FontWeightNum.w600:
      return FontWeight.w600;
    case FontWeightNum.w700:
      return FontWeight.w700;
    case FontWeightNum.w500:
      return FontWeight.w500;
    case FontWeightNum.w800:
      return FontWeight.w800;
    case FontWeightNum.w900:
      return FontWeight.w900;
  }
}

enum TextStyleNum {
  headline0,
  headline1,
  headline2,
  headline3,
  headline4,
  headline5,
  headline6,
  headline7,
  button,
  titleLarge,
  titleMedium,
  title,
  titleBold,
  bodyLarge,
  bodyMedium,
  description,
  buttonText,
}

enum FontWeightNum {
  w900,
  w800,
  w700,
  w600,
  w500,
  w400,
}

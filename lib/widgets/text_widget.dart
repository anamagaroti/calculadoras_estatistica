import 'package:flutter/material.dart';

import 'theme.dart';

class TextWidget extends StatelessWidget {
  final String? text;
  final TextStyleNum textStyleNum;
  final Color? buttonTextColor;
  final Color? buttonColor;
  final Color? descriptionColor;
  final Color? headlineColor;
  final Color? titleColor;
  final TextAlign? textAlign;
  final int? maxLines;
  final FontWeightNum? fontWeightNum;
  final TextOverflow? textOverflow;
  final TextDecoration? textDecoration;
  final Color? decorationColor;
  final double? fontSize;
  const TextWidget({
    super.key,
    required this.textStyleNum,
    this.buttonTextColor,
    this.descriptionColor,
    this.headlineColor,
    this.titleColor,
    this.textAlign,
    this.text,
    this.maxLines,
    this.buttonColor,
    this.fontWeightNum,
    this.textOverflow,
    this.textDecoration,
    this.decorationColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextThemeApp.textTheme(
        textStyleNum,
        context,
        descriptionColor: descriptionColor,
        headlineColor: headlineColor,
        titleColor: titleColor,
        buttonColor: buttonColor,
        buttonTextColor: buttonTextColor,
        fontWeightNum: fontWeightNum,
        textDecoration: textDecoration,
        decorationColor: decorationColor,
        fontSize: fontSize,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
    );
  }
}

import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

//common text widget

class AppText extends StatelessWidget {
  const AppText(
      {super.key,
        this.fontSize,
        this.fontFamily,
        required this.text ,
        this.lineSpacing,
        this.letterSpacing,
        this.textOverflow,
        this.maxLines,
        this.textDecoration,
        this.color,
        this.fontWeight,
        this.textAlign = TextAlign.start});
  final String text;
  final String? fontFamily;
  final TextOverflow? textOverflow;
  final double? fontSize;
  final double? lineSpacing;
  final double? letterSpacing;
  final TextAlign textAlign;
  final Color? color;
  final int? maxLines;
  final TextDecoration? textDecoration;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        style: TextStyle(
          letterSpacing: letterSpacing,
          height: lineSpacing,
          // wordSpacing: 10,
          decoration: textDecoration,
          overflow: textOverflow ?? TextOverflow.visible,
          // fontFamily: fontFamily ?? AppFonts.regular,
          fontWeight: fontWeight,
          fontSize:
          fontSize ?? Theme.of(context).textTheme.bodyMedium!.fontSize,
          color: color ?? AppColors.headingColor,
        )
      // color: color ?? Theme.of(context).textTheme.bodyMedium!.color),
    );
  }
}
 import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({Key? key, required this.text,this.textAlign, this.maxLines,  this.textColor,   this.fontSize,   this.fontWeight,   this.textOverflow, this.decoration}) : super(key: key);
  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return   Text(
      textAlign: textAlign,
      maxLines : maxLines,
      overflow: TextOverflow.ellipsis,
      text,
      style: TextStyle(
        decoration: decoration ,
        color: textColor,
        fontSize: fontSize,
        fontWeight:fontWeight,
      ),
    );
  }
}
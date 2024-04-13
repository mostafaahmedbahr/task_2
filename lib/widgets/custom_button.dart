import 'package:flutter/material.dart';

import '../core/colors.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({Key? key,   this.height = 60,   this.width,     this.btnColor = AppColors.primaryColor, required this.btnText,required this.onPressed,   this.borderColor, this.radius}) : super(key: key);
  final double height;
  final double? width;
  final Color btnColor;
  final Color? borderColor;
  final double? radius;
  final Widget btnText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return    SizedBox(
      height: height,
      width: width,
      child:  ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 50),
              side:   BorderSide(
                width: 1.0,
                color:borderColor ?? AppColors.mainColor,
              )
          ), backgroundColor: btnColor,
        ),
        child:  btnText,
      ),
    );
  }
}
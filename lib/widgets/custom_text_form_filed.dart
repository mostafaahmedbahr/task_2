import 'package:flutter/material.dart';

import '../core/colors.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    this.controller,
    this.obscureText = false,
    this.icon,
    this.hintText,
    this.onPressed,
    this.prefix,
    this.validator,
    this.maxLines,
    this.prefixIcon,
    this.keyboardType,
    this.readOnly,
    this.raduis, this.fillColor,this.borderColor
  }) : super(key: key);

  TextEditingController? controller;
  final bool? obscureText;
  Widget? icon;
  Widget? prefixIcon;
  Widget? prefix;
  void Function()? onPressed;
  String? hintText;
  int? maxLines;
  double? raduis;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  final bool? readOnly;
  final Color? fillColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      maxLines: maxLines ?? 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText ?? false,
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: AppColors.blackColor,
      ),
      validator: validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
        suffixIcon: icon,
        prefixIcon: prefixIcon,
        prefix: prefix,
        filled: true,
        fillColor:fillColor ?? AppColors.grey1Color.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduis ?? 15),
          borderSide:   BorderSide(
            color: borderColor ?? AppColors.grey1Color.withOpacity(0.2),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduis ?? 15),
          borderSide:   BorderSide(
            color: borderColor ?? AppColors.grey1Color.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduis ?? 15),
          borderSide:   BorderSide(
            color: borderColor ?? AppColors.grey1Color.withOpacity(0.2),
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color:AppColors.grey1Color ,
        ),
      ),
    );
  }
}
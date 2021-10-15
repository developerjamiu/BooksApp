import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import '../core/constants/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;

  const AppTextField({
    Key? key,
    this.controller,
    this.onSubmitted,
    this.textInputAction,
    this.prefixIcon,
    required this.hintText,
    this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [AppColors.defaultShadow],
      ),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction ?? TextInputAction.next,
        onFieldSubmitted: onSubmitted,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            top: 24,
            bottom: 16,
            right: Dimensions.big,
            left: Dimensions.big,
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide.none,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 64,
          ),
        ),
      ),
    );
  }
}

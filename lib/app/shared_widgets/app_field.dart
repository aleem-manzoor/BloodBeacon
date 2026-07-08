import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../config/app_colors.dart';
import 'my_text.dart';
import 'textfield.dart';

class AppField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscure;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;

  const AppField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscure = false,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.inputFormatters,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          title: label,
          size: 13.sp,
          weight: FontWeight.w600,
          clr: AppColors.textDark,
        ),
        SizedBox(height: 1.h),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            InputTextField(
              controller: controller,
              hint: hint,
              validation: validator,
              textInputType: keyboardType,
              isObscure: obscure,
              maxLines: maxLines,
              readOnly: readOnly,
              onTap: onTap,
              padding: true,
              borderRadius: 14,
              filledColor: AppColors.cardBg,
              inputFormatter: inputFormatters,
            ),
            if (suffix != null) Padding(padding: EdgeInsets.only(right: 3.w), child: suffix),
          ],
        ),
        SizedBox(height: 2.h),
      ],
    );
  }
}

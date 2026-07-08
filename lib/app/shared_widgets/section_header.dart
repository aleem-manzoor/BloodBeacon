import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../config/app_colors.dart';
import 'my_text.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            title: title,
            size: 15.sp,
            weight: FontWeight.w700,
            clr: AppColors.textDark,
          ),
          if (actionText != null)
            GestureDetector(
              onTap: onAction,
              child: MyText(
                title: actionText!,
                size: 12.sp,
                weight: FontWeight.w600,
                clr: AppColors.primary,
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../config/app_colors.dart';
import 'my_text.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 34.sp),
            ),
            SizedBox(height: 2.5.h),
            MyText(
              title: title,
              size: 15.sp,
              weight: FontWeight.w700,
              clr: AppColors.textDark,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              SizedBox(height: 1.h),
              MyText(
                title: subtitle!,
                size: 12.sp,
                weight: FontWeight.w500,
                clr: AppColors.textMuted,
                textAlign: TextAlign.center,
                line: 3,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

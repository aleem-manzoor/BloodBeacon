import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../config/app_colors.dart';
import 'my_container.dart';
import 'my_text.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      padding: const EdgeInsets.all(14),
      radius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18.sp),
          ),
          SizedBox(height: 1.5.h),
          SizedBox(
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: MyText(
                title: value,
                size: 18.sp,
                weight: FontWeight.w800,
                clr: AppColors.textDark,
                line: 1,
              ),
            ),
          ),
          SizedBox(height: 0.4.h),
          MyText(
            title: label,
            size: 11.sp,
            weight: FontWeight.w500,
            clr: AppColors.textMuted,
            line: 2,
          ),
        ],
      ),
    );
  }
}

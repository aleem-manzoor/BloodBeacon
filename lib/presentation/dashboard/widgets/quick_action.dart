import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';

class QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const QuickAction({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            height: 14.w,
            width: 14.w,
            decoration: BoxDecoration(
              color: color.withOpacity(.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: color, size: 22.sp),
          ),
          SizedBox(height: 0.8.h),
          MyText(
            title: label,
            size: 10.sp,
            weight: FontWeight.w600,
            clr: AppColors.textDark,
            textAlign: TextAlign.center,
            line: 2,
          ),
        ],
      ),
    );
  }
}

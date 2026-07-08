import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';

class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? color;
  final VoidCallback onTap;

  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.6.h),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: c.withOpacity(.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: c, size: 18.sp),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: MyText(
                title: title,
                size: 13.sp,
                weight: FontWeight.w600,
                clr: AppColors.textDark,
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}

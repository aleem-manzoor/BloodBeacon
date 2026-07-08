import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../config/app_colors.dart';
import 'my_text.dart';

class BloodBadge extends StatelessWidget {
  final String? group;
  final double size;

  const BloodBadge({super.key, required this.group, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary.withOpacity(.25)),
      ),
      child: MyText(
        title: (group == null || group!.isEmpty) ? '?' : group!,
        size: 14.sp,
        weight: FontWeight.w800,
        clr: AppColors.primary,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:sizer/sizer.dart';

class VerificationRow extends StatelessWidget {
  final String title;
  final int index;
  final int selectedIndex;
  final void Function() onTap;
  const VerificationRow(
      {super.key,
      required this.title,
      required this.index,
      required this.selectedIndex,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color:
              selectedIndex == index ? AppColors.primary5FF : AppColors.white,
          border: Border.all(
            color:
                selectedIndex == index ? AppColors.primary : AppColors.grey6B,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: MyText(
          title: title,
          size: 11.sp,
          clr: selectedIndex == index ? AppColors.primary : AppColors.grey6B,
          weight: selectedIndex == index ? FontWeight.w700 : FontWeight.normal,
        ),
      ),
    );
  }
}

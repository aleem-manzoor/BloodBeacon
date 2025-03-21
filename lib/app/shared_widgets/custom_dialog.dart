import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppsc_preparation/app/config/app_colors.dart';
import 'package:ppsc_preparation/app/shared_widgets/my_text.dart';
import 'package:sizer/sizer.dart';

class CustomLogoutDialog extends StatelessWidget {
  final String title;
  final String content;
  final String yesButtonText;
  final String noButtonText;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback onYesTap;
  final VoidCallback onNoTap;

  const CustomLogoutDialog({
    super.key,
    required this.title,
    this.backgroundColor,
    this.textColor,
    required this.content,
    required this.yesButtonText,
    required this.noButtonText,
    required this.onYesTap,
    required this.onNoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.inputfield,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText(
              title: content,
              size: 16.sp,
              weight: FontWeight.w400,
              textAlign: TextAlign.center,
              clr: AppColors.white,
            ).paddingOnly(bottom: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onNoTap,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: AppColors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: MyText(
                      title: noButtonText,
                      size: 14.sp,
                      weight: FontWeight.w500,
                      clr: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onYesTap,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: backgroundColor ?? AppColors.primary,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: MyText(
                      title: yesButtonText,
                      size: 14.sp,
                      weight: FontWeight.w500,
                      clr: textColor ?? AppColors.black,
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 25),
          ],
        ),
      ),
    );
  }
}

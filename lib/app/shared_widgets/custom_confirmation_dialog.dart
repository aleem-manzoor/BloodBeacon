import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_beacon/app/extensions/extensions.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:sizer/sizer.dart';
import '../../../../app/config/app_colors.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback yesOnTap;
  const ConfirmationDialog(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.yesOnTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              offset: const Offset(12, 26),
              blurRadius: 50,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(.1),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close Button
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: AppColors.black,
                  size: 18,
                ),
                onPressed: () {
                  Get.back(); // Closes the dialog
                },
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyText(
                  title: title,
                  weight: FontWeight.w600,
                  size: 11.25.sp,
                ),
                .5.h.height,
                MyText(
                  title: subTitle,
                  weight: FontWeight.w500,
                  size: 9.25.sp,
                  clr: AppColors.hint,
                ),
                4.h.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 65,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(4)),
                        child: MyText(
                          title: 'Cancel'.tr,
                          weight: FontWeight.w500,
                          size: 12.sp,
                          clr: AppColors.inputfield,
                        ),
                      ),
                    ),
                    3.w.width,
                    GestureDetector(
                      onTap: yesOnTap,
                      child: Container(
                        width: 65,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(4)),
                        child: MyText(
                          title: 'Yes'.tr,
                          weight: FontWeight.w500,
                          size: 12.sp,
                          clr: AppColors.inputfield,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            5.h.height,
            // const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

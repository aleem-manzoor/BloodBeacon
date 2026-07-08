import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/extensions/extensions.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:sizer/sizer.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Utils.getIconPath("logo"),
              height: 20.h,
            ),
            3.h.height,
            MyText(
              title: "BloodBeacon",
              weight: FontWeight.w700,
              size: 22.sp,
              clr: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}

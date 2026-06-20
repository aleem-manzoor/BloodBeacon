import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppsc_preparation/app/config/app_colors.dart';
import 'package:ppsc_preparation/app/extensions/extensions.dart';
import 'package:ppsc_preparation/app/shared_widgets/my_text.dart';
import 'package:ppsc_preparation/app/utils/utils.dart';
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
              title: "Base Project",
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

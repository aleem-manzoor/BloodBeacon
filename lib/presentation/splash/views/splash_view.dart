import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppsc_preparation/app/config/app_colors.dart';
import 'package:ppsc_preparation/app/extensions/extensions.dart';
import 'package:ppsc_preparation/app/routes/app_pages.dart';
import 'package:ppsc_preparation/app/shared_widgets/custom_button.dart';
import 'package:ppsc_preparation/app/shared_widgets/my_text.dart';
import 'package:ppsc_preparation/app/utils/utils.dart';
import 'package:ppsc_preparation/data/provider/local_storage/local_db.dart';
import 'package:sizer/sizer.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (context) {
          return Scaffold(
              body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: Get.height * .55,
                    decoration: const BoxDecoration(
                      color: AppColors.containerBackground,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(1000),
                      ),
                    ),
                  ),
                  1.h.height,
                  MyText(
                    title: "Beaverise",
                    weight: FontWeight.w700,
                    size: 26.sp,
                    clr: AppColors.black,
                  ),
                  MyText(
                    title: "A Perfect Platform to find Service Providers",
                    weight: FontWeight.w400,
                    size: 15.5.sp,
                    clr: AppColors.black,
                  ).paddingOnly(top: 2.h),
                  const Spacer(),
                  CustomButton(
                    text: "Get Started",
                    onPress: () async {
                      String? isShown = await LocalDB.getData('onBoarding');
                      if (isShown != null) {
                        Get.offAllNamed(Routes.LOGIN);
                      } else {
                        // Get.offAndToNamed(Routes.ONBOARDING); //todo
                      }

                      // Get.toNamed(Routes.ONBOARDING); //todo
                    },
                    textColor: AppColors.white,
                    boxColor: AppColors.primary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    height: Get.height * .055,
                    radius: 100,
                  ).paddingSymmetric(
                    horizontal: 5.w,
                  ),
                  5.h.height,
                ],
              ),
              Positioned(
                top: Get.height * .4,
                left: Get.width * .3,
                child: Container(
                  height: Get.height * .17,
                  width: Get.height * .17,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Container(
                      height: Get.height * .15,
                      width: Get.height * .15,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        Utils.getIconPath("logo"),
                        scale: 4,
                      )),
                ),
              ),
            ],
          ));
        });
  }
}

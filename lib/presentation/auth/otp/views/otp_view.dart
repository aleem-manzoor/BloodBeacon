import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ppsc_preparation/app/shared_widgets/appbar_custom.dart';
import 'package:ppsc_preparation/app/shared_widgets/textfield.dart';
import 'package:sizer/sizer.dart';
import 'package:ppsc_preparation/app/config/app_colors.dart';
import 'package:ppsc_preparation/app/extensions/extensions.dart';
import 'package:ppsc_preparation/app/shared_widgets/custom_button.dart';
import 'package:ppsc_preparation/app/shared_widgets/my_text.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(
        init: OtpController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarCustom(
              title: 'Beaverise',
              centerTitle: true,
              isLogo: true,
              onLeadingPressed: () {
                Get.back();
              },
            ),
            bottomNavigationBar: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                          title: "Didn't receive a code?",
                          size: 14.sp,
                          clr: AppColors.black,
                          weight: FontWeight.w500)
                      .paddingOnly(right: 5),
                  GestureDetector(
                      onTap: () async {
                        await controller.resendOtp();
                      },
                      child: MyText(
                          title: 'Resend',
                          size: 14.sp,
                          clr: AppColors.primary,
                          weight: FontWeight.w700)),
                ],
              ).paddingOnly(bottom: 3.h),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: controller.loginFormKey,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      4.h.height,
                      MyText(
                        title: 'Verify Code',
                        size: 18.sp,
                        weight: FontWeight.w700,
                      ),
                      5.h.height,
                      InputTextField(
                        padding: true,
                        label: 'Enter Code',
                        hint: 'Enter code',
                        borderRadius: 4,
                        textInputType: TextInputType.text,
                        controller: controller.otpController,
                        suffixIcon: !controller.showPassword.isFalse
                            ? "eye"
                            : "eye_off",
                        isObscure: !controller.showPassword.value,
                        suffixOntap: () {
                          controller.showPassword.value =
                              !controller.showPassword.value;
                          controller.update();
                        },
                        validation: (p0) {
                          if (controller.otpController.text.isEmpty) {
                            return 'Enter an otp';
                          }
                          return null;
                        },
                      ).paddingOnly(top: 0.5.h, bottom: 3.h),
                      CustomButton(
                          text: 'Verify',
                          radius: 30,
                          fontSize: 15.sp,
                          weight: FontWeight.w600,
                          onPress: () async {
                            FocusManager.instance.primaryFocus!.unfocus();
                            if (controller.loginFormKey.currentState!
                                .validate()) {
                              await controller.otpVerification(); //todo
                            }
                          },
                          textColor: AppColors.white,
                          boxColor: AppColors.primary),
                      2.h.height,
                      MyText(
                        title: '00:30',
                        size: 14.sp,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 20),
                ),
              ),
            ),
          );
        });
  }
}

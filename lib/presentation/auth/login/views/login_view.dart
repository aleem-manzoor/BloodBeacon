import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppsc_preparation/app/shared_widgets/appbar_custom.dart';
import 'package:sizer/sizer.dart';
import 'package:ppsc_preparation/app/config/app_colors.dart';
import 'package:ppsc_preparation/app/extensions/extensions.dart';
import 'package:ppsc_preparation/app/routes/app_pages.dart';
import 'package:ppsc_preparation/app/shared_widgets/custom_button.dart';
import 'package:ppsc_preparation/app/shared_widgets/my_text.dart';
import 'package:ppsc_preparation/app/shared_widgets/textfield.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
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
                          title: "Don't have an account?",
                          size: 14.sp,
                          clr: AppColors.black,
                          weight: FontWeight.w500)
                      .paddingOnly(right: 5),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.SIGNUP);
                      },
                      child: MyText(
                          title: 'SignUp',
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
                        title: 'Login to your account',
                        size: 18.sp,
                        weight: FontWeight.w700,
                      ),
                      5.h.height,

                      InputTextField(
                        padding: true,
                        label: 'Email',
                        hint: 'Email',
                        borderRadius: 4,
                        textInputType: TextInputType.emailAddress,
                        controller: controller.emailController,
                        validation: (p0) {
                          if (!GetUtils.isEmail(
                              controller.emailController.text.trim())) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ).paddingOnly(top: 0.5.h, bottom: 1.5.h),

                      InputTextField(
                        hint: 'Password',
                        label: 'Password',
                        borderRadius: 4,
                        padding: true,
                        controller: controller.passwordController,
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
                          if (controller.passwordController.text.isEmpty) {
                            return "Enter a password";
                          }
                          return null;
                        },
                      ).paddingOnly(top: 0.5.h, bottom: 2.h),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Transform.translate(
                            offset: const Offset(-12, 0),
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: 0.8,
                                  child: Checkbox(
                                    activeColor: AppColors.primary,
                                    checkColor: AppColors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: AppColors.white,
                                          width: 2), // Border color and width
                                      borderRadius: BorderRadius.circular(
                                          4), // Optional: to give it rounded corners
                                    ),
                                    value: controller.savePassword,
                                    onChanged: (v) {
                                      controller.savePassword = v!;
                                      log(controller.savePassword.toString());
                                      controller.update();
                                    },
                                  ),
                                ),
                                MyText(
                                    title: 'Remember me',
                                    size: 14.sp,
                                    weight: FontWeight.w500,
                                    clr: AppColors.black),
                              ],
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.FORGOT_PASSWORD);
                              },
                              child: MyText(
                                  title: 'Forgot Password?',
                                  size: 14.sp,
                                  clr: AppColors.primary,
                                  weight: FontWeight.w500)),
                        ],
                      ).paddingOnly(bottom: 2.h),

                      CustomButton(
                          text: 'Login',
                          radius: 30,
                          fontSize: 15.sp,
                          weight: FontWeight.w600,
                          onPress: () async {
                            FocusManager.instance.primaryFocus!.unfocus();
                            if (controller.loginFormKey.currentState!
                                .validate()) {
                              await controller.login(
                                  controller.emailController.text.trim(),
                                  controller.passwordController.text
                                      .trim()); //todo
                            }
                          },
                          textColor: AppColors.white,
                          boxColor: AppColors.primary),

                      // Row(
                      //   children: [
                      //     const Expanded(child: Divider()),
                      //     MyText(title: ' Or Login With ',size: 14.sp,weight: FontWeight.w400,clr: AppColors.grey.withOpacity(0.5)).paddingSymmetric(horizontal: 8),
                      //     const Expanded(child: Divider()),
                      //   ],
                      // ).paddingSymmetric(vertical: 3.h),

                      // Row(
                      //   children: [

                      //     Expanded(child: SocialButton(scale: 4, radius: 30, logo: 'google', text: '', onPress: (){}, textColor: AppColors.primary)),
                      //     if(Platform.isIOS)
                      //       SizedBox(width: 4.w),
                      //     if(Platform.isIOS)
                      //       Expanded(child: SocialButton( scale: 4,radius: 30,logo: 'apple', text: '', onPress: (){}, textColor: AppColors.primary)),
                      //   ],
                      // ),
                    ],
                  ).paddingSymmetric(horizontal: 20),
                ),
              ),
            ),
          );
        });
  }
}

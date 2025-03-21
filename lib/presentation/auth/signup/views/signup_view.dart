import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppsc_preparation/app/config/app_colors.dart';
import 'package:ppsc_preparation/app/extensions/extensions.dart';
import 'package:ppsc_preparation/app/shared_widgets/appbar_custom.dart';
import 'package:ppsc_preparation/app/shared_widgets/custom_button.dart';
import 'package:ppsc_preparation/app/shared_widgets/my_text.dart';
import 'package:ppsc_preparation/app/shared_widgets/textfield.dart';
import 'package:sizer/sizer.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
        init: SignupController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarCustom(
              title: 'Beaverise',
              centerTitle: false,
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
                          title: 'Already have an account?',
                          size: 14.sp,
                          clr: AppColors.black,
                          weight: FontWeight.w500)
                      .paddingOnly(right: 5),
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: MyText(
                          title: 'Login',
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
                      3.h.height,
                      MyText(
                        title: 'Sign up to your account',
                        size: 18.sp,
                        weight: FontWeight.w700,
                      ),
                      2.h.height,
                      InputTextField(
                        padding: true,
                        hint: 'First Name',
                        textInputType: TextInputType.text,
                        controller: controller.firstNameController,
                        validation: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter first name';
                          }
                          return null;
                        },
                      ).paddingOnly(top: 0.5.h, bottom: 1.5.h),

                      InputTextField(
                        padding: true,
                        hint: 'Last Name',
                        textInputType: TextInputType.text,
                        controller: controller.lastNameController,
                        validation: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter last name';
                          }
                          return null;
                        },
                      ).paddingOnly(top: 0.5.h, bottom: 1.5.h),
                      InputTextField(
                        padding: true,
                        hint: 'Email',
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
                        padding: true,
                        hint: 'Phone Number',
                        textInputType: TextInputType.number,
                        controller: controller.phoneController,
                        validation: (p0) {
                          if (!GetUtils.isPhoneNumber(
                              controller.phoneController.text.trim())) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                      ).paddingOnly(top: 0.5.h, bottom: 1.5.h),

                      InputTextField(
                        hint: 'Password',
                        padding: true,
                        controller: controller.passwordController,
                        suffixIcon:
                            controller.showPassword.isFalse ? "eye" : "eye_off",
                        isObscure: !controller.showPassword.value,
                        suffixOntap: () {
                          controller.showPassword.value =
                              !controller.showPassword.value;
                          controller.update();
                        },
                        validation: (p0) {
                          if (controller.passwordController.text.length < 8) {
                            return "Password cannot be less than 8 characters.";
                          }
                          return null;
                        },
                      ).paddingOnly(top: 0.5.h, bottom: 1.h),

                      InputTextField(
                        hint: 'Confirm Password',
                        padding: true,
                        controller: controller.confirmPasswordController,
                        suffixIcon: controller.showConfirmPassword.isFalse
                            ? "eye"
                            : "eye_off",
                        isObscure: !controller.showConfirmPassword.value,
                        suffixOntap: () {
                          controller.showConfirmPassword.value =
                              !controller.showConfirmPassword.value;
                          controller.update();
                        },
                        validation: (p0) {
                          if (controller.passwordController.text !=
                              controller.confirmPasswordController.text) {
                            return "Password does not match";
                          }
                          return null;
                        },
                      ).paddingOnly(top: 0.5.h, bottom: 1.h),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Transform.translate(
                            offset: const Offset(-11, 0),
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: 0.8,
                                  child: Checkbox(
                                    activeColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: AppColors.secondary,
                                          width: 2), // Border color and width
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    value: controller.isReceiveEmail,
                                    onChanged: (v) {
                                      controller.isReceiveEmail = v!;
                                      controller.update();
                                    },
                                  ),
                                ),
                                // CustomRichText(
                                //   fontSize: 14.sp,
                                //   boldColor: AppColors.primary,
                                //   descriptions: [
                                //   DescriptionModel(text: "I agree to all the  ", isBold: false),
                                //   DescriptionModel(text: "Terms ", isBold: true),
                                //   DescriptionModel(text: "and  ", isBold: false),
                                //   DescriptionModel(text: "Privacy Policies ", isBold: true),
                                // ]),
                              ],
                            ),
                          ),
                        ],
                      ).paddingOnly(bottom: 2.h),

                      CustomButton(
                          text: 'Create Account',
                          radius: 30,
                          fontSize: 15.sp,
                          weight: FontWeight.w600,
                          onPress: () async {
                            if (controller.loginFormKey.currentState!
                                .validate()) {
                              FocusManager.instance.primaryFocus!.unfocus();
                              await controller.register(
                                  email: controller.emailController.text.trim(),
                                  firstName: controller.firstNameController.text
                                      .trim(),
                                  lastName: controller.lastNameController.text,
                                  phoneNumber:
                                      controller.phoneController.text.trim(),
                                  password: controller.passwordController.text);
                            }
                          },
                          textColor: AppColors.white,
                          boxColor: AppColors.primary),

                      // Row(
                      //   children: [
                      //     const Expanded(child: Divider()),
                      //     MyText(title: ' Or Sign up With ',size: 14.sp,weight: FontWeight.w400,clr: AppColors.grey.withOpacity(0.5)).paddingSymmetric(horizontal: 8),
                      //     const Expanded(child: Divider()),
                      //   ],
                      // ).paddingSymmetric(vertical: 3.h),

                      // Row(
                      //   children: [

                      //     Expanded(child: SocialButton(scale: 4, radius: 30, logo: 'google', text: '', onPress: (){}, textColor: AppColors.primary)),
                      //     if(Platform.isIOS)
                      //     SizedBox(width: 4.w),
                      //     if(Platform.isIOS)
                      //     Expanded(child: SocialButton( scale: 4,radius: 30,logo: 'apple', text: '', onPress: (){}, textColor: AppColors.primary)),
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

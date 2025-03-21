import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppsc_preparation/app/shared_widgets/appbar_custom.dart';
import 'package:sizer/sizer.dart';
import 'package:ppsc_preparation/app/config/app_colors.dart';
import 'package:ppsc_preparation/app/extensions/extensions.dart';
import 'package:ppsc_preparation/app/shared_widgets/custom_button.dart';
import 'package:ppsc_preparation/app/shared_widgets/my_text.dart';
import 'package:ppsc_preparation/app/shared_widgets/textfield.dart';
import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewPasswordController>(
        init: NewPasswordController(),
        builder: (context) {
          return Scaffold(
            appBar: AppBarCustom(
              title: 'Beaverise',
              centerTitle: true,
              isLogo: true,
              onLeadingPressed: () {
                Get.back();
              },
            ),
            body: SingleChildScrollView(
              child: Form(
                key: controller.newFormKey,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      4.h.height,
                      MyText(
                        title: 'Set a Password',
                        size: 18.sp,
                        weight: FontWeight.w700,
                      ),
                      5.h.height,
                      InputTextField(
                        padding: true,
                        label: 'Create Password',
                        hint: 'Create Password',
                        borderRadius: 4,
                        textInputType: TextInputType.text,
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
                            return 'Enter an otp';
                          }
                          return null;
                        },
                      ).paddingOnly(top: 0.5.h, bottom: 1.5.h),
                      InputTextField(
                        padding: true,
                        label: 'Re-enter Password',
                        hint: 'Re-enter Password',
                        borderRadius: 4,
                        textInputType: TextInputType.text,
                        controller: controller.newPasswordController,
                        suffixIcon: !controller.showConfirmPassword.isFalse
                            ? "eye"
                            : "eye_off",
                        isObscure: !controller.showConfirmPassword.value,
                        suffixOntap: () {
                          controller.showConfirmPassword.value =
                              !controller.showConfirmPassword.value;
                          controller.update();
                        },
                        validation: (p0) {
                          if (controller.passwordController.text.toString() !=
                              controller.newPasswordController.text
                                  .toString()) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ).paddingOnly(top: 0.5.h, bottom: 3.h),
                      CustomButton(
                          text: 'Set Password',
                          radius: 30,
                          fontSize: 15.sp,
                          weight: FontWeight.w600,
                          onPress: () async {
                            FocusManager.instance.primaryFocus!.unfocus();
                            if (controller.newFormKey.currentState!
                                .validate()) {
                              await controller.setPassword();
                            }
                          },
                          textColor: AppColors.white,
                          boxColor: AppColors.primary),
                    ],
                  ).paddingSymmetric(horizontal: 20),
                ),
              ),
            ),
          );
        });
  }
}

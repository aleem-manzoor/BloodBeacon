import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ppsc_preparation/app/shared_widgets/appbar_custom.dart';
import 'package:sizer/sizer.dart';
import 'package:ppsc_preparation/app/config/app_colors.dart';
import 'package:ppsc_preparation/app/extensions/extensions.dart';
import 'package:ppsc_preparation/app/shared_widgets/custom_button.dart';
import 'package:ppsc_preparation/app/shared_widgets/my_text.dart';
import 'package:ppsc_preparation/app/shared_widgets/textfield.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: MyText(
                title: 'Base Project',
                size: 18.sp,
                weight: FontWeight.w700,
                clr: AppColors.black,
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      4.h.height,
                      MyText(
                        title: 'Forgot your Password?',
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
                      ).paddingOnly(top: 0.5.h, bottom: 3.h),
                      CustomButton(
                          text: 'Submit',
                          radius: 30,
                          fontSize: 15.sp,
                          weight: FontWeight.w600,
                          onPress: () async {
                            FocusManager.instance.primaryFocus!.unfocus();
                            if (controller.formKey.currentState!.validate()) {
                              await controller.forgetPassword();
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

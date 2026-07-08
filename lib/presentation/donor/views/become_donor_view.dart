import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/config/app_constants.dart';
import 'package:blood_beacon/app/shared_widgets/app_dropdown_field.dart';
import 'package:blood_beacon/app/shared_widgets/app_field.dart';
import 'package:blood_beacon/app/shared_widgets/app_top_bar.dart';
import 'package:blood_beacon/app/shared_widgets/my_button.dart';
import 'package:blood_beacon/app/shared_widgets/my_container.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';

import '../controllers/become_donor_controller.dart';

class BecomeDonorView extends GetView<BecomeDonorController> {
  const BecomeDonorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const AppTopBar(title: 'Become a Donor'),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyContainer(
                color: AppColors.primaryLight,
                shadow: false,
                child: Row(
                  children: [
                    const Icon(Icons.favorite_rounded, color: AppColors.primary),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: MyText(
                        title:
                            'One donation can save up to three lives. Complete your donor profile to get started.',
                        size: 11.sp,
                        clr: AppColors.primaryDark,
                        weight: FontWeight.w600,
                        line: 3,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Obx(
                () => AppDropdownField(
                  label: 'Blood Group',
                  value: controller.bloodGroup.value,
                  options: AppConstants.bloodGroups,
                  onSelected: (v) => controller.bloodGroup.value = v,
                ),
              ),
              Obx(
                () => AppField(
                  label: 'Last Donation Date',
                  hint: 'Tap to select',
                  readOnly: true,
                  onTap: controller.pickLastDonationDate,
                  controller: TextEditingController(
                    text: controller.lastDonationDate.value?.split('T').first ??
                        '',
                  ),
                  suffix: const Icon(Icons.calendar_today_rounded,
                      size: 18, color: AppColors.textMuted),
                ),
              ),
              AppField(
                label: 'Medical Eligibility',
                hint: 'e.g. No recent illness, not on medication',
                controller: controller.eligibilityController,
                maxLines: 3,
              ),
              Obx(
                () => MyButton(
                  text: controller.latitude.value == null
                      ? 'Capture Current Location'
                      : 'Location Captured ✓',
                  icon: Icons.my_location_rounded,
                  isOutlined: true,
                  isLoading: controller.capturingLocation.value,
                  onPressed: controller.captureLocation,
                ),
              ),
              SizedBox(height: 2.h),
              MyContainer(
                child: Row(
                  children: [
                    Expanded(
                      child: MyText(
                        title: 'Available to donate now',
                        size: 12.sp,
                        weight: FontWeight.w600,
                        clr: AppColors.textDark,
                      ),
                    ),
                    Obx(
                      () => Switch(
                        value: controller.available.value,
                        activeColor: AppColors.primary,
                        onChanged: (v) => controller.available.value = v,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              Obx(
                () => MyButton(
                  text: 'Register as Donor',
                  isLoading: controller.saving.value,
                  onPressed: controller.submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

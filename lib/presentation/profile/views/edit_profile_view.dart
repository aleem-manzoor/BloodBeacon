import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/config/app_constants.dart';
import 'package:blood_beacon/app/shared_widgets/app_dropdown_field.dart';
import 'package:blood_beacon/app/shared_widgets/app_field.dart';
import 'package:blood_beacon/app/shared_widgets/app_top_bar.dart';
import 'package:blood_beacon/app/shared_widgets/my_button.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const AppTopBar(title: 'Edit Profile'),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 4.h),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppField(
                  label: 'Full Name',
                  hint: 'Your name',
                  controller: controller.fullNameController,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Name is required' : null,
                ),
                AppField(
                  label: 'Phone Number',
                  hint: '+1 234 567 890',
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9+ ]'))],
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Phone is required' : null,
                ),
                Obx(
                  () => AppDropdownField(
                    label: 'Blood Group',
                    value: controller.bloodGroup.value,
                    options: AppConstants.bloodGroups,
                    onSelected: (v) => controller.bloodGroup.value = v,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppField(
                        label: 'Age',
                        hint: '25',
                        controller: controller.ageController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Obx(
                        () => AppDropdownField(
                          label: 'Gender',
                          value: controller.gender.value,
                          options: AppConstants.genders,
                          onSelected: (v) => controller.gender.value = v,
                        ),
                      ),
                    ),
                  ],
                ),
                AppField(
                  label: 'City',
                  hint: 'Your city',
                  controller: controller.cityController,
                ),
                AppField(
                  label: 'Medical Eligibility',
                  hint: 'Any conditions / notes',
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
                SizedBox(height: 1.h),
                MyText(
                  title:
                      'Your location helps nearby patients find you during emergencies.',
                  size: 10.sp,
                  clr: AppColors.textMuted,
                  line: 2,
                ),
                SizedBox(height: 3.h),
                Obx(
                  () => MyButton(
                    text: 'Save Changes',
                    isLoading: controller.saving.value,
                    onPressed: controller.save,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

import '../controllers/create_request_controller.dart';

class CreateRequestView extends GetView<CreateRequestController> {
  const CreateRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const AppTopBar(title: 'Emergency Request'),
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
                  label: 'Patient Name',
                  hint: 'Full name of patient',
                  controller: controller.patientNameController,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => AppDropdownField(
                          label: 'Blood Group',
                          value: controller.bloodGroup.value,
                          options: AppConstants.bloodGroups,
                          onSelected: (v) => controller.bloodGroup.value = v,
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: AppField(
                        label: 'Units',
                        hint: '1',
                        controller: controller.unitsController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (v) {
                          final n = int.tryParse(v ?? '');
                          if (n == null || n < 1) return 'Invalid';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                AppField(
                  label: 'Hospital Name',
                  hint: 'Where blood is needed',
                  controller: controller.hospitalNameController,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                AppField(
                  label: 'Hospital Address',
                  hint: 'Address',
                  controller: controller.hospitalAddressController,
                  maxLines: 2,
                ),
                AppField(
                  label: 'Emergency Notes',
                  hint: 'Additional details (optional)',
                  controller: controller.notesController,
                  maxLines: 3,
                ),
                Obx(
                  () => MyButton(
                    text: controller.latitude.value == null
                        ? 'Attach Current Location'
                        : 'Location Attached ✓',
                    icon: Icons.my_location_rounded,
                    isOutlined: true,
                    isLoading: controller.capturingLocation.value,
                    onPressed: controller.captureLocation,
                  ),
                ),
                SizedBox(height: 3.h),
                Obx(
                  () => MyButton(
                    text: 'Post Emergency Request',
                    isLoading: controller.saving.value,
                    onPressed: controller.submit,
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

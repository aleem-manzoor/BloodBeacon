import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/config/app_constants.dart';
import 'package:blood_beacon/app/shared_widgets/app_top_bar.dart';
import 'package:blood_beacon/app/shared_widgets/blood_badge.dart';
import 'package:blood_beacon/app/shared_widgets/my_button.dart';
import 'package:blood_beacon/app/shared_widgets/my_container.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/app/shared_widgets/status_chip.dart';

import '../controllers/request_detail_controller.dart';

class RequestDetailView extends GetView<RequestDetailController> {
  const RequestDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppTopBar(
        title: 'Request Details',
        actions: [
          Obx(() => controller.isOwner
              ? const SizedBox.shrink()
              : IconButton(
                  onPressed: () => _reportSheet(context),
                  icon: const Icon(Icons.flag_outlined,
                      color: AppColors.textDark),
                )),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Obx(() {
          final r = controller.request.value;
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyContainer(
                  child: Row(
                    children: [
                      BloodBadge(group: r.bloodGroup, size: 60),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: r.patientName ?? 'Patient',
                              size: 16.sp,
                              weight: FontWeight.w800,
                              clr: AppColors.textDark,
                            ),
                            SizedBox(height: 0.5.h),
                            MyText(
                              title: '${r.units ?? 1} unit(s) needed',
                              size: 12.sp,
                              clr: AppColors.textMuted,
                            ),
                          ],
                        ),
                      ),
                      StatusChip.forStatus(r.status),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                MyContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _row(Icons.local_hospital_rounded, 'Hospital',
                          r.hospitalName ?? '-'),
                      _row(Icons.location_on_rounded, 'Address',
                          r.hospitalAddress ?? '-'),
                      _row(Icons.person_rounded, 'Requested by',
                          r.createdByName ?? '-'),
                      _row(Icons.access_time_rounded, 'Posted',
                          r.createdAt?.split('T').first ?? '-'),
                      if (r.notes != null && r.notes!.isNotEmpty)
                        _row(Icons.notes_rounded, 'Notes', r.notes!),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
                if (controller.isOwner)
                  Obx(
                    () => MyButton(
                      text: 'Cancel Request',
                      isLoading: controller.busy.value,
                      onPressed: r.status == 'pending' ? controller.cancel : null,
                      color: r.status == 'pending'
                          ? AppColors.primary
                          : AppColors.lightGrey,
                    ),
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: MyButton(
                          text: 'Call',
                          icon: Icons.call_rounded,
                          onPressed: controller.callCreator,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: MyButton(
                          text: 'Navigate',
                          icon: Icons.directions_rounded,
                          isOutlined: true,
                          onPressed: controller.navigate,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _row(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16.sp, color: AppColors.primary),
          SizedBox(width: 3.w),
          SizedBox(
            width: 24.w,
            child: MyText(
              title: label,
              size: 11.5.sp,
              clr: AppColors.textMuted,
              weight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: MyText(
              title: value,
              size: 11.5.sp,
              clr: AppColors.textDark,
              weight: FontWeight.w600,
              line: 4,
            ),
          ),
        ],
      ),
    );
  }

  void _reportSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              title: 'Report this request',
              size: 15.sp,
              weight: FontWeight.w800,
              clr: AppColors.textDark,
            ),
            SizedBox(height: 1.h),
            ...AppConstants.reportReasons.map(
              (reason) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: MyText(
                    title: reason, size: 12.sp, clr: AppColors.textDark),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  Get.back();
                  controller.report(reason);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

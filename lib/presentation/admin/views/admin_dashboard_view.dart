import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/my_container.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/app/shared_widgets/section_header.dart';
import 'package:blood_beacon/app/shared_widgets/stat_card.dart';

import '../controllers/admin_controller.dart';

class AdminDashboardView extends GetView<AdminController> {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.loadStats,
          child: ListView(
            padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 4.h),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        title: 'Admin Panel',
                        size: 18.sp,
                        weight: FontWeight.w800,
                        clr: AppColors.textDark,
                      ),
                      MyText(
                        title: 'Platform overview & moderation',
                        size: 11.sp,
                        clr: AppColors.textMuted,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: controller.logout,
                    icon: const Icon(Icons.logout_rounded,
                        color: AppColors.primary),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              const SectionHeader(title: 'Platform Statistics'),
              _stats(),
              SizedBox(height: 1.h),
              const SectionHeader(title: 'Management'),
              _menu(
                  Icons.people_rounded, 'User Management', controller.goUsers),
              _menu(Icons.bloodtype_rounded, 'Blood Requests',
                  controller.goRequests),
              _menu(Icons.local_hospital_rounded, 'Hospitals & Blood Banks',
                  controller.goHospitals),
              _menu(Icons.flag_rounded, 'User Reports', controller.goReports),
              _menu(Icons.campaign_rounded, 'Announcements',
                  controller.goAnnouncements),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stats() {
    return Obx(() {
      if (controller.loading.value) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h),
          child: const Center(child: CircularProgressIndicator()),
        );
      }
      final entries = controller.stats.entries.toList();
      const icons = [
        Icons.people_rounded,
        Icons.volunteer_activism_rounded,
        Icons.check_circle_rounded,
        Icons.emergency_rounded,
        Icons.water_drop_rounded,
        Icons.local_hospital_rounded,
        Icons.bloodtype_rounded,
      ];
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: entries.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (_, i) => StatCard(
          icon: icons[i % icons.length],
          value: '${entries[i].value}',
          label: entries[i].key,
        ),
      );
    });
  }

  Widget _menu(IconData icon, String title, VoidCallback onTap) {
    return MyContainer(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: 1.4.h),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20.sp),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: MyText(
              title: title,
              size: 13.sp,
              weight: FontWeight.w700,
              clr: AppColors.textDark,
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}

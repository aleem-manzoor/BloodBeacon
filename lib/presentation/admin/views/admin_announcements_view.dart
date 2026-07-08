import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/app_dropdown_field.dart';
import 'package:blood_beacon/app/shared_widgets/app_field.dart';
import 'package:blood_beacon/app/shared_widgets/app_top_bar.dart';
import 'package:blood_beacon/app/shared_widgets/empty_state.dart';
import 'package:blood_beacon/app/shared_widgets/my_button.dart';
import 'package:blood_beacon/app/shared_widgets/my_container.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/data/model/announcement_model.dart';

import '../controllers/admin_announcements_controller.dart';

class AdminAnnouncementsView extends GetView<AdminAnnouncementsController> {
  const AdminAnnouncementsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const AppTopBar(title: 'Announcements'),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        onPressed: () => _form(context),
        icon: const Icon(Icons.add, color: AppColors.white),
        label: MyText(
          title: 'New',
          size: 12.sp,
          weight: FontWeight.w700,
          clr: AppColors.white,
        ),
      ),
      body: SafeArea(
        top: false,
        child: StreamBuilder<List<AnnouncementModel>>(
          stream: controller.announcements,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final items = snapshot.data ?? [];
            if (items.isEmpty) {
              return const EmptyState(
                icon: Icons.campaign_outlined,
                title: 'No announcements',
                subtitle: 'Publish camps, alerts and awareness campaigns.',
              );
            }
            return ListView.builder(
              padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 10.h),
              itemCount: items.length,
              itemBuilder: (_, i) => _tile(items[i]),
            );
          },
        ),
      ),
    );
  }

  Widget _tile(AnnouncementModel a) {
    return MyContainer(
      margin: EdgeInsets.only(bottom: 1.4.h),
      child: Row(
        children: [
          const Icon(Icons.campaign_rounded, color: AppColors.primary),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  title: a.title ?? '-',
                  size: 12.5.sp,
                  weight: FontWeight.w700,
                  clr: AppColors.textDark,
                  line: 1,
                  overFLow: TextOverflow.ellipsis,
                ),
                MyText(
                  title: a.message ?? '',
                  size: 10.5.sp,
                  clr: AppColors.textMuted,
                  line: 2,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => a.id == null ? null : controller.delete(a.id!),
            icon: const Icon(Icons.delete_outline_rounded,
                color: AppColors.primary, size: 20),
          ),
        ],
      ),
    );
  }

  void _form(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.fromLTRB(
            20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                title: 'New Announcement',
                size: 15.sp,
                weight: FontWeight.w800,
                clr: AppColors.textDark,
              ),
              SizedBox(height: 2.h),
              Obx(
                () => AppDropdownField(
                  label: 'Type',
                  value: controller.type.value,
                  options: controller.types,
                  onSelected: (v) => controller.type.value = v,
                ),
              ),
              AppField(label: 'Title', controller: controller.titleController),
              AppField(
                label: 'Message',
                controller: controller.messageController,
                maxLines: 4,
              ),
              Obx(
                () => MyButton(
                  text: 'Publish',
                  isLoading: controller.saving.value,
                  onPressed: controller.publish,
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}

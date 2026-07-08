import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/app_top_bar.dart';
import 'package:blood_beacon/app/shared_widgets/blood_badge.dart';
import 'package:blood_beacon/app/shared_widgets/empty_state.dart';
import 'package:blood_beacon/app/shared_widgets/my_container.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/app/shared_widgets/textfield.dart';
import 'package:blood_beacon/data/model/user_model.dart';

import '../controllers/admin_users_controller.dart';

class AdminUsersView extends GetView<AdminUsersController> {
  const AdminUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const AppTopBar(title: 'User Management'),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 1.h),
              child: InputTextField(
                hint: 'Search by name or email',
                borderRadius: 14,
                padding: true,
                onchange: (v) {
                  controller.query.value = v ?? '';
                  return null;
                },
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.loading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                final items = controller.filtered;
                if (items.isEmpty) {
                  return const EmptyState(
                    icon: Icons.people_outline_rounded,
                    title: 'No users found',
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 4.h),
                  itemCount: items.length,
                  itemBuilder: (_, i) => _tile(items[i]),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(UserModel user) {
    final disabled = user.isDisabled ?? false;
    return MyContainer(
      margin: EdgeInsets.only(bottom: 1.4.h),
      child: Row(
        children: [
          BloodBadge(group: user.bloodGroup, size: 44),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: MyText(
                        title: user.fullName ?? 'User',
                        size: 12.5.sp,
                        weight: FontWeight.w700,
                        clr: AppColors.textDark,
                        line: 1,
                        overFLow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (user.isAdmin) ...[
                      SizedBox(width: 1.w),
                      const Icon(Icons.shield_rounded,
                          size: 14, color: AppColors.info),
                    ],
                  ],
                ),
                MyText(
                  title: user.email ?? '',
                  size: 10.sp,
                  clr: AppColors.textMuted,
                  line: 1,
                  overFLow: TextOverflow.ellipsis,
                ),
                if (disabled)
                  MyText(
                    title: 'Disabled',
                    size: 9.5.sp,
                    weight: FontWeight.w700,
                    clr: AppColors.primary,
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => controller.toggleDisabled(user),
            icon: Icon(
              disabled ? Icons.lock_open_rounded : Icons.block_rounded,
              color: disabled ? AppColors.success : AppColors.warning,
              size: 20,
            ),
          ),
          IconButton(
            onPressed: () =>
                user.uid == null ? null : controller.deleteUser(user.uid!),
            icon: const Icon(Icons.delete_outline_rounded,
                color: AppColors.primary, size: 20),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/app_top_bar.dart';
import 'package:blood_beacon/app/shared_widgets/empty_state.dart';
import 'package:blood_beacon/app/shared_widgets/my_container.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/data/model/notification_model.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  IconData _icon(String? type) {
    switch (type) {
      case 'emergency':
        return Icons.emergency_rounded;
      case 'accepted':
        return Icons.check_circle_rounded;
      case 'reminder':
        return Icons.schedule_rounded;
      case 'announcement':
        return Icons.campaign_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const AppTopBar(title: 'Notifications'),
      body: SafeArea(
        top: false,
        child: StreamBuilder<List<NotificationModel>>(
          stream: controller.notifications,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final items = snapshot.data ?? [];
            if (items.isEmpty) {
              return const EmptyState(
                icon: Icons.notifications_none_rounded,
                title: 'No notifications',
                subtitle: 'Emergency alerts and updates will appear here.',
              );
            }
            return ListView.builder(
              padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 4.h),
              itemCount: items.length,
              itemBuilder: (_, i) {
                final n = items[i];
                return MyContainer(
                  margin: EdgeInsets.only(bottom: 1.4.h),
                  color: n.read ? AppColors.white : AppColors.primaryLight,
                  onTap: () => n.id == null ? null : controller.markRead(n.id!),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(_icon(n.type), color: AppColors.primary),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: n.title ?? 'Notification',
                              size: 12.5.sp,
                              weight: FontWeight.w700,
                              clr: AppColors.textDark,
                              line: 2,
                            ),
                            SizedBox(height: 0.3.h),
                            MyText(
                              title: n.body ?? '',
                              size: 10.5.sp,
                              clr: AppColors.textMuted,
                              line: 3,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            n.id == null ? null : controller.delete(n.id!),
                        icon: const Icon(Icons.close_rounded,
                            size: 18, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

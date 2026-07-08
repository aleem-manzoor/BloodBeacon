import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/app_top_bar.dart';
import 'package:blood_beacon/app/shared_widgets/empty_state.dart';
import 'package:blood_beacon/app/shared_widgets/my_button.dart';
import 'package:blood_beacon/app/shared_widgets/my_container.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/app/shared_widgets/status_chip.dart';
import 'package:blood_beacon/data/model/blood_request_model.dart';

import '../controllers/admin_requests_controller.dart';

class AdminRequestsView extends GetView<AdminRequestsController> {
  const AdminRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const AppTopBar(title: 'Blood Requests'),
      body: SafeArea(
        top: false,
        child: StreamBuilder<List<BloodRequestModel>>(
          stream: controller.requests,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final items = snapshot.data ?? [];
            if (items.isEmpty) {
              return const EmptyState(
                icon: Icons.bloodtype_outlined,
                title: 'No requests',
              );
            }
            return ListView.builder(
              padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 4.h),
              itemCount: items.length,
              itemBuilder: (_, i) => _tile(items[i]),
            );
          },
        ),
      ),
    );
  }

  Widget _tile(BloodRequestModel r) {
    return MyContainer(
      margin: EdgeInsets.only(bottom: 1.6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: MyText(
                  title: '${r.bloodGroup ?? '?'} • ${r.patientName ?? 'Patient'}',
                  size: 13.sp,
                  weight: FontWeight.w700,
                  clr: AppColors.textDark,
                  line: 1,
                  overFLow: TextOverflow.ellipsis,
                ),
              ),
              StatusChip.forStatus(r.moderationStatus),
            ],
          ),
          SizedBox(height: 0.6.h),
          MyText(
            title: '${r.hospitalName ?? '-'} • by ${r.createdByName ?? '-'}',
            size: 10.5.sp,
            clr: AppColors.textMuted,
            line: 2,
          ),
          SizedBox(height: 1.4.h),
          Row(
            children: [
              Expanded(
                child: MyButton(
                  text: 'Approve',
                  height: 5.h,
                  fontSize: 11,
                  color: AppColors.success,
                  onPressed: () =>
                      r.id == null ? null : controller.approve(r.id!),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: MyButton(
                  text: 'Reject',
                  height: 5.h,
                  isOutlined: true,
                  onPressed: () =>
                      r.id == null ? null : controller.reject(r.id!),
                ),
              ),
              SizedBox(width: 2.w),
              GestureDetector(
                onTap: () => r.id == null ? null : controller.delete(r.id!),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.delete_outline_rounded,
                      color: AppColors.primary, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

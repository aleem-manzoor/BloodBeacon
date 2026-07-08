import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/app_field.dart';
import 'package:blood_beacon/app/shared_widgets/app_top_bar.dart';
import 'package:blood_beacon/app/shared_widgets/empty_state.dart';
import 'package:blood_beacon/app/shared_widgets/my_button.dart';
import 'package:blood_beacon/app/shared_widgets/my_container.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/app/shared_widgets/stat_card.dart';

import '../controllers/donation_history_controller.dart';

class DonationHistoryView extends GetView<DonationHistoryController> {
  const DonationHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const AppTopBar(title: 'Donation History'),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        onPressed: () => _addSheet(context),
        icon: const Icon(Icons.add, color: AppColors.white),
        label: MyText(
          title: 'Add',
          size: 12.sp,
          weight: FontWeight.w700,
          clr: AppColors.white,
        ),
      ),
      body: SafeArea(
        top: false,
        child: Obx(() {
          if (controller.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 12.h),
            children: [
              _eligibilityBanner(),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      icon: Icons.bloodtype_rounded,
                      value: '${controller.total}',
                      label: 'Total Donations',
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: StatCard(
                      icon: Icons.event_available_rounded,
                      value: controller.lastDonation
                              ?.toIso8601String()
                              .split('T')
                              .first ??
                          '—',
                      label: 'Last Donation',
                      color: AppColors.info,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              if (controller.donations.isEmpty)
                const EmptyState(
                  icon: Icons.history_rounded,
                  title: 'No donations yet',
                  subtitle: 'Record your donations to track your impact.',
                )
              else
                ...controller.donations.map(_tile),
            ],
          );
        }),
      ),
    );
  }

  Widget _eligibilityBanner() {
    final eligible = controller.isEligible;
    final next = controller.nextEligible;
    return MyContainer(
      gradient: LinearGradient(
        colors: eligible
            ? [AppColors.success, const Color(0xFF1B5E20)]
            : [AppColors.warning, const Color(0xFFEF6C00)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Row(
        children: [
          Icon(
            eligible ? Icons.check_circle_rounded : Icons.schedule_rounded,
            color: AppColors.white,
            size: 34,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  title: eligible
                      ? 'You are eligible to donate'
                      : 'Not eligible yet',
                  size: 13.sp,
                  weight: FontWeight.w800,
                  clr: AppColors.white,
                ),
                MyText(
                  title: eligible
                      ? 'Thank you for being a lifesaver'
                      : 'Next eligible on ${next?.toIso8601String().split('T').first}',
                  size: 10.5.sp,
                  clr: AppColors.white,
                  line: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(donation) {
    return MyContainer(
      margin: EdgeInsets.only(bottom: 1.4.h),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.water_drop_rounded,
                color: AppColors.primary),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  title: donation.hospital ?? 'Donation',
                  size: 12.5.sp,
                  weight: FontWeight.w700,
                  clr: AppColors.textDark,
                ),
                MyText(
                  title:
                      '${donation.date?.split('T').first ?? ''} • ${donation.units ?? 1} unit(s)',
                  size: 10.5.sp,
                  clr: AppColors.textMuted,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20,
            MediaQuery.of(context).viewInsets.bottom + 20),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              title: 'Record a Donation',
              size: 15.sp,
              weight: FontWeight.w800,
              clr: AppColors.textDark,
            ),
            SizedBox(height: 2.h),
            Obx(
              () => AppField(
                label: 'Date',
                hint: 'Tap to select',
                readOnly: true,
                onTap: controller.pickDate,
                controller: TextEditingController(
                  text: controller.date.value?.split('T').first ?? '',
                ),
                suffix: const Icon(Icons.calendar_today_rounded,
                    size: 18, color: AppColors.textMuted),
              ),
            ),
            AppField(
              label: 'Hospital',
              hint: 'Where you donated',
              controller: controller.hospitalController,
            ),
            AppField(
              label: 'Units',
              hint: '1',
              controller: controller.unitsController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(height: 1.h),
            Obx(
              () => MyButton(
                text: 'Save Donation',
                isLoading: controller.saving.value,
                onPressed: controller.addDonation,
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}

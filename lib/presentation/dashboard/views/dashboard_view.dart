import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/my_container.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/app/shared_widgets/section_header.dart';
import 'package:blood_beacon/data/model/announcement_model.dart';
import 'package:blood_beacon/data/model/blood_request_model.dart';
import 'package:blood_beacon/presentation/requests/widgets/request_card.dart';

import '../controllers/dashboard_controller.dart';
import '../widgets/quick_action.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(DashboardController());
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _greeting(c),
              SizedBox(height: 2.h),
              _availabilityBanner(c),
              SizedBox(height: 2.h),
              _quickActions(c),
              SizedBox(height: 1.h),
              _stats(c),
              SizedBox(height: 1.h),
              _announcements(c),
              SectionHeader(
                title: 'Nearby Emergency Cases',
                actionText: 'See all',
                onAction: () => c.switchTab(1),
              ),
              _activeRequests(c),
            ],
          ),
        ),
      ),
    );
  }

  Widget _greeting(DashboardController c) {
    return Obx(() {
      final user = c.session.user.value;
      return Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  title: 'Hello,',
                  size: 12.sp,
                  clr: AppColors.textMuted,
                ),
                SizedBox(height: 0.3.h),
                MyText(
                  title: user?.fullName ?? 'Welcome',
                  size: 18.sp,
                  weight: FontWeight.w800,
                  clr: AppColors.textDark,
                  line: 1,
                  overFLow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: c.goNotifications,
            child: Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(color: AppColors.shadow, blurRadius: 12),
                ],
              ),
              child: const Icon(Icons.notifications_none_rounded,
                  color: AppColors.textDark),
            ),
          ),
        ],
      );
    });
  }

  Widget _availabilityBanner(DashboardController c) {
    return Obx(() {
      final user = c.session.user.value;
      final isDonor = user?.isDonor == true;
      final available = user?.isAvailable == true;
      return MyContainer(
        gradient: LinearGradient(
          colors: isDonor && available
              ? [AppColors.success, const Color(0xFF1B5E20)]
              : [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        child: Row(
          children: [
            const Icon(Icons.bloodtype_rounded,
                color: AppColors.white, size: 38),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    title: isDonor
                        ? (available ? 'You are saving lives' : 'You are offline')
                        : 'Become a Donor',
                    size: 14.sp,
                    weight: FontWeight.w800,
                    clr: AppColors.white,
                  ),
                  SizedBox(height: 0.4.h),
                  MyText(
                    title: isDonor
                        ? (available
                            ? 'Available for emergency requests'
                            : 'Turn on availability in your profile')
                        : 'Register as a donor and help others',
                    size: 10.5.sp,
                    clr: AppColors.white,
                    line: 2,
                  ),
                ],
              ),
            ),
            if (!isDonor)
              GestureDetector(
                onTap: c.becomeDonor,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: MyText(
                    title: 'Join',
                    size: 11.sp,
                    weight: FontWeight.w700,
                    clr: AppColors.primary,
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _quickActions(DashboardController c) {
    return MyContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          QuickAction(
            icon: Icons.add_circle_rounded,
            label: 'Request\nBlood',
            color: AppColors.primary,
            onTap: c.goCreateRequest,
          ),
          QuickAction(
            icon: Icons.search_rounded,
            label: 'Find\nDonors',
            color: AppColors.info,
            onTap: () => c.switchTab(2),
          ),
          QuickAction(
            icon: Icons.local_hospital_rounded,
            label: 'Hospitals',
            color: AppColors.success,
            onTap: c.goHospitals,
          ),
          QuickAction(
            icon: Icons.favorite_rounded,
            label: 'Saved',
            color: AppColors.warning,
            onTap: c.goFavorites,
          ),
        ],
      ),
    );
  }

  Widget _stats(DashboardController c) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Obx(
        () => Row(
          children: [
            _statTile('${c.myRequestCount.value}', 'My Requests', () => c.switchTab(1)),
            SizedBox(width: 3.w),
            _statTile('${c.donationCount.value}', 'Donations', c.goDonations),
            SizedBox(width: 3.w),
            _statTile('${c.favoriteCount.value}', 'Saved', c.goFavorites),
          ],
        ),
      ),
    );
  }

  Widget _statTile(String value, String label, VoidCallback onTap) {
    return Expanded(
      child: MyContainer(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            MyText(
              title: value,
              size: 18.sp,
              weight: FontWeight.w800,
              clr: AppColors.primary,
            ),
            SizedBox(height: 0.4.h),
            MyText(
              title: label,
              size: 10.sp,
              clr: AppColors.textMuted,
              weight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _announcements(DashboardController c) {
    return StreamBuilder<List<AnnouncementModel>>(
      stream: c.announcements,
      builder: (context, snapshot) {
        final items = snapshot.data ?? [];
        if (items.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Announcements'),
            ...items.take(3).map(
                  (a) => MyContainer(
                    color: AppColors.infoLight,
                    shadow: false,
                    margin: EdgeInsets.only(bottom: 1.2.h),
                    child: Row(
                      children: [
                        const Icon(Icons.campaign_rounded, color: AppColors.info),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                title: a.title ?? 'Announcement',
                                size: 13.5.sp,
                                weight: FontWeight.w700,
                                clr: AppColors.textDark,
                              ),
                              MyText(
                                title: a.message ?? '',
                                size: 12.sp,
                                clr: AppColors.textMuted,
                                line: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        );
      },
    );
  }

  Widget _activeRequests(DashboardController c) {
    return StreamBuilder<List<BloodRequestModel>>(
      stream: c.activeRequests,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 3.h),
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        final items = snapshot.data ?? [];
        if (items.isEmpty) {
          return MyContainer(
            shadow: false,
            color: AppColors.white,
            child: Row(
              children: [
                const Icon(Icons.check_circle_outline_rounded,
                    color: AppColors.success),
                SizedBox(width: 3.w),
                Expanded(
                  child: MyText(
                    title: 'No active emergency requests right now',
                    size: 11.5.sp,
                    clr: AppColors.textMuted,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }
        return Column(
          children: items
              .take(5)
              .map((r) => RequestCard(
                    request: r,
                    onTap: () =>
                        Get.toNamed('/request-detail', arguments: r),
                  ))
              .toList(),
        );
      },
    );
  }
}

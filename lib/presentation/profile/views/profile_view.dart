import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/blood_badge.dart';
import 'package:blood_beacon/app/shared_widgets/my_container.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/data/model/user_model.dart';

import '../controllers/profile_controller.dart';
import '../widgets/profile_menu_tile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        bottom: false,
        child: Obx(() {
          final user = controller.session.user.value;
          if (user == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(user, controller),
                SizedBox(height: 2.h),
                _availabilityCard(user, controller),
                SizedBox(height: 2.h),
                _detailsCard(user),
                SizedBox(height: 2.h),
                _menu(controller),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _header(UserModel user, ProfileController c) {
    return MyContainer(
      gradient: const LinearGradient(
        colors: [AppColors.primary, AppColors.primaryDark],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.white,
            backgroundImage: (user.profilePicture != null &&
                    user.profilePicture!.isNotEmpty)
                ? NetworkImage(user.profilePicture!)
                : null,
            child: (user.profilePicture == null || user.profilePicture!.isEmpty)
                ? const Icon(Icons.person, color: AppColors.primary, size: 34)
                : null,
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  title: user.fullName ?? 'BloodBeacon User',
                  size: 16.sp,
                  weight: FontWeight.w800,
                  clr: AppColors.white,
                  line: 1,
                  overFLow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.5.h),
                MyText(
                  title: user.email ?? '',
                  size: 11.sp,
                  clr: AppColors.white,
                  line: 1,
                  overFLow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 1.h),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: MyText(
                    title: user.isDonor == true ? 'Donor' : 'Member',
                    size: 10.sp,
                    weight: FontWeight.w700,
                    clr: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          BloodBadge(group: user.bloodGroup, size: 52),
        ],
      ),
    );
  }

  Widget _availabilityCard(UserModel user, ProfileController c) {
    return MyContainer(
      child: Row(
        children: [
          const Icon(Icons.volunteer_activism_rounded,
              color: AppColors.primary),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  title: 'Availability',
                  size: 13.sp,
                  weight: FontWeight.w700,
                  clr: AppColors.textDark,
                ),
                MyText(
                  title: user.isAvailable == true
                      ? 'Available to donate'
                      : 'Not available',
                  size: 11.sp,
                  clr: AppColors.textMuted,
                ),
              ],
            ),
          ),
          Switch(
            value: user.isAvailable ?? false,
            activeColor: AppColors.primary,
            onChanged: user.isDonor == true ? c.toggleAvailability : null,
          ),
        ],
      ),
    );
  }

  Widget _detailsCard(UserModel user) {
    final rows = <List<String>>[
      ['Phone', user.phoneNumber ?? '-'],
      ['Gender', user.gender ?? '-'],
      ['Age', user.age?.toString() ?? '-'],
      ['City', user.city ?? '-'],
      ['Last donation', user.lastDonationDate?.split('T').first ?? 'Never'],
      ['Eligibility', user.medicalEligibility ?? 'Not provided'],
    ];
    return MyContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            title: 'Profile Details',
            size: 14.sp,
            weight: FontWeight.w700,
            clr: AppColors.textDark,
          ),
          SizedBox(height: 1.5.h),
          ...rows.map(
            (r) => Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 28.w,
                    child: MyText(
                      title: r[0],
                      size: 12.sp,
                      clr: AppColors.textMuted,
                      weight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: MyText(
                      title: r[1],
                      size: 12.sp,
                      clr: AppColors.textDark,
                      weight: FontWeight.w600,
                      line: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menu(ProfileController c) {
    return MyContainer(
      child: Column(
        children: [
          ProfileMenuTile(
            icon: Icons.edit_rounded,
            title: 'Edit Profile',
            onTap: c.editProfile,
          ),
          ProfileMenuTile(
            icon: Icons.bloodtype_rounded,
            title: c.user?.isDonor == true ? 'Donor Settings' : 'Become a Donor',
            onTap: c.becomeDonor,
          ),
          ProfileMenuTile(
            icon: Icons.history_rounded,
            title: 'Donation History',
            onTap: c.openDonationHistory,
          ),
          ProfileMenuTile(
            icon: Icons.favorite_rounded,
            title: 'Saved Hospitals',
            onTap: c.openFavorites,
          ),
          ProfileMenuTile(
            icon: Icons.notifications_rounded,
            title: 'Notifications',
            onTap: c.openNotifications,
          ),
          ProfileMenuTile(
            icon: Icons.logout_rounded,
            title: 'Logout',
            color: AppColors.primary,
            onTap: c.logout,
          ),
        ],
      ),
    );
  }
}

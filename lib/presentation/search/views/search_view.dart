import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/empty_state.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';

import '../controllers/search_controller.dart';
import '../widgets/donor_card.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(DonorSearchController());
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 1.h),
              child: MyText(
                title: 'Find Donors',
                size: 18.sp,
                weight: FontWeight.w800,
                clr: AppColors.textDark,
              ),
            ),
            _filters(c),
            _radius(c),
            Expanded(
              child: Obx(() {
                if (c.loading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (c.donors.isEmpty) {
                  return const EmptyState(
                    icon: Icons.search_off_rounded,
                    title: 'No donors found',
                    subtitle:
                        'Try widening the search radius or selecting a different blood group.',
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 4.h),
                  itemCount: c.donors.length,
                  itemBuilder: (_, i) {
                    final donor = c.donors[i];
                    return DonorCard(
                      donor: donor,
                      distanceKm: c.distanceFor(donor),
                      onCall: () => c.callDonor(donor.phoneNumber),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filters(DonorSearchController c) {
    return SizedBox(
      height: 5.h,
      child: Obx(() {
        final selectedGroup = c.selectedBloodGroup.value;
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          itemCount: c.bloodFilters.length,
          separatorBuilder: (_, __) => SizedBox(width: 2.w),
          itemBuilder: (_, i) {
            final group = c.bloodFilters[i];
            final selected = selectedGroup == group;
            return GestureDetector(
              onTap: () => c.setBloodGroup(group),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : AppColors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: selected ? AppColors.primary : AppColors.divider,
                  ),
                ),
                child: MyText(
                  title: group,
                  size: 11.sp,
                  weight: FontWeight.w700,
                  clr: selected ? AppColors.white : AppColors.textDark,
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _radius(DonorSearchController c) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Row(
          children: [
            MyText(
              title: 'Within',
              size: 11.sp,
              clr: AppColors.textMuted,
              weight: FontWeight.w600,
            ),
            Expanded(
              child: Slider(
                value: c.radiusKm.value,
                min: 1,
                max: 50,
                activeColor: AppColors.primary,
                label: '${c.radiusKm.value.round()} km',
                divisions: 49,
                onChanged: c.setRadius,
                onChangeEnd: (_) => c.search(),
              ),
            ),
            MyText(
              title: '${c.radiusKm.value.round()} km',
              size: 11.sp,
              clr: AppColors.primary,
              weight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}

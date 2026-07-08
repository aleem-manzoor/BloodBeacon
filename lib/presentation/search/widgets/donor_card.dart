import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/blood_badge.dart';
import 'package:blood_beacon/app/shared_widgets/my_container.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/data/model/user_model.dart';

class DonorCard extends StatelessWidget {
  final UserModel donor;
  final double? distanceKm;
  final VoidCallback onCall;
  final VoidCallback? onMap;

  const DonorCard({
    super.key,
    required this.donor,
    required this.onCall,
    this.distanceKm,
    this.onMap,
  });

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      margin: EdgeInsets.only(bottom: 1.6.h),
      child: Row(
        children: [
          BloodBadge(group: donor.bloodGroup, size: 50),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  title: donor.fullName ?? 'Donor',
                  size: 13.sp,
                  weight: FontWeight.w700,
                  clr: AppColors.textDark,
                  line: 1,
                  overFLow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.4.h),
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded,
                        size: 13, color: AppColors.textMuted),
                    SizedBox(width: 1.w),
                    MyText(
                      title: donor.city ?? 'Unknown',
                      size: 10.5.sp,
                      clr: AppColors.textMuted,
                    ),
                    if (distanceKm != null) ...[
                      SizedBox(width: 2.w),
                      MyText(
                        title: '• ${distanceKm!.toStringAsFixed(1)} km',
                        size: 10.5.sp,
                        weight: FontWeight.w600,
                        clr: AppColors.primary,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (onMap != null)
            IconButton(
              onPressed: onMap,
              icon: const Icon(Icons.map_rounded, color: AppColors.info),
            ),
          GestureDetector(
            onTap: onCall,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.call_rounded,
                  color: AppColors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

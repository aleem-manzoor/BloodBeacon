import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/my_container.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/data/model/place_model.dart';

class PlaceCard extends StatelessWidget {
  final PlaceModel place;
  final VoidCallback onTap;

  const PlaceCard({super.key, required this.place, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: 1.6.h),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              place.type == 'Blood Bank'
                  ? Icons.bloodtype_rounded
                  : Icons.local_hospital_rounded,
              color: AppColors.primary,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: MyText(
                        title: place.name ?? 'Location',
                        size: 13.sp,
                        weight: FontWeight.w700,
                        clr: AppColors.textDark,
                        line: 1,
                        overFLow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (place.verified) ...[
                      SizedBox(width: 1.w),
                      const Icon(Icons.verified_rounded,
                          size: 16, color: AppColors.success),
                    ],
                  ],
                ),
                SizedBox(height: 0.4.h),
                MyText(
                  title: place.address ?? place.type ?? '',
                  size: 10.5.sp,
                  clr: AppColors.textMuted,
                  line: 1,
                  overFLow: TextOverflow.ellipsis,
                ),
                if (place.distanceKm != null) ...[
                  SizedBox(height: 0.4.h),
                  MyText(
                    title: '${place.distanceKm!.toStringAsFixed(1)} km away',
                    size: 10.sp,
                    weight: FontWeight.w600,
                    clr: AppColors.primary,
                  ),
                ],
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}

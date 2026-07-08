import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/my_button.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/model/place_model.dart';

class PlaceSheet {
  static void show(PlaceModel place, {VoidCallback? onFavorite}) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: MyText(
                    title: place.name ?? 'Location',
                    size: 16.sp,
                    weight: FontWeight.w800,
                    clr: AppColors.textDark,
                    line: 2,
                  ),
                ),
                if (place.verified)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.successLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.verified_rounded,
                            size: 14, color: AppColors.success),
                        SizedBox(width: 1.w),
                        MyText(
                          title: 'Verified',
                          size: 9.sp,
                          weight: FontWeight.w700,
                          clr: AppColors.success,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 1.h),
            if (place.address != null)
              MyText(
                title: place.address!,
                size: 12.sp,
                clr: AppColors.textMuted,
                line: 3,
              ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: MyButton(
                    text: 'Navigate',
                    icon: Icons.directions_rounded,
                    onPressed: () => _navigate(place),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: MyButton(
                    text: 'Call',
                    icon: Icons.call_rounded,
                    isOutlined: true,
                    onPressed: () => _call(place.phone),
                  ),
                ),
              ],
            ),
            if (onFavorite != null) ...[
              SizedBox(height: 1.5.h),
              MyButton(
                text: 'Save to Favorites',
                icon: Icons.favorite_border_rounded,
                color: AppColors.warning,
                onPressed: () {
                  Get.back();
                  onFavorite();
                },
              ),
            ],
            SizedBox(height: 1.h),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  static Future<void> _navigate(PlaceModel place) async {
    if (place.latitude == null || place.longitude == null) return;
    final uri = Uri.parse(
        'https://www.openstreetmap.org/directions?to=${place.latitude}%2C${place.longitude}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> _call(String? phone) async {
    if (phone == null || phone.isEmpty) {
      Utils.showToast(message: 'No phone number available');
      return;
    }
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Utils.showToast(message: 'Could not start a call');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/blood_badge.dart';
import 'package:blood_beacon/app/shared_widgets/my_container.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/app/shared_widgets/status_chip.dart';
import 'package:blood_beacon/data/model/blood_request_model.dart';

class RequestCard extends StatelessWidget {
  final BloodRequestModel request;
  final VoidCallback? onTap;
  final double? distanceKm;

  const RequestCard({
    super.key,
    required this.request,
    this.onTap,
    this.distanceKm,
  });

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: 1.6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BloodBadge(group: request.bloodGroup, size: 46),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      title: request.patientName ?? 'Patient',
                      size: 14.5.sp,
                      weight: FontWeight.w700,
                      clr: AppColors.textDark,
                      line: 1,
                      overFLow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 0.4.h),
                    MyText(
                      title: '${request.units ?? 1} unit(s) needed',
                      size: 12.5.sp,
                      clr: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
              StatusChip.forStatus(request.status),
            ],
          ),
          SizedBox(height: 1.4.h),
          _infoRow(Icons.local_hospital_rounded, request.hospitalName ?? '-'),
          if (request.hospitalAddress != null &&
              request.hospitalAddress!.isNotEmpty)
            _infoRow(Icons.location_on_rounded, request.hospitalAddress!),
          if (distanceKm != null)
            _infoRow(Icons.directions_rounded,
                '${distanceKm!.toStringAsFixed(1)} km away'),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(top: 0.6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 14.sp, color: AppColors.textMuted),
          SizedBox(width: 2.w),
          Expanded(
            child: MyText(
              title: text,
              size: 12.5.sp,
              clr: AppColors.textMuted,
              weight: FontWeight.w500,
              line: 2,
              overFLow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

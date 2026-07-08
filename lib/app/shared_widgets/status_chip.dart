import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../config/app_colors.dart';
import 'my_text.dart';

class StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color background;

  const StatusChip({
    super.key,
    required this.label,
    required this.color,
    required this.background,
  });

  factory StatusChip.forStatus(String? status) {
    switch (status) {
      case 'accepted':
      case 'approved':
      case 'completed':
      case 'available':
        return StatusChip(
            label: _cap(status!),
            color: AppColors.success,
            background: AppColors.successLight);
      case 'pending':
      case 'reviewed':
        return StatusChip(
            label: _cap(status!),
            color: AppColors.warning,
            background: AppColors.warningLight);
      case 'cancelled':
      case 'rejected':
      case 'unavailable':
      case 'actioned':
        return StatusChip(
            label: _cap(status!),
            color: AppColors.primary,
            background: AppColors.primaryLight);
      default:
        return StatusChip(
            label: _cap(status ?? 'Unknown'),
            color: AppColors.textMuted,
            background: AppColors.divider);
    }
  }

  static String _cap(String s) =>
      s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(30),
      ),
      child: MyText(
        title: label,
        size: 10.sp,
        weight: FontWeight.w700,
        clr: color,
      ),
    );
  }
}

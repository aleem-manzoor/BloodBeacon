import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../config/app_colors.dart';
import 'my_text.dart';

class AppDropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final String hint;
  final List<String> options;
  final ValueChanged<String> onSelected;

  const AppDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onSelected,
    this.hint = 'Select',
  });

  void _open(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: MyText(
                title: label,
                size: 15.sp,
                weight: FontWeight.w700,
                clr: AppColors.textDark,
              ),
            ),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: options.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, color: AppColors.divider),
                itemBuilder: (_, i) {
                  final selected = options[i] == value;
                  return ListTile(
                    title: MyText(
                      title: options[i],
                      size: 14.sp,
                      clr: selected ? AppColors.primary : AppColors.textDark,
                      weight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                    trailing: selected
                        ? const Icon(Icons.check_circle, color: AppColors.primary)
                        : null,
                    onTap: () {
                      onSelected(options[i]);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          title: label,
          size: 13.sp,
          weight: FontWeight.w600,
          clr: AppColors.textDark,
        ),
        SizedBox(height: 1.h),
        GestureDetector(
          onTap: () => _open(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.inputBorder.withOpacity(.6)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: MyText(
                    title: value ?? hint,
                    size: 14.sp,
                    clr: value == null ? AppColors.hint : AppColors.textDark,
                    weight: FontWeight.w500,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textMuted),
              ],
            ),
          ),
        ),
        SizedBox(height: 2.h),
      ],
    );
  }
}

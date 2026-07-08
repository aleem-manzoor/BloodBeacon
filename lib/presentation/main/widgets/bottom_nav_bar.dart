import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    [Icons.home_rounded, 'Home'],
    [Icons.bloodtype_rounded, 'Requests'],
    [Icons.search_rounded, 'Search'],
    [Icons.map_rounded, 'Map'],
    [Icons.person_rounded, 'Profile'],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(color: AppColors.shadow, blurRadius: 18, offset: Offset(0, -4)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final selected = i == currentIndex;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTap(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                      horizontal: selected ? 4.w : 2.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primaryLight : AppColors.trans,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _items[i][0] as IconData,
                        color: selected ? AppColors.primary : AppColors.textMuted,
                        size: 20.sp,
                      ),
                      if (selected) ...[
                        SizedBox(width: 1.5.w),
                        MyText(
                          title: _items[i][1] as String,
                          size: 11.sp,
                          weight: FontWeight.w700,
                          clr: AppColors.primary,
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

import '../config/app_colors.dart';
import 'my_text.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? color;
  final Color? textColor;
  final double? height;
  final double? width;
  final double radius;
  final IconData? icon;
  final double? fontSize;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.color,
    this.textColor,
    this.height,
    this.width,
    this.radius = 14,
    this.icon,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isOutlined ? AppColors.trans : (color ?? AppColors.primary);
    final fg = textColor ??
        (isOutlined ? (color ?? AppColors.primary) : AppColors.white);
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 6.5.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(radius),
          border: isOutlined
              ? Border.all(color: color ?? AppColors.primary, width: 1.4)
              : null,
        ),
        child: isLoading
            ? CupertinoActivityIndicator(color: fg)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: fg, size: 18.sp),
                    SizedBox(width: 2.w),
                  ],
                  MyText(
                    title: text,
                    size: 15.sp,
                    weight: FontWeight.w600,
                    clr: fg,
                  ),
                ],
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../config/app_colors.dart';

class MyContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double radius;
  final BoxBorder? border;
  final bool shadow;
  final VoidCallback? onTap;
  final Gradient? gradient;
  final double? width;

  const MyContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.radius = 18,
    this.border,
    this.shadow = true,
    this.onTap,
    this.gradient,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: padding ?? const EdgeInsets.all(16),
        margin: margin,
        decoration: BoxDecoration(
          color: gradient == null ? (color ?? AppColors.cardBg) : null,
          gradient: gradient,
          borderRadius: BorderRadius.circular(radius),
          border: border,
          boxShadow: shadow
              ? const [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: child,
      ),
    );
  }
}

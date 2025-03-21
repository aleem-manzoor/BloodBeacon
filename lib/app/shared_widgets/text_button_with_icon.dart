import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ppsc_preparation/app/shared_widgets/my_text.dart';
import 'package:ppsc_preparation/app/utils/utils.dart';
import 'package:sizer/sizer.dart';

class TextButtonWithIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final String icon;
  final String text;
  final Color iconColor;
  final Color textColor;
  final Color? backgroundColor;
  final double borderRadius;
  final EdgeInsets padding;
  final double iconSize;

  const TextButtonWithIcon({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    this.iconColor = Colors.white,
    this.textColor = Colors.white,
    this.backgroundColor,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextButton.icon(
        onPressed: onPressed,
        icon: SvgPicture.asset(
          Utils.getSvgPath(icon),
          color: iconColor,
        ),
        label: MyText(
          title: text,
          weight: FontWeight.w400,
          size: 15.sp,
          clr: textColor,
        ),
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}

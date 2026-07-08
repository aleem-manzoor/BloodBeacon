import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/custom_svg_image.dart';

class CustomIconContainer extends StatelessWidget {
  final Color? backgroundColor;
  final String icon;
  final double? height;
  final VoidCallback? onTap;
  const CustomIconContainer(
      {super.key,
      this.backgroundColor,
      required this.icon,
      this.height,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: height ?? Get.height / 17,
          // width: 50,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.grey.withOpacity(.5),
              borderRadius: BorderRadius.circular(5)),
          child: CustomSVGImage(path: icon)),
    );
  }
}

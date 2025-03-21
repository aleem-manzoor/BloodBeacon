import 'package:dio_log/dio_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppsc_preparation/app/utils/utils.dart';
import 'package:sizer/sizer.dart';

import '../config/app_colors.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function()? onPress;
  final double? height;
  final double? width;
  final Color textColor;
  final bool isCupertinoIndicator;
  final Color boxColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? radius;
  final FontWeight? weight;
  final BoxBorder? boxBorder;
  const CustomButton(
      {super.key,
      this.width,
      this.height,
      this.fontWeight,
      this.boxBorder,
      this.isCupertinoIndicator = false,
      required this.text,
      required this.onPress,
      required this.textColor,
      required this.boxColor,
      this.fontSize,
      this.radius,
      this.weight});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      onLongPress: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HttpLogListWidget(),
          ),
        );
      },
      child: Container(
        width: widget.width ?? double.infinity,
        height: widget.height ?? Get.height / 15,
        decoration: BoxDecoration(
          color: widget.boxColor,
          border: widget.boxBorder,
          borderRadius: BorderRadius.circular(widget.radius ?? 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(widget.text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontWeight: widget.weight ?? FontWeight.w400,
                      fontSize: widget.fontSize ?? 15.sp,
                      color: widget.textColor,
                      decoration: TextDecoration.none,
                    ))),
            widget.isCupertinoIndicator
                ? const CupertinoActivityIndicator(
                        color: AppColors.white, radius: 8)
                    .paddingOnly(left: 12)
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

class SocialButton extends StatefulWidget {
  final String text;
  final Function()? onPress;
  final double? height;
  final double? width;
  final String logo;
  final Color textColor;
  final Color? backgroundColor;
  final bool isCupertinoIndicator;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? radius;
  final FontWeight? weight;
  final double? scale;
  const SocialButton(
      {super.key,
      this.width,
      required this.logo,
      this.height,
      this.fontWeight,
      this.isCupertinoIndicator = false,
      required this.text,
      this.scale,
      required this.onPress,
      required this.textColor,
      this.fontSize,
      this.radius,
      this.weight,
      this.backgroundColor});

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      onLongPress: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HttpLogListWidget(),
          ),
        );
      },
      child: Container(
        width: widget.width ?? double.infinity,
        height: widget.height ?? Get.height / 15.5,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColors.white,
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(widget.radius ?? 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Utils.getIconPath(widget.logo),
              scale: widget.scale,
            ),
            widget.isCupertinoIndicator
                ? const CupertinoActivityIndicator(
                        color: AppColors.white, radius: 8)
                    .paddingOnly(left: 12)
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

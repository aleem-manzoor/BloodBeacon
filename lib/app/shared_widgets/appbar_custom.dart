import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppsc_preparation/app/extensions/extensions.dart';
import 'package:ppsc_preparation/app/utils/utils.dart';
import 'package:sizer/sizer.dart';
import 'package:ppsc_preparation/app/shared_widgets/my_text.dart';
import '../config/app_colors.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  // final bool? trailing;
  final double? leadingWidth;
  final bool centerTitle;
  final Color? color;
  final List<Widget>? actions;
  final VoidCallback? onLeadingPressed;
  final Widget? titleWidget;
  final Widget? leading;
  final Color? iconColor;
  final bool isLogo;

  const AppBarCustom({
    super.key,
    this.title,
    this.color,
    this.actions,
    this.onLeadingPressed,
    this.leadingWidth,
    this.iconColor,
    this.centerTitle = true,
    this.isLogo = false,
    this.titleWidget,
    this.leading,
    //  this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.trans,
      // systemOverlayStyle: const SystemUiOverlayStyle(
      //   statusBarColor: Colors.transparent,
      //   statusBarIconBrightness: Brightness.dark,
      // ),
      title: titleWidget ??
          (title == null
              ? null
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Utils.getIconPath("logo_green"),
                      scale: 5,
                    ),
                    2.w.width,
                    MyText(
                      title: "Beaverise",
                      weight: FontWeight.w700,
                      size: 22.sp,
                      clr: AppColors.black,
                    ),
                  ],
                )),
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      leadingWidth: leadingWidth ?? 35,
      leading: onLeadingPressed == null
          ? leading
          : IconButton(
              color: AppColors.secondary,
              onPressed: onLeadingPressed, // Call the callback function here
              icon: Icon(
                CupertinoIcons.back,
                color: iconColor ?? AppColors.black,
                size: 18.sp,
              ),
            ).paddingOnly(left: 6),
      actions: actions,
      // actions:trailing==null?null: [
      //   IconButton(
      //     color: AppColors.white,
      //     onPressed: () {
      //       Get.toNamed(Routes.NOTIFICATIONS);
      //     },
      //     icon: Container(
      //         padding: EdgeInsets.all(5),
      //         decoration: BoxDecoration(
      //             color: AppColors.white,
      //             shape: BoxShape.circle,
      //             boxShadow: [
      //               BoxShadow(
      //                   color: AppColors.black
      //                       .withOpacity(0.15),
      //                   blurRadius: 32,
      //                   spreadRadius: 0,
      //                   offset: const Offset(6, 5))
      //             ]),
      //         child: Image.asset(Utils.getIconPath('Bell'),scale: 4.0,)),
      //   )
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

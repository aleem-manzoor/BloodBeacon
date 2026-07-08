import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/extensions/extensions.dart';
import 'package:blood_beacon/app/shared_widgets/custom_cricle_avatar.dart';
import 'package:blood_beacon/app/shared_widgets/custom_dialog.dart';
import 'package:blood_beacon/app/shared_widgets/custom_svg_image.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:sizer/sizer.dart';

class TooltipShape extends ShapeBorder {
  const TooltipShape();

  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

    path.moveTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);
    path.lineTo(rrect.width - 30, 0);
    path.lineTo(rrect.width - 20, -10);
    path.lineTo(rrect.width - 10, 0);
    path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
    path.lineTo(rrect.width, rrect.height - 10);
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - 10, rrect.height);
    path.lineTo(10, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}

class CustomPopup {
  static showPopup(context) {
    showMenu(
      context: context,
      menuPadding: const EdgeInsets.all(0),
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      shape: const TooltipShape(),
      items: [
        PopupMenuItem(
          enabled: false,
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              2.h.height,
              Stack(
                children: [
                  ListTile(
                    onTap: () {
                      //todo
                    },
                    leading: const CustomCircleAvatar(
                      imageUrl:
                          "https://s3-alpha-sig.figma.com/img/b854/771f/d7da580ca2833364b8bbfb7efa3ccda1?Expires=1739750400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=n7uHqjt1w~H4-ZQl5mHMhcOXtklb3cmIuCAfqqER1uVvaCKnCe6eSgthbwUXBB2ah1p0zDOTB4Sz5V8QIjR76zXpvQu9CB~ews1-rNKCAJrIu5WyuQW9chrMGe8OtSx~m8QyLMnoMvpjOBJW18zu3aBNyCCUy-hggksAxLt~wRWeiLC8zGBcpKh4V7acWYibMQIrg1iN2sczyRpJ0B-HOrrfYPCnh9kW-Bnyu0GHg3iE6Gyo1H1sG~7G4XxqI6t~D62nrAcP9kcR5lgR8qh2CXU5VB0B~44k3jKiM81myK1AlTCKZHFZlU2pxNZ3OtVGcNb3F5J6H~659UbWjcdJ0w__",
                      radius: 20,
                    ),
                    title: MyText(
                      title: 'Zubair Jameel',
                      size: 15.sp,
                      weight: FontWeight.w700,
                      clr: AppColors.white,
                    ),
                    subtitle: MyText(
                      title: 'zubairjameel@gmail.com',
                      size: 13.sp,
                      weight: FontWeight.w500,
                      clr: AppColors.white,
                    ),
                    trailing: SvgPicture.asset(
                      Utils.getSvgPath('arrow_up_circle'),
                    ), //todo
                  ).paddingSymmetric(horizontal: 10),
                  const Positioned(
                      top: 25,
                      left: 25,
                      child: CustomSVGImage(
                        path: 'camera',
                      )),
                ],
              ),
              InkWell(
                onTap: () {
                  //todo
                },
                child: Container(
                  width: Get.width * .3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: MyText(
                    title: 'Store Account',
                    size: 13.sp,
                    weight: FontWeight.w600,
                    clr: AppColors.white,
                  ),
                ).paddingSymmetric(horizontal: 15),
              ),
              const Divider(
                color: AppColors.black,
              ).paddingSymmetric(vertical: 10),
              CustomMenuTile(
                icon: "manage_apps",
                title: 'Manage Apps',
                onTap: () {
                  //todo
                },
              ),
              CustomMenuTile(
                icon: "notifications_&_offers",
                title: 'Notifications & offers',
                onTap: () {
                  //todo
                },
              ),
              Container(
                color: AppColors.black,
                child: Column(
                  children: [
                    CustomMenuTile(
                      icon: "settings1",
                      title: 'Settings',
                      onTap: () {
                        //todo
                      },
                    ),
                    CustomMenuTile(
                      icon: "help_&_feedback",
                      title: 'Help & feedback',
                      onTap: () {
                        //todo
                      },
                    ),
                    CustomMenuTile(
                      icon: "logout",
                      title: 'Logout',
                      onTap: () {
                        Get.back();
                        Get.dialog(
                          CustomLogoutDialog(
                            title: "",
                            content: "Are you sure you want to logout?",
                            yesButtonText: "Yes",
                            noButtonText: "No",
                            onYesTap: () async {
                              Get.back();
                              // await  controller.logout();
                              log("Logged out");
                            },
                            onNoTap: () {
                              Get.back();
                              log("Canceled logout");
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomMenuTile extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback? onTap;
  const CustomMenuTile(
      {super.key, required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      minVerticalPadding: 0,
      minLeadingWidth: 15,
      isThreeLine: false,
      leading: SvgPicture.asset(Utils.getSvgPath(icon)),
      title: MyText(
        title: title,
        size: 14.sp,
        weight: FontWeight.w600,
        clr: AppColors.white,
      ),
    );
  }
}

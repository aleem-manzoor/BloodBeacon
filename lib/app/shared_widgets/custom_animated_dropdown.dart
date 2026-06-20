// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'package:ppsc_preparation/app/extensions/extensions.dart';
// import 'package:ppsc_preparation/app/shared_widgets/my_text.dart';
// import '../config/app_colors.dart';

// class CustomAnimatedDropdown extends StatelessWidget {
//   final String text;
//   final VoidCallback onTap;
//   final Color? backgroundColor;
//   final Color? expensionColor;
//   final Color? textColor;
//   final bool isTileOpen;
//   final List<Widget> children;
//   final double? fontSize;

//   const CustomAnimatedDropdown(
//       {super.key,
//       required this.text,
//       required this.onTap,
//       this.backgroundColor,
//       this.textColor,
//       required this.isTileOpen,
//       required this.children,
//       this.fontSize,
//       this.expensionColor});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: onTap,
//           child: Container(
//             height: Get.height / 15.6,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: AppColors.grey.withOpacity(0.50)),
//               color: backgroundColor ?? AppColors.white,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 MyText(title: text),
//                 // Smooth icon transition
//                 AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 300),
//                   transitionBuilder:
//                       (Widget child, Animation<double> animation) {
//                     return RotationTransition(
//                         turns: AlwaysStoppedAnimation(isTileOpen ? 0.50 : 0.0),
//                         child: child);
//                   },
//                   child: const Icon(Icons.keyboard_arrow_down),
//                   // child: Image.asset(
//                   //   Utils.getIconPath(
//                   //     isTileOpen
//                   //       ? 'up'
//                   //     :
//                   //       'down'),
//                   //   key: ValueKey<bool>(isTileOpen),
//                   //   scale: 4.0,
//                   //   color: AppColors.black,
//                   // ),
//                 ),
//               ],
//             ).paddingSymmetric(horizontal: 4.w),
//           ),
//         ),
//         .5.h.height,
// // Smooth expansion and collapse of the container
//         AnimatedSize(
//           duration: const Duration(milliseconds: 250),
//           curve: Curves
//               .easeInOut, // Smoother curve for natural expansion and collapse
//           child: Container(
//             width: double.infinity,
//             padding: isTileOpen ? const EdgeInsets.all(10.0) : EdgeInsets.zero,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               color: expensionColor ?? AppColors.grey.withOpacity(0.05),
//             ),
//             child: isTileOpen
//                 ? AnimatedOpacity(
//                     opacity: isTileOpen ? 1.0 : 0.0, // Fades in the content
//                     duration: const Duration(milliseconds: 300),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: children,
//                     ),
//                   )
//                 : const SizedBox(), // Empty space when tile is closed
//           ),
//         ),
//       ],
//     );
//   }
// }

// class CustomAnimatedStep extends StatelessWidget {
//   final String text;
//   final VoidCallback onTap;
//   final Color? backgroundColor;
//   final Color? expensionColor;
//   final Color? textColor;
//   final Color? iconClr;
//   final bool isTileOpen;
//   final List<Widget> children;
//   final double? fontSize;

//   const CustomAnimatedStep(
//       {super.key,
//       required this.text,
//       required this.onTap,
//       this.backgroundColor,
//       this.textColor,
//       required this.isTileOpen,
//       required this.children,
//       this.fontSize,
//       this.expensionColor,
//       this.iconClr});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: onTap,
//           child: Container(
//             height: Get.height / 22,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: isTileOpen
//                   ? const BorderRadius.vertical(top: Radius.circular(10))
//                   : BorderRadius.circular(10),
//               border: Border.all(color: AppColors.grey.withOpacity(0.20)),
//               color: backgroundColor ?? AppColors.white,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 MyText(title: text),
//                 // Smooth icon transition
//                 AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 300),
//                   transitionBuilder:
//                       (Widget child, Animation<double> animation) {
//                     return RotationTransition(
//                         turns: AlwaysStoppedAnimation(isTileOpen ? 0.50 : 0.0),
//                         child: child);
//                   },
//                   child: Icon(
//                     Icons.keyboard_arrow_down,
//                     color: iconClr ?? AppColors.black,
//                   ),
//                   // child: Image.asset(
//                   //   Utils.getIconPath(
//                   //     isTileOpen
//                   //       ? 'up'
//                   //     :
//                   //       'down'),
//                   //   key: ValueKey<bool>(isTileOpen),
//                   //   scale: 4.0,
//                   //   color: AppColors.black,
//                   // ),
//                 ),
//               ],
//             ).paddingSymmetric(horizontal: 4.w),
//           ),
//         ),
// // Smooth expansion and collapse of the container
//         AnimatedSize(
//           duration: const Duration(milliseconds: 250),
//           curve: Curves
//               .easeInOut, // Smoother curve for natural expansion and collapse
//           child: Container(
//             width: double.infinity,
//             padding: isTileOpen ? const EdgeInsets.all(10.0) : EdgeInsets.zero,
//             decoration: BoxDecoration(
//                 borderRadius:
//                     BorderRadius.vertical(bottom: Radius.circular(10)),
//                 color: expensionColor ?? AppColors.white,
//                 boxShadow: [
//                   BoxShadow(
//                       color: AppColors.black.withOpacity(0.15),
//                       blurRadius: 2,
//                       offset: Offset(0, 1))
//                 ]),
//             child: isTileOpen
//                 ? AnimatedOpacity(
//                     opacity: isTileOpen ? 1.0 : 0.0, // Fades in the content
//                     duration: const Duration(milliseconds: 300),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: children,
//                     ),
//                   )
//                 : const SizedBox(), // Empty space when tile is closed
//           ),
//         ),
//       ],
//     );
//   }
// }

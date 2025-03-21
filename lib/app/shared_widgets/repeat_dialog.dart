// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';

// class ShowRepeatBottom extends StatelessWidget {
//   final List<String> repeatList;
//   final List<String> endList;
//   final Function()? onSelectedHours;
//   final Function()? onSelectedMinutes;

//   const ShowRepeatBottom({
//     super.key,
//     required this.onSelectedHours,
//     required this.onSelectedMinutes,
//     required this.repeatList,
//     required this.endList,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 24),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30),
//               topRight: Radius.circular(30)
//           ),
//         ),
//         width: double.infinity,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           GestureDetector(
//             onTap: (){
//               Get.back();
//             },
//             child: const Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Icon(CupertinoIcons.multiply),
//               ],
//             ),
//           ),
//           MyText(
//             title: 'Repeats',
//             size: 16.sp,
//             weight: FontWeight.w500,
//             textAlign: TextAlign.center,
//           ).paddingOnly(bottom: 20),
//           SizedBox(
//             height: 100, // Set a fixed height for the picker
//             child: CupertinoPicker(
//               // selectionOverlay: Container(
//               //   padding: const EdgeInsets.symmetric(horizontal: 10.0), // Add padding to match text width
//               //
//               //   // padding: const EdgeInsets.symmetric(
//               //   //     horizontal: 1.0, vertical: 2.5),
//               //   decoration: BoxDecoration(
//               //     border: Border.all(
//               //       color: AppColors.primary,
//               //       width: 1,
//               //     ),
//               //   ),
//               // ),
//               useMagnifier: true,
//               itemExtent: 30, // Adjust itemExtent for visibility
//               onSelectedItemChanged: (v) => onSelectedHours?.call(),
//               children: List.generate(repeatList.length, (index) {
//                 return Center(child: MyText(title: repeatList[index]));
//               }),
//             ),
//           ),

//           MyText(
//             title: 'Ends',
//             size: 16.sp,
//             weight: FontWeight.w500,
//             textAlign: TextAlign.center,
//           ).paddingOnly(bottom: 20),

//           SizedBox(
//             height: 100, // Set a fixed height for the picker
//             child: CupertinoPicker(
//               // selectionOverlay: Container(
//               //   padding: const EdgeInsets.symmetric(
//               //       horizontal: 24.0, vertical: 2.5),
//               //   decoration: BoxDecoration(
//               //
//               //     border: Border.all(
//               //       color: AppColors.primary,
//               //       width: 1,
//               //     ),
//               //   ),
//               // ),

//               useMagnifier: true,
//               itemExtent: 30, // Adjust itemExtent for visibility
//               onSelectedItemChanged: (v) => onSelectedMinutes?.call(),
//               children: List.generate(endList.length, (index) {
//                 return Center(child: MyText(title: endList[index]));
//               }),
//             ),
//           ),

//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               CustomTextButton(
//                   fontSize: 12.sp,
//                   textColor: AppColors.hint,
//                   text: 'Cancel', onTap: (){
//                 Get.back();
//               }).paddingOnly(right: 20),
//               CustomTextButton(
//                   fontSize: 12.sp,
//                   textColor: AppColors.primary,
//                   weight: FontWeight.w600,
//                   text: 'Save', onTap: (){
//                 Get.back();
//               }).paddingOnly(right: 14),
//             ],
//           ).paddingOnly(top: 20)

//         ],
//       ),
//     );
//   }
// }

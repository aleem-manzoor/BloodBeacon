// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ppsc_preparation/app/config/app_colors.dart';
// import 'package:sizer/sizer.dart';

// class CustomRichText extends StatelessWidget {
//   final List<DescriptionModel> descriptions;
// final double? fontSize;
// final FontWeight? fontWeight;
// final Color? boldColor;
//   const CustomRichText({super.key, required this.descriptions, this.fontSize, this.fontWeight, this.boldColor});

//   @override
//   Widget build(BuildContext context) {
//     return RichText(
//       textAlign: TextAlign.center,
//       text: TextSpan(
//         children: _buildTextSpans(),
//         style: const TextStyle(),
//       ),
//     );
//   }

//   List<InlineSpan> _buildTextSpans() {
//     return descriptions.map((model) {
//       return TextSpan(
//         text: model.text,
//         style: _getTextStyle(model),
//       );
//     }).toList();
//   }

//   TextStyle _getTextStyle(DescriptionModel model) {
//     return GoogleFonts.plusJakartaSans(
//       fontWeight: model.isBold ? FontWeight.w600 : FontWeight.w400,
//       fontSize: fontSize ?? 22.sp,
//       color:  model.isBold ? (boldColor ?? AppColors.black): AppColors.black,

//     );
//   }
// }

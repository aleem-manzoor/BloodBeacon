import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppsc_preparation/app/utils/utils.dart';
import 'package:sizer/sizer.dart';
import '../config/app_colors.dart';

class InputTextField extends StatefulWidget {
  final String? initial;
  final String? hint;
  final String? label;
  final FocusNode? focusNode;
  final String? prefixIcon;
  final String? suffixIcon;
  final Color? suffixColor;
  final Color? backgroundColor;
  final VoidCallback? suffixOntap;
  final bool? isPrefixIcon;
  final bool? fromLogin;
  final bool? isObscure;
  final double? borderRadius;
  final bool? padding;
  final Decoration? decoration;
  final bool? readOnly;
  final int? maxLines;
  final double? height;
  final bool isFilled;
  final Color? filledColor;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final String? Function(String?)? onchange;
  final String? Function(String?)? onSaved;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatter;
  const InputTextField(
      {super.key,
      this.maxLines,
      this.borderRadius,
      this.decoration,
      this.height,
      this.filledColor,
      this.isFilled = false,
      this.focusNode,
      this.isPrefixIcon = false,
      this.fromLogin = false,
      this.isObscure = false,
      this.padding = false,
      this.hint,
      this.textInputType,
      this.onSaved,
      this.controller,
      this.label,
      this.validation,
      this.onchange,
      this.prefixIcon,
      this.initial,
      this.readOnly,
      this.suffixIcon,
      this.suffixOntap,
      this.suffixColor,
      this.onTap,
      this.inputFormatter,
      this.backgroundColor});

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.inputFormatter,
      onTap: widget.onTap,
      initialValue: widget.initial,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (val) {},
      readOnly: widget.readOnly ?? false,
      keyboardType: widget.textInputType ?? TextInputType.text,
      validator: widget.validation,
      onSaved: widget.onSaved,
      focusNode: widget.focusNode,
      onChanged: widget.onchange,
      obscureText: widget.isObscure ?? false,
      controller: widget.controller,
      cursorColor: AppColors.inputBorder,
      maxLines: widget.maxLines ?? 1,
      style: GoogleFonts.plusJakartaSans(
          color: AppColors.grey, fontSize: 15.sp, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
          contentPadding: widget.padding == true
              ? const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
              : const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          labelText: widget.label,
          suffixIcon: widget.suffixIcon == null
              ? null
              : GestureDetector(
                  onTap: widget.suffixOntap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Image.asset(
                      Utils.getIconPath(widget.suffixIcon ?? ''),
                      scale: 4,
                      color: widget.suffixColor ?? AppColors.black,
                    ),
                  ),
                ),
          prefixIcon: widget.isPrefixIcon == true
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0), // Add horizontal padding
                  child: SvgPicture.asset(
                    Utils.getSvgPath(widget.prefixIcon ?? ''),
                    width: 10.0,
                    height: 10.0,
                  ),
                )
              : null,
          errorStyle: GoogleFonts.plusJakartaSans(
              color: AppColors.red,
              fontSize: 13.4.sp,
              fontWeight: FontWeight.w500),
          labelStyle: GoogleFonts.plusJakartaSans(
              color: AppColors.grey, //todo
              fontSize: 14.sp,
              fontWeight: FontWeight.w500),
          hintText: widget.hint,
          filled: true,
          fillColor: widget.filledColor ?? AppColors.inputfield,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: const BorderSide(width: 1, color: AppColors.errorColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: const BorderSide(width: 1, color: AppColors.primary),
          ),
          hintStyle: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.hint),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
              borderSide:
                  const BorderSide(width: 1, color: AppColors.errorColor)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: BorderSide(
                width: 1, color: AppColors.inputBorder.withOpacity(.5)),
          )),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final String? hint;
  final String? label;
  final Widget? suffixIcon;
  final bool isObscure;
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final String? Function(String?)? onchange;
  final String? Function(String?)? onSave;

  const PasswordTextField(
      {super.key,
      this.suffixIcon,
      this.isObscure = false,
      this.hint,
      this.controller,
      this.onSave,
      this.label,
      this.validation,
      this.onchange});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validation,
      onChanged: widget.onchange,
      controller: widget.controller,
      obscureText: widget.isObscure,
      onSaved: widget.onSave,
      style: TextStyle(color: AppColors.white, fontSize: 10.sp),
      decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(color: AppColors.white),
          hintText: widget.hint,
          suffixIcon: widget.suffixIcon,
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.white)),
          hintStyle: TextStyle(
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.white),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.white))),
    );
  }
}

// class SearchTextField extends StatefulWidget {
//   final String? hint;
//   final String? label;
//   final Widget? pre;
//   final bool isEnabled;
//   final Color? fillColor;
//   final TextEditingController controller;
//   final String? Function(String?)? validation;
//   final String? Function(String?)? onchange;
//
//   const SearchTextField(
//       {super.key,
//         this.isEnabled = true,
//         this.fillColor = AppColors.pinColor,
//         this.hint,
//         required this.controller,
//         this.label,
//         this.validation,
//         this.onchange,
//         this.pre});
//
//   @override
//   State<SearchTextField> createState() => _SearchTextFieldState();
// }
//
// class _SearchTextFieldState extends State<SearchTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       enabled: widget.isEnabled,
//       cursorColor: AppColors.darkGrey,
//       validator: widget.validation,
//       onChanged: widget.onchange,
//       controller: widget.controller,
//       decoration: InputDecoration(
//           contentPadding:
//           const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
//           labelText: widget.label,
//           prefixIcon: const Padding(
//             padding: EdgeInsets.only(left: 14),
//             child: Icon(CupertinoIcons.search,
//                 color: AppColors.darkGrey, size: 24),
//           ),
//           fillColor: widget.fillColor,
//           prefixIconConstraints: const BoxConstraints(
//             minWidth: 50,
//             minHeight: 50,
//           ),
//           filled: true,
//           labelStyle: GoogleFonts.poppins(
//               color: AppColors.darkGrey,
//               fontSize: 9.sp,
//               fontWeight: FontWeight.w400),
//           hintText: widget.hint,
//           // focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: AppColors.button)),
//           hintStyle: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//               color: AppColors.darkGrey),
//           disabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide:
//               const BorderSide(width: 1, color: AppColors.pinColor)),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide:
//               const BorderSide(width: 1, color: AppColors.pinColor)),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide:
//               const BorderSide(width: 1, color: AppColors.pinColor))),
//     );
//   }
// }
//
class MessageTextField extends StatefulWidget {
  final String? hint;
  final String? label;
  final Icon? pre;
  final Widget? suffixIcon;
  final bool? fromLogin;
  final Color? labelClr;
  final bool? read;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatter;
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final String? Function(String?)? onchange;
  final String? Function(String?)? onSaved;
  final int? minLines;
  final int? maxLines;
  final double? borderRadius;
  final FocusNode? focusNode;
  const MessageTextField(
      {super.key,
      this.fromLogin = false,
      this.read = false,
      this.inputFormatter,
      this.hint,
      this.labelClr,
      this.textInputType,
      this.onSaved,
      this.controller,
      this.label,
      this.validation,
      this.onchange,
      this.pre,
      this.minLines,
      this.maxLines,
      this.borderRadius,
      this.suffixIcon,
      this.focusNode});

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      readOnly: widget.read ?? false,
      keyboardType: widget.textInputType ?? TextInputType.text,
      validator: widget.validation,
      onSaved: widget.onSaved,
      onChanged: widget.onchange,
      controller: widget.controller,
      cursorColor: AppColors.hint,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      style: GoogleFonts.urbanist(
          color: AppColors.hint, fontSize: 10.sp, fontWeight: FontWeight.w500),
      inputFormatters: widget.inputFormatter ?? [],
      decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: widget.pre,
          suffixIcon: widget.suffixIcon,
          labelStyle: GoogleFonts.urbanist(
              color: widget.labelClr ?? AppColors.grey,
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w500),
          hintText: widget.hint,
          filled: true,
          fillColor: AppColors.inputfield,
          errorBorder: UnderlineInputBorder(
              borderRadius: widget.fromLogin == true
                  ? BorderRadius.only(
                      topRight: Radius.circular(widget.borderRadius ?? 8),
                      bottomRight: Radius.circular(widget.borderRadius ?? 8),
                    )
                  : BorderRadius.circular(8),
              borderSide:
                  const BorderSide(width: 1, color: AppColors.inputfield)),
          focusedBorder: UnderlineInputBorder(
              borderRadius: widget.fromLogin == true
                  ? BorderRadius.only(
                      topRight: Radius.circular(widget.borderRadius ?? 8),
                      bottomRight: Radius.circular(widget.borderRadius ?? 8),
                    )
                  : BorderRadius.circular(widget.borderRadius ?? 8),
              borderSide:
                  const BorderSide(width: 1, color: AppColors.inputfield)),
          hintStyle: GoogleFonts.urbanist(
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lightGrey),
          focusedErrorBorder: UnderlineInputBorder(
              borderRadius: widget.fromLogin == true
                  ? BorderRadius.only(
                      topRight: Radius.circular(widget.borderRadius ?? 8),
                      bottomRight: Radius.circular(widget.borderRadius ?? 8),
                    )
                  : BorderRadius.circular(widget.borderRadius ?? 8),
              borderSide:
                  const BorderSide(width: 1, color: AppColors.inputfield)),
          enabledBorder: UnderlineInputBorder(
              borderRadius: widget.fromLogin == true
                  ? BorderRadius.only(
                      topRight: Radius.circular(widget.borderRadius ?? 8),
                      bottomRight: Radius.circular(widget.borderRadius ?? 8),
                    )
                  : BorderRadius.circular(widget.borderRadius ?? 8),
              borderSide:
                  const BorderSide(width: 1, color: AppColors.inputfield))),
    );
  }
}

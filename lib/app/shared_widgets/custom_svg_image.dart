import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:blood_beacon/app/utils/utils.dart';

class CustomSVGImage extends StatelessWidget {
  final String path;
  final Color? clr;
  final double? width;
  final double? height;
  const CustomSVGImage(
      {super.key, required this.path, this.clr, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Utils.getSvgPath(path),
      fit: BoxFit.scaleDown,
      width: width ?? 40,
      height: height ?? 40,
      color: clr,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ppsc_preparation/app/config/app_colors.dart';
import 'package:ppsc_preparation/app/utils/utils.dart';

class Background extends StatelessWidget {
  final Widget child;
  final ImageProvider? img;
  const Background({super.key, required this.child, this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.white,
          image: DecorationImage(
              image: AssetImage(Utils.getImagePath('background1')),
              fit: BoxFit.fill)),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ppsc_preparation/app/utils/utils.dart';

class BackgroundView extends StatelessWidget {
  final Widget child;
  const BackgroundView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            // Background image covering the whole screen
            Positioned(
              child: Image.asset(
                Utils.getImagePath('background'),
                fit: BoxFit.cover, // Ensure the image covers the screen
              ),
            ),
            // Positioned container with child
            Positioned.fill(
              top: 20.h,
              left: 0,
              right: 0, // Ensure horizontal constraints are set
              bottom: 0,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

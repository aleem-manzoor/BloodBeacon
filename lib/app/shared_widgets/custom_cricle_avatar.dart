import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ppsc_preparation/app/utils/utils.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final bool useSvg;
  const CustomCircleAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 40.0,
    this.useSvg = false,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[200],
      child: ClipOval(
        child: useSvg
            ? SvgPicture.asset(Utils.getSvgPath(imageUrl))
            : Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: radius * 2,
                height: radius * 2,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // Image loaded successfully
                  }
                  return const Center(
                    child:
                        CupertinoActivityIndicator(), // Show loader while loading
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                      size: radius,
                    ), // Show error icon if image fails to load
                  );
                },
              ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double scale;

  const CustomNetworkImage(
      {super.key, required this.imageUrl, this.scale = 1.0});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => const Center(
        child: CupertinoActivityIndicator(),
      ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(
          CupertinoIcons.exclamationmark_circle,
          color: Colors.red,
          size: 40,
        ),
      ),
    );
  }
}

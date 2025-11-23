import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCashedNetworkImage extends StatelessWidget {
  const CustomCashedNetworkImage({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
  });
  final String imagePath;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath,
      height: height ?? 80,
      width: width ?? 140,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
      fit: BoxFit.cover,
    );
  }
}

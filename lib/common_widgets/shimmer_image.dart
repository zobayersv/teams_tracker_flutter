import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImage extends StatelessWidget {
  final String imageUrl;
  final String placeholder;
  final double height;
  final double width;
  final double borderRadius;
  final BorderRadius? customRadius;
  final BoxFit? boxFit;

  const ShimmerImage({
    super.key,
    required this.imageUrl,
    required this.placeholder,
    required this.height,
    required this.width,
    this.borderRadius = 12,
    this.customRadius,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: customRadius ?? BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        key: key,
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: boxFit ?? BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade100,
          child: Container(height: height, width: width, color: Colors.white),
        ),
        errorWidget: (context, url, error) => Image.asset(
          placeholder,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

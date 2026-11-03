import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:location_tracker/assets_helper/app_image.dart';

class AppNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final double borderRadius;
  final BorderRadius? customRadius;
  final BoxFit fit;
  final String? placeholderAsset;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.borderRadius = 8,
    this.customRadius,
    this.fit = BoxFit.cover,
    this.placeholderAsset,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return ClipRRect(
        borderRadius: customRadius ?? BorderRadius.circular(borderRadius.r),
        child: Image.asset(
          placeholderAsset ?? AppImages.placeholderImage,
          height: height,
          width: width,
          fit: fit,
        ),
      );
    }

    return ClipRRect(
      borderRadius: customRadius ?? BorderRadius.circular(borderRadius.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        height: height,
        width: width,
        fit: fit,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(height: height, width: width, color: Colors.white),
        ),
        errorWidget: (context, url, error) => Image.asset(
          placeholderAsset ?? AppImages.placeholderImage,
          height: height,
          width: width,
          fit: fit,
        ),
      ),
    );
  }
}

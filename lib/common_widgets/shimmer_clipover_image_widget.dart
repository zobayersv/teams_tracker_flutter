import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerClipOvalWidget extends StatelessWidget {
  const ShimmerClipOvalWidget({
    super.key,
    this.networkImageLink,
    this.height,
    this.weight,
    this.borderColor,
  });

  final String? networkImageLink;
  final double? height;
  final double? weight;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final effectiveKey = key ?? ValueKey(networkImageLink ?? 'default_avatar');

    return ClipOval(
      child: SizedBox(
        height: height ?? 50,
        width: weight ?? 50,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: borderColor != null
                ? Border.all(color: borderColor!, width: 2)
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              key: effectiveKey,
              imageUrl: networkImageLink ?? "",
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 300),
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[200]!,
                period: const Duration(milliseconds: 800),
                child: Container(color: Colors.grey[300]),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: Icon(Icons.person, size: 30, color: Colors.white70),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

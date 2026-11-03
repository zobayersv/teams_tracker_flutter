import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:location_tracker/assets_helper/app_colors.dart';
import 'package:location_tracker/assets_helper/app_lottie.dart';

Widget loadingIndicatorCircle({
  required BuildContext context,
  Color? color,
  double? size,
}) {
  return Center(
    child: SizedBox(
      height: (size ?? 70).sp,
      width: (size ?? 70).sp,
      child: Lottie.asset(
        AppLottie.loading,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Center(
          child: CircularProgressIndicator(color: color ?? AppColors.primary),
        ),
      ),
    ),
  );
}

Widget shimmer({
  required BuildContext context,
  required String name,
  double? size,
}) {
  return Center(
    child: Lottie.asset(
      name,
      height: (size ?? 100).sp,
      width: (size ?? 100).sp,
    ),
  );
}

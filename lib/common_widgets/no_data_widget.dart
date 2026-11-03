import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location_tracker/constants/text_font_style.dart';

class NoDataWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? icon;

  const NoDataWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[icon!, SizedBox(height: 16.h)],
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextFontStyle.textStyle16c141A37Urbanist600,
            ),
            if (subtitle != null) ...[
              SizedBox(height: 8.h),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: TextFontStyle.textStyle14c6B7280Urbanist400,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

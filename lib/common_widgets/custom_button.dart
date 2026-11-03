// ignore_for_file: non_constant_identifier_names

import 'package:location_tracker/common_widgets/common_import.dart';

Widget CustomButton({
  required String name,
  required VoidCallback onCallBack,
  bool isPlainButton = false,
  double? height,
  double? minWidth,
  double borderRadius = 100.0,
  Color? color,
  FontWeight? fontWeight,
  Color? textColor,
  double? fontSize,
  EdgeInsetsGeometry? padding,
  TextStyle? textStyle,
  Widget? prefixImage,
  Icon? iconPrefix,
  Widget? suffixImage,
  Color? borderColor,
  double elevation = 0.0,
  Color? shadowColor,
}) {
  final Color buttonColor = color ?? AppColors.buttonColor;

  final bool showShadowAndInner = !isPlainButton;

  return SizedBox(
    height: height ?? 56.h,
    child: Stack(
      children: [
        // ================== Main Button Container ==================
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),

            gradient: showShadowAndInner
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      buttonColor.withValues(alpha: 1.0),
                      buttonColor.withValues(alpha: 0.85),
                    ],
                  )
                : null,

            color: isPlainButton ? buttonColor : null,

            border: Border.all(
              color:
                  borderColor ??
                  (isPlainButton
                      ? borderColor ?? Colors.transparent
                      : AppColors.buttonColor),
              width: 1,
            ),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: padding ?? EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              minimumSize: Size(minWidth ?? double.infinity, height ?? 56.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              elevation: 0,
            ),
            onPressed: onCallBack,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prefixImage != null) ...[
                  prefixImage,
                  UIHelper.horizontalSpace(12.w),
                ],
                if (iconPrefix != null) ...[
                  iconPrefix,
                  UIHelper.horizontalSpace(12.w),
                ],
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style:
                      textStyle ??
                      TextFontStyle.sfpro18w400Primary.copyWith(
                        color: textColor ?? AppColors.secondaryColor,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                      ),
                ),
                if (suffixImage != null) ...[
                  UIHelper.horizontalSpace(12.w),
                  suffixImage,
                ],
              ],
            ),
          ),
        ),

        // ================== Inner Shadow (শুধু gradient button এ) ==================
        if (showShadowAndInner)
          Positioned.fill(
            child: IgnorePointer(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: CustomPaint(
                  painter: _InnerShadowPainter(
                    borderRadius: borderRadius,
                    shadowColor: shadowColor ?? AppColors.buttonColor,
                  ),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

class _InnerShadowPainter extends CustomPainter {
  final double borderRadius;
  final Color shadowColor;

  _InnerShadowPainter({required this.borderRadius, required this.shadowColor});

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(borderRadius),
    );

    canvas.save();
    canvas.clipRRect(rrect);

    final shadowPaint = Paint()
      ..color = shadowColor.withValues(alpha: .3)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 2);

    // Top
    canvas.drawRect(
      Rect.fromLTWH(0, -10, size.width, 14), // 14-10 = 4px
      shadowPaint,
    );

    // Bottom
    canvas.drawRect(
      Rect.fromLTWH(0, size.height - 4, size.width, 14), // 4px
      shadowPaint,
    );

    // Left
    canvas.drawRect(
      Rect.fromLTWH(-10, 0, 14, size.height), // 14-10 = 4px
      shadowPaint,
    );

    // Right
    canvas.drawRect(
      Rect.fromLTWH(size.width - 4, 0, 14, size.height), // 4px
      shadowPaint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

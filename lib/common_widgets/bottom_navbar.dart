import 'package:location_tracker/common_widgets/common_import.dart';

class BottomActionBar extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPrimaryTap;
  final VoidCallback? onBackTap; // null dile back button hide hobe
  final bool isLoading;
  final Color? buttonColor;
  final EdgeInsetsGeometry? padding;

  const BottomActionBar({
    super.key,
    required this.buttonText,
    this.onPrimaryTap,
    this.onBackTap,
    this.isLoading = false,
    this.buttonColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: padding ?? EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
        child: Row(
          children: [
            if (onBackTap != null) ...[_backButton(), SizedBox(width: 12.w)],
            Expanded(child: _primaryButton()),
          ],
        ),
      ),
    );
  }

  Widget _backButton() {
    return InkWell(
      onTap: onBackTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        height: 54.h,
        width: 54.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Icon(
          Icons.chevron_left_rounded,
          size: 24.sp,
          color: AppColors.c141A37,
        ),
      ),
    );
  }

  Widget _primaryButton() {
    return InkWell(
      onTap: isLoading ? null : onPrimaryTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        height: 54.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor ?? AppColors.c141A37,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.h,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                buttonText,
                style: TextFontStyle.textStyle16cFFFFFFUrbanist600,
              ),
      ),
    );
  }
}

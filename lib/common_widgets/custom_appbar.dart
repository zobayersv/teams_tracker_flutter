import 'package:location_tracker/common_widgets/common_import.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.action,
    this.hideBackIcon = false,
    this.centerTitle,
    this.appBarWidget,
    this.onTap,
  });

  final String? title;
  final Widget? action;
  final Widget? appBarWidget;
  final bool? centerTitle;
  final bool hideBackIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        hideBackIcon
            ? SizedBox(width: 50.w)
            : GestureDetector(
                onTap: onTap ?? () => NavigationService.goBack,
                child: CircleAvatar(
                  radius: 25.r,
                  backgroundColor: AppColors.cFFFFFF,
                  child: SvgPicture.asset(AppIcons.arrowLeft, height: 24.r),
                ),
              ),
        UIHelper.horizontalSpace(16.w),
        Expanded(
          child:
              appBarWidget ??
              Text(
                title ?? '',
                style: TextFontStyle.sfpro24w600Secondary,
                textAlign: TextAlign.center,
              ),
        ),
        UIHelper.horizontalSpace(16.w),
        action ?? SizedBox(width: 50.w),
      ],
    );
  }
}

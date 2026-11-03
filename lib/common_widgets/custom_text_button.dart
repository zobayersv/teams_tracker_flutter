import 'package:location_tracker/common_widgets/common_import.dart';

class CustomTextButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final Color? textColor;
  final double? fontSize;

  const CustomTextButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    this.textColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        buttonName,
        style: TextFontStyle.sfpro14w400Primary.copyWith(
          color: textColor,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

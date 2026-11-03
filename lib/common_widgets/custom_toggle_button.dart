import 'package:location_tracker/common_widgets/common_import.dart';

class CustomToggleButton extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomToggleButton({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: 48.w,
        height: 26.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: value ? const Color(0xFFFF8C00) : AppColors.cE5E7EB,
          border: Border.all(width: 1, color: const Color(0xFFFF8C00)),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.all(3.w),
            width: 20.w,
            height: 20.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

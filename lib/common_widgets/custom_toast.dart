import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:location_tracker/assets_helper/app_colors.dart';

void customToastMessage(String title, String message) {
  final isError = title.toLowerCase().contains('error');
  Fluttertoast.showToast(
    msg: message.tr,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: isError ? AppColors.cBE364E : AppColors.c141A37,
    textColor: AppColors.cFFFFFF,
  );
}

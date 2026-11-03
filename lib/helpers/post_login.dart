import 'dart:developer';
import 'package:location_tracker/constants/app_constants.dart';
import 'package:location_tracker/helpers/di.dart';
import 'package:location_tracker/networks/dio/dio.dart';

Future<void> performPostLoginActions() async {
  try {
    final token = appData.read(kKeyAccessToken);
    if (token != null && token.toString().isNotEmpty) {
      DioSingleton.instance.update(token.toString());
      log("Dio configured with authenticated bearer token.");
    }
  } catch (e) {
    log("Error during performPostLoginActions: $e");
  }
}

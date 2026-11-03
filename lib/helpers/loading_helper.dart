import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:location_tracker/assets_helper/app_colors.dart';
import 'package:location_tracker/common_widgets/loading_indicators.dart';
import 'package:location_tracker/helpers/navigation_service.dart';

extension Loader on Future {
  Future<dynamic> waitingForFuture() async {
    showDialog(
      context: NavigationService.context,
      barrierColor: AppColors.c2F2F2F.withValues(alpha: .5),
      builder: (context) => loadingIndicatorCircle(context: context),
    );

    try {
      dynamic result = await this;
      return result;
    } finally {
      NavigationService.goBack;
    }
  }

  Future<dynamic> waitingForFutureWithoutBg() async {
    showDialog(
      context: NavigationService.context,
      barrierColor: Colors.transparent,
      builder: (context) => loadingIndicatorCircle(context: context),
    );

    try {
      dynamic result = await this;
      return result;
    } finally {
      NavigationService.goBack;
    }
  }

  Future<void> waitingForFutureWithTime({
    Duration duration = const Duration(milliseconds: 500),
  }) async {
    try {
      showDialog(
        context: NavigationService.context,
        barrierColor: Colors.transparent,
        builder: (context) => loadingIndicatorCircle(context: context),
      );
      await this;
      NavigationService.goBack;
      await Future.delayed(duration);
    } catch (e) {
      NavigationService.goBack;
      log(e.toString());
      rethrow;
    }
  }
}

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class BlurredBottomSheetRoute<T> extends ModalBottomSheetRoute<T> {
  final ui.ImageFilter? blurFilter;

  BlurredBottomSheetRoute({
    required super.builder,
    super.capturedThemes,
    super.barrierLabel,
    super.barrierOnTapHint,
    super.backgroundColor,
    super.elevation,
    super.shape,
    super.clipBehavior,
    super.constraints,
    super.modalBarrierColor,
    super.isDismissible = true,
    super.enableDrag = true,
    super.showDragHandle,
    required super.isScrollControlled,
    super.scrollControlDisabledMaxHeightRatio,
    super.settings,
    super.requestFocus,
    super.transitionAnimationController,
    super.anchorPoint,
    super.useSafeArea = false,
    super.sheetAnimationStyle,
    this.blurFilter,
  });

  @override
  ui.ImageFilter? get filter =>
      blurFilter ?? ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5);
}

Future<T?> showBlurredBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  Color? barrierColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  BoxConstraints? constraints,
  bool isScrollControlled = true,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  bool? showDragHandle,
  bool useSafeArea = false,
  RouteSettings? routeSettings,
  ui.ImageFilter? filter,
}) {
  return Navigator.of(context, rootNavigator: useRootNavigator).push(
    BlurredBottomSheetRoute<T>(
      builder: builder,
      capturedThemes: InheritedTheme.capture(
        from: context,
        to: Navigator.of(context, rootNavigator: useRootNavigator).context,
      ),
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor ?? Colors.transparent,
      modalBarrierColor:
          barrierColor ?? const Color(0xFF091413).withValues(alpha: 0.10),
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      showDragHandle: showDragHandle,
      useSafeArea: useSafeArea,
      settings: routeSettings,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints,
      blurFilter: filter ?? ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
    ),
  );
}

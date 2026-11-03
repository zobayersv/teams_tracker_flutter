import 'package:flutter/material.dart';
import 'package:location_tracker/common_widgets/loading_indicators.dart';

class WaitingWidget extends StatelessWidget {
  final double? size;

  const WaitingWidget({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: loadingIndicatorCircle(context: context, size: size),
    );
  }
}

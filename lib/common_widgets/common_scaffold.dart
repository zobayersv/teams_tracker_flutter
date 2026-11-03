import 'package:flutter/material.dart';

class BackgroundScaffold extends StatelessWidget {
  final Widget body;
  final String backgroundImage;
  final bool resizeToAvoidBottomInset;

  // Changed padding type to EdgeInsets? instead of String
  final EdgeInsets? padding;

  // Optional scaffold features
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;

  const BackgroundScaffold({
    super.key,
    required this.body,
    required this.backgroundImage,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.appBar,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: Image.asset(backgroundImage, fit: BoxFit.cover),
          ),
          SafeArea(
            child: Padding(padding: padding ?? EdgeInsets.all(16), child: body),
          ),
        ],
      ),
    );
  }
}

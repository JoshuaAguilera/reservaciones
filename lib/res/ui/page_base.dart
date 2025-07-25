import 'package:flutter/material.dart';

class PageBase extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double padH;
  final double padV;
  final void Function(bool, Object?)? onClosePage;
  final Color? backgroundColor;

  const PageBase({
    super.key,
    required this.children,
    this.onClosePage,
    this.spacing = 10,
    this.padH = 10,
    this.padV = 12,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (onClosePage != null) {
          onClosePage!(didPop, result);
        }
      },
      child: Scaffold(
        backgroundColor:
            backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
          child: SingleChildScrollView(
            child: Column(
              spacing: spacing,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}

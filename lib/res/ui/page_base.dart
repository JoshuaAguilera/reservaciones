import 'package:flutter/material.dart';

class PageBase extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final void Function(bool, Object?)? onClosePage;

  const PageBase({
    super.key,
    required this.children,
    this.onClosePage,
    this.spacing = 10,
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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

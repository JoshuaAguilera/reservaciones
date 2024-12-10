import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget ProgressIndicatorCustom({
  required double screenHight,
  double sizeProgressIndicator = 45,
  Widget? message,
  bool inHorizontal = false,
  Color? colorIndicator,
}) {
  return Center(
    child: Padding(
      padding: EdgeInsets.only(top: screenHight * 0.37),
      child: Center(
        child: Column(
          children: [
            if (!inHorizontal)
              LoadingAnimationWidget.fourRotatingDots(
                color: colorIndicator ?? Colors.grey,
                size: sizeProgressIndicator,
              )
            else
              LoadingAnimationWidget.progressiveDots(
                color: colorIndicator ?? Colors.grey,
                size: sizeProgressIndicator,
              ),
            message ?? const SizedBox(),
          ],
        ),
      ),
    ),
  );
}

Widget ProgressIndicatorEstandar({
  double sizeProgressIndicator = 45,
  bool inHorizontal = false,
}) {
  if (inHorizontal) {
    return Center(
      child: LoadingAnimationWidget.progressiveDots(
        color: Colors.grey,
        size: sizeProgressIndicator,
      ),
    );
  } else {
    return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
        color: Colors.grey,
        size: sizeProgressIndicator,
      ),
    );
  }
}

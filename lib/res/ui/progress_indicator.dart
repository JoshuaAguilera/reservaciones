import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget ProgressIndicatorCustom({
  required double screenHight,
  double sizeProgressIndicator = 45,
  Widget? message,
  String typeLoading = "fourRotatingDots",
  Color? colorIndicator,
}) {
  Widget typeLoadingIndicator = LoadingAnimationWidget.fourRotatingDots(
    color: colorIndicator ?? Colors.grey,
    size: sizeProgressIndicator,
  );

  switch (typeLoading) {
    case "progressiveDots":
      typeLoadingIndicator = LoadingAnimationWidget.progressiveDots(
        color: colorIndicator ?? Colors.grey,
        size: sizeProgressIndicator,
      );
      break;
    case "staggeredDotsWave":
      typeLoadingIndicator = LoadingAnimationWidget.staggeredDotsWave(
        color: colorIndicator ?? Colors.grey,
        size: sizeProgressIndicator - 10,
      );
      break;
    default:
      typeLoadingIndicator = LoadingAnimationWidget.fourRotatingDots(
        color: colorIndicator ?? Colors.grey,
        size: sizeProgressIndicator,
      );
  }

  return Center(
    child: Padding(
      padding: EdgeInsets.only(top: screenHight * 0.37),
      child: Center(
        child: Column(
          children: [
            typeLoadingIndicator,
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

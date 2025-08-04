import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget ProgressIndicatorCustom({
  required double screenHeight,
  double sizeProgressIndicator = 45,
  Widget? message,
  Color? colorIndicator,
  IndicatorType type = IndicatorType.fourRotatingDots,
}) {
  Widget typeLoadingIndicator = LoadingAnimationWidget.fourRotatingDots(
    color: colorIndicator ?? Colors.grey,
    size: sizeProgressIndicator,
  );

  /*
  LoadingAnimationWidget.twoRotatingArc(
                            size: 25,
                            color: foregroundColorInt ?? Colors.white,
                          )
   */

  switch (type) {
    case IndicatorType.progressiveDots:
      typeLoadingIndicator = LoadingAnimationWidget.progressiveDots(
        color: colorIndicator ?? Colors.grey,
        size: sizeProgressIndicator,
      );
      break;
    case IndicatorType.staggeredDotsWave:
      typeLoadingIndicator = LoadingAnimationWidget.staggeredDotsWave(
        color: colorIndicator ?? Colors.grey,
        size: sizeProgressIndicator - 10,
      );
      break;
    case IndicatorType.fourRotatingDots:
      typeLoadingIndicator = LoadingAnimationWidget.fourRotatingDots(
        color: colorIndicator ?? Colors.grey,
        size: sizeProgressIndicator,
      );
      break;
    case IndicatorType.twoRotatingArc:
      typeLoadingIndicator = LoadingAnimationWidget.twoRotatingArc(
        color: colorIndicator ?? Colors.grey,
        size: sizeProgressIndicator,
      );
      break;
  }

  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        typeLoadingIndicator,
        message ?? const SizedBox(),
      ],
    ),
  );
}

enum IndicatorType {
  progressiveDots,
  staggeredDotsWave,
  fourRotatingDots,
  twoRotatingArc,
  /* etc */
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

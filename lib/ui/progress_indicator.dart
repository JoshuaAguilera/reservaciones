import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget ProgressIndicatorCustom(
    {required double screenHight, double sizeProgressIndicator = 45}) {
  return Center(
    child: Padding(
      padding: EdgeInsets.only(top: screenHight * 0.37),
      child: Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          color: Colors.grey,
          size: sizeProgressIndicator,
        ),
      ),
    ),
  );
}

Widget ProgressIndicatorEstandar({double sizeProgressIndicator = 45}) {
  return Center(
    child: LoadingAnimationWidget.fourRotatingDots(
      color: Colors.grey,
      size: sizeProgressIndicator,
    ),
  );
}

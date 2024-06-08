import 'package:flutter/material.dart';

class WidgetResizable {
  Padding containerResizable(
      {Widget? child, double height = 0, double width = 0}) {
    double maxHeight = 0;
    double maxWidth = 0;
    switch (height) {
      case >= 1080:
        maxHeight = 200;
        break;
      case >= 720:
        maxHeight = 200;
        break;
      case >= 576:
        maxHeight = 100;
        break;
      case < 576:
        maxHeight = 75;
        break;
      default:
    }

    switch (width) {
      case >= 1920:
        maxWidth = 550;
        break;
      case >= 1280:
        maxWidth = 300;
        break;
      case >= 768:
        maxWidth = 100;
        break;
      case < 768:
        maxWidth = 50;
        break;
      default:
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: maxWidth, vertical: maxHeight),
      child: child,
    );
  }
}

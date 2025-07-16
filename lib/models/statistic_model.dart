import 'package:flutter/material.dart';

class Statistic {
  String title;
  IconData? icon;
  String metrics;
  Color? color;

  Statistic({
    required this.title,
    required this.icon,
    required this.metrics,
    required this.color,
  });
}

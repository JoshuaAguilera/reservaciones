import 'package:flutter/material.dart';

import 'permiso_model.dart';

class SidebarItem {
  final String route;
  final String title;
  final IconData icon;
  int index;
  final List<Permiso> requiredPermissions;

  SidebarItem({
    required this.route,
    required this.title,
    required this.icon,
    this.index = 0,
    required this.requiredPermissions,
  });
}

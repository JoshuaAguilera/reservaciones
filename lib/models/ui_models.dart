import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'permiso_model.dart';

class SidebarItem {
  final String route;
  String subRoute;
  String arg;
  final String title;
  final IconData icon;
  int index;
  Tuple2<String?, int?>? ids;
  final List<Permiso> requiredPermissions;

  SidebarItem({
    required this.route,
    this.subRoute = '',
    this.arg = '',
    required this.title,
    required this.icon,
    this.index = 0,
    required this.requiredPermissions,
    this.ids,
  });

  SidebarItem copyWith({
    String? route,
    String? subRoute,
    String? arg,
    String? title,
    IconData? icon,
    int? index,
    Tuple2<String?, int?>? ids,
  }) {
    return SidebarItem(
      route: route ?? this.route,
      subRoute: subRoute ?? this.subRoute,
      arg: arg ?? this.arg,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      index: index ?? this.index,
      requiredPermissions: requiredPermissions,
      ids: ids ?? this.ids,
    );
  }
}

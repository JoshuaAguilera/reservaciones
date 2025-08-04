import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

import '../../models/list_helper_model.dart';

final sectionManagerProvider = StateProvider<List<bool>>((ref) {
  return [true, false];
});

final filterUMProvider = StateProvider<FilterUserManager>((ref) {
  return FilterUserManager(
    layout: Layout.checkList,
    orderByPermission: OrderBy.antiguo,
    orderByRole: OrderBy.antiguo,
    orderByUser: OrderBy.antiguo,
  );
});

final searchManagerUserProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final selectItemsUMProvider = StateProvider<bool>((ref) => false);
final selectAllItemsUMProvider = StateProvider<bool>((ref) => false);

import 'dart:convert';
import 'dart:math' as math;

import 'package:drift/drift.dart';

class GeneralHelpers {
  static double clampSize(double value,
      {required double min, required double max}) {
    return math.max(min, math.min(value, max));
  }

  static String buildPaginationText({
    required int totalItems,
    required int pageIndex,
    required int pageSize,
    required int currentPageItemCount,
  }) {
    if (totalItems == 0) return "0-0 de 0";
    final start = pageIndex * pageSize - pageSize + 1;
    final end = (pageIndex * pageSize) - (pageSize - currentPageItemCount);
    return "$start-$end de $totalItems";
  }
}

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    return fromDb.isNotEmpty ? List<String>.from(jsonDecode(fromDb)) : [];
  }

  @override
  String toSql(List<String> value) {
    return jsonEncode(value);
  }
}

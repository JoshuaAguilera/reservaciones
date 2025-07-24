import 'dart:convert';
import 'dart:math' as math;

import 'package:drift/drift.dart';

class GeneralHelpers {
  static double clampSize(double value,
      {required double min, required double max}) {
    return math.max(min, math.min(value, max));
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

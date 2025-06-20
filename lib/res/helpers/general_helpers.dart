import 'dart:convert';

import 'package:drift/drift.dart';

class GeneralHelpers {}

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

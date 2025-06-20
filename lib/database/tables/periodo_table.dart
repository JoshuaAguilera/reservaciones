import 'package:drift/drift.dart';

import '../../res/helpers/general_helpers.dart';
import 'tarifa_rack_table.dart';

class PeriodoTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime).nullable()();
  DateTimeColumn get fechaInicial => dateTime().nullable()();
  DateTimeColumn get fechaFinal => dateTime().nullable()();
  TextColumn get diasActivo => text().map(const StringListConverter())();
  IntColumn get tarifaRackInt =>
      integer().nullable().references(TarifaRackTable, #id)();
  TextColumn get tarifaRack => text().nullable()();
}

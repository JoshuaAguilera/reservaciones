import 'package:drift/drift.dart';
import 'package:generador_formato/database/tables/cotizacion_table.dart';

import '../../res/helpers/general_helpers.dart';
import 'usuario_table.dart';

class ReservacionTable extends Table {
  IntColumn get idInt => integer().autoIncrement()();
  TextColumn get id => text().nullable()();
  IntColumn get cotIntId =>
      integer().nullable().references(CotizacionTable, #id)();
  TextColumn get cotizacion => text().nullable()();
  TextColumn get sku => text().nullable()();
  TextColumn get folio => text().nullable()();
  TextColumn get estatus => text().nullable()();
  TextColumn get reservacionZabiaId => text().nullable()();
  TextColumn get brazaletes => text().map(const StringListConverter())();
  IntColumn get creadoPorInt =>
      integer().nullable().references(UsuarioTable, #id)();
  TextColumn get creadoPor => text().nullable()();
}

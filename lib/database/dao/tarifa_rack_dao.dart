import 'package:drift/drift.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/database/tables/tarifa_rack_table.dart';

part 'tarifa_rack_dao.g.dart';

@DriftAccessor(tables: [TarifaRack])
class TarifaRackDao extends DatabaseAccessor<AppDatabase>
    with _$TarifaRackDaoMixin {
  TarifaRackDao(AppDatabase db) : super(db);

  
}

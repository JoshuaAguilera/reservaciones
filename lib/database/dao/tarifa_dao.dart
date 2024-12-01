import 'package:drift/drift.dart';
import 'package:generador_formato/database/database.dart';
import '../tables/tarifa_table.dart';

part 'tarifa_dao.g.dart';

@DriftAccessor(tables: [Tarifa])
class TarifaDao extends DatabaseAccessor<AppDatabase> with _$TarifaDaoMixin {
  TarifaDao(AppDatabase db) : super(db);

  Future<int> updateForBaseTariff({
    required TarifaCompanion tarifaData,
    required int baseTariffId,
    required int id,
  }) {
    return (update(tarifa)
          ..where((tbl) => tbl.tarifaPadreId.equals(baseTariffId))
          ..where((tbl) => tbl.id.equals(id)))
        .write(tarifaData);
  }

  Future<int> removeBaseTariff(int tarifaBaseId) {
    return (update(tarifa)..where((t) => t.tarifaPadreId.equals(tarifaBaseId)))
        .write(
      const TarifaCompanion(
        tarifaPadreId: Value(null),
      ),
    );
  }
}

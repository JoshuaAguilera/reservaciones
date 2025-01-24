import 'package:drift/drift.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/tarifa_model.dart' as tf;
import '../tables/tarifa_table.dart';

part 'tarifa_dao.g.dart';

@DriftAccessor(tables: [Tarifa])
class TarifaDao extends DatabaseAccessor<AppDatabase> with _$TarifaDaoMixin {
  TarifaDao(AppDatabase db) : super(db);

  Future<List<tf.Tarifa>> getTarifasByCode(String code) async {
    List<tf.Tarifa> tarifas = [];

    List<TarifaData> response =
        await (select(tarifa)..where((tbl) => tbl.code.equals(code))).get();

    for (var element in response) {
      tf.Tarifa tariff = tf.Tarifa(id: element.id);
      tariff.categoria = element.categoria;
      tariff.code = element.code;
      tariff.fecha = element.fecha?.toIso8601String();
      tariff.tarifaAdulto1a2 = element.tarifaAdultoSGLoDBL;
      tariff.tarifaAdulto3 = element.tarifaAdultoTPL;
      tariff.tarifaAdulto4 = element.tarifaAdultoCPLE;
      tariff.tarifaBaseId = element.tarifaPadreId;
      tariff.tarifaMenores7a12 = element.tarifaMenores7a12;
      tariff.tarifaPaxAdicional = element.tarifaPaxAdicional;
      tarifas.add(tariff);
    }

    return tarifas;
  }

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

   Future<int> updateForBaseTariffObject({
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
      const TarifaCompanion(tarifaPadreId: Value(null)),
    );
  }

  Future<int> deleteByCode(String codeRackTariff) {
    return (delete(tarifa)..where((t) => t.code.equals(codeRackTariff))).go();
  }
}

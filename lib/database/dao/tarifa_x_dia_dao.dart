import 'package:drift/drift.dart';

import '../../models/tarifa_rack_model.dart';
import '../../models/tarifa_x_dia_model.dart';
import '../database.dart';
import '../tables/tarifa_x_dia_table.dart';

part 'tarifa_x_dia_dao.g.dart';

@DriftAccessor(tables: [TarifaXDiaTable])
class TarifaXDiaDao extends DatabaseAccessor<AppDatabase>
    with _$TarifaXDiaDaoMixin {
  TarifaXDiaDao(AppDatabase db) : super(db);

  // LIST
  Future<List<TarifaXDia>> getList({
    int? tarifaRackId,
    int limit = 20,
    int page = 1,
    bool conDetalle = false,
  }) async {
    final rackAlias = alias(db.tarifaRackTable, 'rack');

    final query = select(db.tarifaXDiaTable).join([
      if (conDetalle)
        leftOuterJoin(
          rackAlias,
          rackAlias.idInt.equalsExp(db.tarifaXDiaTable.tarifaRackInt),
        ),
    ]);

    if (tarifaRackId != null) {
      query.where(db.tarifaXDiaTable.tarifaRackInt.equals(tarifaRackId));
    }

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final rows = await query.get();

    return rows.map(
      (row) {
        final tarDia = row.readTable(db.tarifaXDiaTable);
        final rack = row.readTableOrNull(rackAlias);

        return TarifaXDia(
          idInt: tarDia.idInt,
          id: tarDia.id,
          descIntegrado: tarDia.descIntegrado,
          esLibre: tarDia.esLibre,
          tarifaRackJson: tarDia.tarifaRackJson,
          tarifaRack: TarifaRack.fromJson(
            rack?.toJson() ?? <String, dynamic>{},
          ),
        );
      },
    ).toList();
  }

  // CREATE
  Future<int> insert(TarifaXDia tarifa) {
    return into(db.tarifaXDiaTable).insert(
      TarifaXDiaTableData.fromJson(
        tarifa.toJson(),
      ),
    );
  }

  // READ: TarifaXDia por ID
  Future<TarifaXDia?> getByID(int id) async {
    final rackAlias = alias(db.tarifaRackTable, 'rack');

    final query = select(db.tarifaXDiaTable).join([
      leftOuterJoin(
        rackAlias,
        rackAlias.idInt.equalsExp(db.tarifaXDiaTable.tarifaRackInt),
      ),
    ]);

    query.where(db.tarifaXDiaTable.idInt.equals(id));

    var row = await query.getSingleOrNull();
    if (row == null) return null;

    final tarDia = row.readTable(db.tarifaXDiaTable);
    final rack = row.readTableOrNull(rackAlias);

    return TarifaXDia(
      idInt: tarDia.idInt,
      id: tarDia.id,
      descIntegrado: tarDia.descIntegrado,
      esLibre: tarDia.esLibre,
      tarifaRackJson: tarDia.tarifaRackJson,
      tarifaRack: TarifaRack.fromJson(
        rack?.toJson() ?? <String, dynamic>{},
      ),
    );
  }

  // UPDATE
  Future<bool> updat3(TarifaXDia tarifa) {
    var response = update(db.tarifaXDiaTable).replace(
      TarifaXDiaTableData.fromJson(
        tarifa.toJson(),
      ),
    );

    return response;
  }

  // DELETE
  Future<int> delet3(int id) {
    var response = (delete(db.tarifaXDiaTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .go();

    return response;
  }
}

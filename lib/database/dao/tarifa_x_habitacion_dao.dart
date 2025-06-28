import 'package:drift/drift.dart';

import '../../models/tarifa_x_dia_model.dart';
import '../../models/tarifa_x_habitacion_model.dart';
import '../database.dart';
import '../tables/tarifa_x_habitacion_table.dart';

part 'tarifa_x_habitacion_dao.g.dart';

@DriftAccessor(tables: [TarifaXHabitacionTable])
class TarifaXHabitacionDao extends DatabaseAccessor<AppDatabase>
    with _$TarifaXHabitacionDaoMixin {
  TarifaXHabitacionDao(AppDatabase db) : super(db);

  // LIST
  Future<List<TarifaXHabitacion>> getList({
    int? habitacionId,
    int limit = 20,
    int page = 1,
    bool conDetalle = false,
  }) async {
    final tarifaAlias = alias(db.tarifaXDiaTable, 'tarifa');

    final query = select(db.tarifaXHabitacionTable).join([
      if (conDetalle)
        leftOuterJoin(
          tarifaAlias,
          tarifaAlias.idInt.equalsExp(db.tarifaXHabitacionTable.tarifaXDiaInt),
        ),
    ]);

    if (habitacionId != null) {
      query.where(db.tarifaXHabitacionTable.habitacionInt.equals(habitacionId));
    }

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final rows = await query.get();

    return rows.map(
      (row) {
        final tarHab = row.readTable(db.tarifaXHabitacionTable);
        final tarDia = row.readTableOrNull(tarifaAlias);

        return TarifaXHabitacion(
          idInt: tarHab.idInt,
          id: tarHab.id,
          dia: tarHab.dia,
          esGrupal: tarHab.esGrupal,
          fecha: tarHab.fecha,
          habitacion: tarHab.habitacion,
          habitacionInt: tarHab.habitacionInt,
          tarifaXDia: TarifaXDia.fromJson(
            tarDia?.toJson() ?? <String, dynamic>{},
          ),
        );
      },
    ).toList();
  }

  // CREATE
  Future<int> insert(TarifaXHabitacion tarifas) {
    return into(db.tarifaXHabitacionTable).insert(
      TarifaXHabitacionTableData.fromJson(
        tarifas.toJson(),
      ),
    );
  }

  // READ: TarifaXHabitacion por ID
  Future<TarifaXHabitacion?> getByID(int id) async {
    final tarifaAlias = alias(db.tarifaXDiaTable, 'tarifa');

    final query = select(db.tarifaXHabitacionTable).join([
      leftOuterJoin(
        tarifaAlias,
        tarifaAlias.idInt.equalsExp(db.tarifaXHabitacionTable.tarifaXDiaInt),
      ),
    ]);

    query.where(db.tarifaXHabitacionTable.idInt.equals(id));

    var row = await query.getSingleOrNull();
    if (row == null) return null;

    final tarHab = row.readTable(db.tarifaXHabitacionTable);
    final tarDia = row.readTableOrNull(tarifaAlias);

    return TarifaXHabitacion(
      idInt: tarHab.idInt,
      id: tarHab.id,
      dia: tarHab.dia,
      esGrupal: tarHab.esGrupal,
      fecha: tarHab.fecha,
      habitacion: tarHab.habitacion,
      habitacionInt: tarHab.habitacionInt,
      tarifaXDia: TarifaXDia.fromJson(
        tarDia?.toJson() ?? <String, dynamic>{},
      ),
    );
  }

  // UPDATE
  Future<bool> updat3(TarifaXHabitacion tarifa) {
    var response = update(db.tarifaXHabitacionTable).replace(
      TarifaXHabitacionTableData.fromJson(
        tarifa.toJson(),
      ),
    );

    return response;
  }

  // DELETE
  Future<int> delet3(int id) {
    var response = (delete(db.tarifaXHabitacionTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .go();

    return response;
  }
}

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
          subcode: tarHab.subcode,
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
  Future<TarifaXHabitacion?> insert(TarifaXHabitacion tarifas) async {
    final response =
        await into(db.tarifaXHabitacionTable).insertReturningOrNull(
      TarifaXHabitacionTableData.fromJson(
        tarifas.toJson(),
      ),
    );

    if (response == null) return null;
    final newRateRoom = TarifaXHabitacion.fromJson(response.toJson());
    return newRateRoom;
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
      subcode: tarHab.subcode,
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
  Future<TarifaXHabitacion?> updat3(TarifaXHabitacion tarifa) async {
    var response = await update(db.tarifaXHabitacionTable).replace(
      TarifaXHabitacionTableData.fromJson(
        tarifa.toJson(),
      ),
    );

    if (!response) return null;
    return await getByID(tarifa.idInt ?? 0);
  }

  // SAVE
  Future<TarifaXHabitacion?> save(TarifaXHabitacion tarifa) async {
    if (tarifa.idInt != null && tarifa.idInt! > 0) {
      return await updat3(tarifa);
    } else {
      return await insert(tarifa);
    }
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

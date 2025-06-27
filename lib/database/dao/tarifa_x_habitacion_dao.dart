import 'package:drift/drift.dart';

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
  }) async {
    final query = select(db.tarifaXHabitacionTable);

    if (habitacionId != null) {
      query.where((u) => u.habitacionInt.equals(habitacionId));
    }

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final response = await query.get();

    return response.map(
      (e) {
        TarifaXHabitacion newRate = TarifaXHabitacion.fromJson(e.toJson());
        return newRate;
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
    var response = await (select(db.tarifaXHabitacionTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .getSingleOrNull();

    if (response == null) return null;
    var tarifa = TarifaXHabitacion.fromJson(response.toJson());
    return tarifa;
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

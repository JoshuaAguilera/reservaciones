import 'package:drift/drift.dart';

import '../../models/registro_tarifa_bd_model.dart';
import '../database.dart';
import '../tables/tarifa_table.dart';
import 'tarifa_dao.dart';

part 'registro_tarifa_dao.g.dart';

@DriftAccessor(tables: [RegistroTarifaTable])
class RegistroTarifaDao extends DatabaseAccessor<AppDatabase>
    with _$RegistroTarifaDaoMixin {
  RegistroTarifaDao(AppDatabase db) : super(db);

  // LIST
  Future<List<RegistroTarifaBD>> getList({
    int? tarifaId,
    int? tarifaRackId,
    int limit = 20,
    int page = 1,
    bool conDetalle = false,
  }) async {
    final query = select(db.registroTarifaTable);

    if (tarifaId != null) {
      query.where((tbl) => tbl.tarifaInt.equals(tarifaId));
    }

    if (tarifaRackId != null) {
      query.where((tbl) => tbl.tarifaRackInt.equals(tarifaRackId));
    }

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final data = await query.get();

    data.map(
      (e) async {
        RegistroTarifaBD register = RegistroTarifaBD.fromJson(e.toJson());
        if (conDetalle) {
          final tarifaDao = TarifaDao(db);
          register.tarifa = await tarifaDao.getByID(e.tarifaInt ?? 0);
        }

        return register;
      },
    ).toList();

    return data.map((e) => RegistroTarifaBD.fromJson(e.toJson())).toList();
  }

  // CREATE
  Future<RegistroTarifaBD?> insert(RegistroTarifaBD registro) async {
    final response = await into(db.registroTarifaTable).insertReturningOrNull(
      RegistroTarifaTableData.fromJson(
        registro.toJson(),
      ),
    );

    if (response == null) return null;
    return RegistroTarifaBD.fromJson(response.toJson());
  }

  // READ: RegistroTarifa por ID
  Future<RegistroTarifaBD?> getByID(int id) async {
    final response = await (select(db.registroTarifaTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .getSingleOrNull();

    if (response == null) return null;
    final registro = RegistroTarifaBD.fromJson(response.toJson());
    if (response.tarifaInt != null) {
      final tarifaDao = TarifaDao(db);
      registro.tarifa = await tarifaDao.getByID(response.tarifaInt ?? 0);
    }
    return registro;
  }

  // UPDATE
  Future<RegistroTarifaBD?> updat3(RegistroTarifaBD registro) async {
    final response = await update(db.registroTarifaTable).replace(
      RegistroTarifaTableData.fromJson(
        registro.toJson(),
      ),
    );

    if (!response) return null;
    return await getByID(registro.idInt ?? 0);
  }

  // SAVE
  Future<RegistroTarifaBD?> save(RegistroTarifaBD registro) async {
    if (registro.idInt == null) {
      return await insert(registro);
    } else {
      return await updat3(registro);
    }
  }

  // DELETE
  Future<int> delet3(int id) {
    var response = (delete(db.registroTarifaTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .go();

    return response;
  }
}

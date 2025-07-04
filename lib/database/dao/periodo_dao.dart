import 'package:drift/drift.dart';

import '../../models/periodo_model.dart';
import '../database.dart';
import '../tables/periodo_table.dart';

part 'periodo_dao.g.dart';

@DriftAccessor(tables: [PeriodoTable])
class PeriodoDao extends DatabaseAccessor<AppDatabase> with _$PeriodoDaoMixin {
  PeriodoDao(AppDatabase db) : super(db);

  // LIST
  Future<List<Periodo>> getList({
    int? tarifaRackId,
    int limit = 20,
    int page = 1,
  }) async {
    final query = select(db.periodoTable);

    if (tarifaRackId != null) {
      query.where((u) => u.tarifaRackInt.equals(tarifaRackId));
    }

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final data = await query.get();

    return data.map(
      (e) {
        Periodo period = Periodo.fromJson(e.toJson());
        return period;
      },
    ).toList();
  }

  // CREATE
  Future<Periodo?> insert(Periodo periodo) async {
    var response = await into(db.periodoTable).insertReturningOrNull(
      PeriodoTableData.fromJson(
        periodo.toJson(),
      ),
    );
    if (response == null) return null;
    final newPeriod = Periodo.fromJson(response.toJson());
    return newPeriod;
  }

  // READ: Periodo por ID
  Future<Periodo?> getByID(int id) async {
    var response = await (select(db.periodoTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .getSingleOrNull();

    return Periodo?.fromJson(response?.toJson() ?? <String, dynamic>{});
  }

  // UPDATE
  Future<Periodo?> updat3(Periodo periodo) async {
    var response = await update(db.periodoTable).replace(
      PeriodoTableData.fromJson(
        periodo.toJson(),
      ),
    );

    if (!response) return null;
    return await getByID(periodo.idInt ?? 0);
  }

  // SAVE
  Future<Periodo?> save(Periodo periodo) async {
    if (periodo.idInt == null || periodo.idInt == 0) {
      return await insert(periodo);
    } else {
      return await updat3(periodo);
    }
  }

  // DELETE
  Future<int> delet3(int id) {
    var response = (delete(db.periodoTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .go();

    return response;
  }
}

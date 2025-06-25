import 'package:drift/drift.dart';

import '../../models/habitacion_model.dart';
import '../database.dart';
import '../tables/habitacion_table.dart';

part 'habitacion_dao.g.dart';

@DriftAccessor(tables: [HabitacionTable])
class HabitacionDao extends DatabaseAccessor<AppDatabase>
    with _$HabitacionDaoMixin {
  HabitacionDao(AppDatabase db) : super(db);

  // LIST
  Future<List<Habitacion>> getList({
    int? cotizacionId,
    DateTime? initDate,
    DateTime? lastDate,
    String? sortBy,
    String order = 'asc',
    int limit = 20,
    int page = 1,
  }) async {
    final query = select(db.habitacionTable);

    if (cotizacionId != null) {
      query.where((u) => u.cotizacionInt.equals(cotizacionId));
    }

    if (initDate != null) {
      query.where((u) => u.createdAt.isBiggerOrEqualValue(initDate));
    }

    if (lastDate != null) {
      query.where((u) => u.createdAt.isSmallerOrEqualValue(lastDate));
    }

    if (initDate != null && lastDate != null) {
      query.where(
        (tbl) => tbl.createdAt.isBetweenValues(initDate, lastDate),
      );
    }

    OrderingTerm? ordering;

    switch (sortBy) {
      case 'createdAt':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.habitacionTable.createdAt)
            : OrderingTerm.asc(db.habitacionTable.createdAt);
        break;
      default:
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.habitacionTable.id)
            : OrderingTerm.asc(db.habitacionTable.id);
    }

    query.orderBy([(_) => ordering!]);

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final response = await query.get();

    return response.map(
      (e) {
        Habitacion newHab = Habitacion.fromJson(e.toJson());
        return newHab;
      },
    ).toList();
  }

  // CREATE
  Future<int> insert(ClienteTableCompanion cliente) {
    return into(db.clienteTable).insert(cliente);
  }

  // READ: Habitacion por ID
  Future<ClienteTableData?> getByID(int id) {
    var response = (select(db.clienteTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .getSingleOrNull();

    return response;
  }

  // UPDATE
  Future<bool> updat3(ClienteTableData cliente) {
    var response = update(db.clienteTable).replace(cliente);

    return response;
  }

  // DELETE
  Future<int> delet3(int id) {
    var response = (delete(db.clienteTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .go();

    return response;
  }
}

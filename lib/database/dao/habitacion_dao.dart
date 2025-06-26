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
    String sortBy = 'created_at',
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
      case 'created_at':
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
  Future<int> insert(Habitacion habitacion) {
    return into(db.habitacionTable).insert(
      HabitacionTableData.fromJson(
        habitacion.toJson(),
      ),
    );
  }

  // READ: Habitacion por ID
  Future<Habitacion?> getByID(int id) async {
    var response = await (select(db.habitacionTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .getSingleOrNull();

    if (response == null) return null;
    var room = Habitacion.fromJson(response.toJson());
    return room;
  }

  // UPDATE
  Future<bool> updat3(Habitacion habitacion) {
    var response = update(db.habitacionTable).replace(
      HabitacionTableData.fromJson(
        habitacion.toJson(),
      ),
    );

    return response;
  }

  // DELETE
  Future<int> delet3(int id) {
    var response = (delete(db.habitacionTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .go();

    return response;
  }
}

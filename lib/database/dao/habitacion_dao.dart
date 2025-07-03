import 'package:drift/drift.dart';

import '../../models/habitacion_model.dart';
import '../../models/resumen_operacion_model.dart';
import '../../models/tarifa_x_habitacion_model.dart';
import '../database.dart';
import '../tables/habitacion_table.dart';
import 'resumen_operacion_dao.dart';
import 'tarifa_x_habitacion_dao.dart';

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
    DateTime? initTime,
    DateTime? lastTime,
    String sortBy = 'created_at',
    String orderBy = 'asc',
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
        ordering = orderBy == 'desc'
            ? OrderingTerm.desc(db.habitacionTable.createdAt)
            : OrderingTerm.asc(db.habitacionTable.createdAt);
        break;
      default:
        ordering = orderBy == 'desc'
            ? OrderingTerm.desc(db.habitacionTable.idInt)
            : OrderingTerm.asc(db.habitacionTable.idInt);
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
  Future<Habitacion?> insert(Habitacion habitacion) async {
    final response = await into(db.habitacionTable).insertReturningOrNull(
      HabitacionTableData.fromJson(
        habitacion.toJson(),
      ),
    );

    if (response == null) return null;
    Habitacion newRoom = Habitacion.fromJson(response.toJson());
    return newRoom;
  }

  // READ: Habitacion por ID
  Future<Habitacion?> getByID(int id) async {
    var response = await (select(db.habitacionTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .getSingleOrNull();

    if (response == null) return null;
    Habitacion room = Habitacion.fromJson(response.toJson());

    List<TarifaXHabitacion> tarifas = [];
    List<ResumenOperacion> resumenes = [];
    final tarHabDao = TarifaXHabitacionDao(db);
    final resDao = ResumenOperacionDao(db);

    tarifas = await tarHabDao.getList(
      habitacionId: room.idInt,
      conDetalle: true,
      limit: 100,
    );
    resumenes = await resDao.getList(habitacionId: room.idInt, limit: 100);
    room.tarifasXHabitacion = tarifas;
    room.resumenes = resumenes;

    return room;
  }

  // UPDATE
  Future<Habitacion?> updat3(Habitacion habitacion) async {
    var response = await update(db.habitacionTable).replace(
      HabitacionTableData.fromJson(
        habitacion.toJson(),
      ),
    );

    if (!response) return null;
    return await getByID(habitacion.idInt ?? 0);
  }

  // SAVE
  Future<Habitacion?> save(Habitacion habitacion) async {
    if (habitacion.idInt != null && habitacion.idInt! > 0) {
      return await updat3(habitacion);
    } else {
      return await insert(habitacion);
    }
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

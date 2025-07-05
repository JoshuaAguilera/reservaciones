import 'package:drift/drift.dart';

import '../../models/rol_model.dart';
import '../database.dart';
import '../tables/rol_table.dart';

part 'rol_dao.g.dart';

@DriftAccessor(tables: [RolTable])
class RolDao extends DatabaseAccessor<AppDatabase> with _$RolDaoMixin {
  RolDao(AppDatabase db) : super(db);

  // LIST
  Future<List<Rol>> getList({
    String nombre = '',
    DateTime? initDate,
    DateTime? lastDate,
    String? sortBy,
    String order = 'asc',
    int limit = 20,
    int page = 1,
  }) async {
    final query = select(db.rolTable);

    if (nombre.isNotEmpty) {
      final value = '%${nombre.toLowerCase()}%';
      query.where((tbl) => tbl.nombre.lower().like(value));
    }

    if (initDate != null) {
      query.where((tbl) => tbl.createdAt.isBiggerOrEqualValue(initDate));
    }

    if (lastDate != null) {
      query.where((tbl) => tbl.createdAt.isSmallerOrEqualValue(lastDate));
    }

    if (initDate != null && lastDate != null) {
      query.where(
        (tbl) => tbl.createdAt.isBetweenValues(initDate, lastDate),
      );
    }

    OrderingTerm? ordering;

    switch (sortBy) {
      case 'nombre':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.rolTable.nombre)
            : OrderingTerm.asc(db.rolTable.nombre);
        break;
      case 'createdAt':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.rolTable.createdAt)
            : OrderingTerm.asc(db.rolTable.createdAt);
        break;
      default:
        ordering = OrderingTerm.asc(db.rolTable.createdAt);
    }

    query.orderBy([(_) => ordering!]);

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final data = await query.get();

    return data.map((e) => Rol.fromJson(e.toJson())).toList();
  }

  // CREATE
  Future<Rol?> insert(Rol rol) async {
    final id = await into(db.rolTable)
        .insertReturningOrNull(RolTableData.fromJson(rol.toJson()));

    if (id == null) return null;
    Rol newRol = Rol.fromJson(rol.toJson());
    return newRol;
  }

  // READ: Resumen Operacion por ID
  Future<Rol?> getByID(int id) async {
    final query = select(db.rolTable)..where((u) => u.idInt.equals(id));
    final data = await query.getSingleOrNull();

    if (data == null) return null;
    return Rol.fromJson(data.toJson());
  }

  // UPDATE
  Future<Rol?> updat3(Rol rol) async {
    var response = await update(db.rolTable).replace(
      RolTableData.fromJson(rol.toJson()),
    );

    if (!response) return null;
    return await getByID(rol.idInt ?? 0);
  }

  // SAVE
  Future<Rol?> save(Rol rol) async {
    if (rol.idInt == null || rol.idInt == 0) {
      return await insert(rol);
    } else {
      return await updat3(rol);
    }
  }

  // DELETE
  Future<int> delet3(int id) {
    var response = (delete(db.resumenOperacionTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .go();

    return response;
  }
}

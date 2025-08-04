import 'package:drift/drift.dart';

import '../../models/tipo_habitacion_model.dart';
import '../database.dart';
import '../tables/tipo_habitacion_table.dart';

part 'tipo_hab_dao.g.dart';

@DriftAccessor(tables: [TipoHabitacionTable])
class TipoHabitacionDao extends DatabaseAccessor<AppDatabase>
    with _$TipoHabitacionDaoMixin {
  TipoHabitacionDao(AppDatabase db) : super(db);

  var mapEmpty = <String, dynamic>{};

  Future<int> count() async {
    final query = selectOnly(db.tipoHabitacionTable)
      ..addColumns([db.tipoHabitacionTable.idInt.count()]);

    final result = await query.getSingleOrNull();
    if (result == null) return 0;
    return result.read(db.tipoHabitacionTable.idInt.count()) ?? 0;
  }

  // LIST
  Future<List<TipoHabitacion>> getList({
    String descripcion = '',
    String codigo = '',
    DateTime? initDate,
    DateTime? lastDate,
    String? sortBy,
    String order = 'asc',
    int limit = 20,
    int page = 1,
  }) async {
    final query = select(db.tipoHabitacionTable);

    if (codigo.isNotEmpty) {
      final value = '%${codigo.toLowerCase()}%';
      query.where((tbl) => tbl.codigo.lower().like(value));
    }

    if (descripcion.isNotEmpty) {
      final value = '%${descripcion.toLowerCase()}%';
      query.where((tbl) => tbl.descripcion.lower().like(value));
    }

    if (initDate != null) {
      query.where((u) => u.createdAt.isBiggerOrEqualValue(initDate));
    }

    if (lastDate != null) {
      query.where((u) => u.createdAt.isSmallerOrEqualValue(lastDate));
    }

    if (initDate != null && lastDate != null) {
      query.where((u) => u.createdAt.isBetweenValues(initDate, lastDate));
    }

    OrderingTerm? ordering;

    switch (sortBy) {
      case 'nombre':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.categoriaTable.nombre)
            : OrderingTerm.asc(db.categoriaTable.nombre);
        break;
      case 'createdAt':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.categoriaTable.createdAt)
            : OrderingTerm.asc(db.categoriaTable.createdAt);
        break;
      default:
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.categoriaTable.idInt)
            : OrderingTerm.asc(db.categoriaTable.idInt);
    }

    query.orderBy([(_) => ordering!]);

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final data = await query.get();
    return data.map(
      (e) {
        TipoHabitacion tipoHab = TipoHabitacion.fromJson(e.toJson());
        return tipoHab;
      },
    ).toList();
  }

  // CREATE
  Future<TipoHabitacion?> insert(
      TipoHabitacionTableCompanion tipoHabitacion) async {
    var response = await into(db.tipoHabitacionTable)
        .insertReturningOrNull(tipoHabitacion);

    if (response == null) return null;
    return TipoHabitacion.fromJson(response.toJson());
  }

  // READ: Categoria por ID
  Future<TipoHabitacion?> getByID(int id) async {
    var response = await (select(db.tipoHabitacionTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .getSingleOrNull();

    return TipoHabitacion?.fromJson(response?.toJson() ?? <String, dynamic>{});
  }

  // UPDATE
  Future<TipoHabitacion?> updat3(
      TipoHabitacionTableCompanion tipoHabitacion) async {
    var response = await update(db.tipoHabitacionTable).replace(tipoHabitacion);

    if (!response) return null;
    return await getByID(tipoHabitacion.idInt.value);
  }

  // SAVE
  Future<TipoHabitacion?> save(TipoHabitacion tipoHabitacion) async {
    final type = TipoHabitacionTableCompanion(
      idInt: tipoHabitacion.idInt != null
          ? Value(tipoHabitacion.idInt!)
          : const Value.absent(),
      id: Value(tipoHabitacion.id),
      descripcion: Value(tipoHabitacion.descripcion),
      codigo: Value(tipoHabitacion.codigo),
      camas: Value(tipoHabitacion.camas),
      orden: Value(tipoHabitacion.orden),
    );

    if (tipoHabitacion.idInt == null) {
      return await insert(type);
    } else {
      return await updat3(type);
    }
  }

  // DELETE
  Future<int> delet3(int id) {
    var response = (delete(db.tipoHabitacionTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .go();

    return response;
  }
}

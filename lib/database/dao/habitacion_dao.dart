import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/habitacion_table.dart';

part 'habitacion_dao.g.dart';

@DriftAccessor(tables: [HabitacionTable])
class HabitacionDao extends DatabaseAccessor<AppDatabase>
    with _$HabitacionDaoMixin {
  HabitacionDao(AppDatabase db) : super(db);

  // LIST
  Future<List<HabitacionTableData>> getList({
    int? cotizacionId,
    DateTime? initDate,
    DateTime? lastDate,
    String? sortBy,
    String order = 'asc',
    int limit = 20,
    int page = 1,
  }) {
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

    OrderingTerm? ordering;

    switch (sortBy) {
      case 'nombre':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.clienteTable.nombre)
            : OrderingTerm.asc(db.clienteTable.nombre);
        break;
      case 'correo':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.clienteTable.correoElectronico)
            : OrderingTerm.asc(db.clienteTable.correoElectronico);
        break;
      case 'createdAt':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.clienteTable.createdAt)
            : OrderingTerm.asc(db.clienteTable.createdAt);
        break;
      default:
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.clienteTable.id)
            : OrderingTerm.asc(db.clienteTable.id);
    }

    query.orderBy([(_) => ordering!]);

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    return query.get();
  }

  // CREATE
  Future<int> insert(ClienteTableCompanion cliente) {
    return into(db.clienteTable).insert(cliente);
  }

  // READ: Usuario por ID
  Future<ClienteTableData?> getByID(int id) {
    var response = (select(db.clienteTable)
          ..where((u) {
            return u.id.equals(id);
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
            return u.id.equals(id);
          }))
        .go();

    return response;
  }
}

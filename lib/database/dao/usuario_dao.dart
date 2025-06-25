import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/usuario_table.dart';

part 'usuario_dao.g.dart';

@DriftAccessor(tables: [UsuarioTable])
class UsuarioDao extends DatabaseAccessor<AppDatabase> with _$UsuarioDaoMixin {
  UsuarioDao(AppDatabase db) : super(db);

  // LIST
  Future<List<UsuarioTableData>> getList({
    String username = '',
    String correo = '',
    int? id,
    String estatus = 'registrado',
    DateTime? initDate,
    DateTime? lastDate,
    String? sortBy,
    String order = 'asc',
    int limit = 20,
    int page = 1,
  }) {
    final query = select(db.usuarioTable);

    if (username.isNotEmpty) {
      query.where((u) => u.username.like('%$username%'));
    }

    if (id != null) {
      query.where((u) => u.idInt.equals(id));
    }

    if (correo.isNotEmpty) {
      query.where((u) => u.correoElectronico.like('%$correo%'));
    }

    if (estatus.isNotEmpty) {
      query.where((u) => u.estatus.like('%$estatus%'));
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
            ? OrderingTerm.desc(db.usuarioTable.nombre)
            : OrderingTerm.asc(db.usuarioTable.nombre);
        break;
      case 'correo':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.usuarioTable.correoElectronico)
            : OrderingTerm.asc(db.usuarioTable.correoElectronico);
        break;
      case 'createdAt':
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.usuarioTable.createdAt)
            : OrderingTerm.asc(db.usuarioTable.createdAt);
        break;
      default:
        ordering = order == 'desc'
            ? OrderingTerm.desc(db.usuarioTable.id)
            : OrderingTerm.asc(db.usuarioTable.id);
    }

    query.orderBy([(_) => ordering!]);

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    return query.get();
  }

  // CREATE
  Future<int> insert(UsuarioTableCompanion usuario) {
    return into(db.usuarioTable).insert(usuario);
  }

  // READ: Usuario por ID
  Future<UsuarioTableData?> getByID(int id) {
    var response = (select(db.usuarioTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .getSingleOrNull();

    return response;
  }

  // UPDATE
  Future<bool> updat3(UsuarioTableData usuario) {
    var response = update(db.usuarioTable).replace(usuario);

    return response;
  }

  // DELETE
  Future<int> delet3(int id) {
    var response = (delete(db.usuarioTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .go();

    return response;
  }
}

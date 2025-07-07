import 'package:drift/drift.dart';

import '../../models/notificacion_model.dart';
import '../../models/usuario_model.dart';
import '../database.dart';
import '../tables/notificacion_table.dart';

part 'notificacion_dao.g.dart';

@DriftAccessor(tables: [NotificacionTable])
class NotificacionDao extends DatabaseAccessor<AppDatabase>
    with _$NotificacionDaoMixin {
  NotificacionDao(AppDatabase db) : super(db);

  var mapEmpty = <String, dynamic>{};

  // LIST
  Future<List<Notificacion>> getList({
    String tipo = '',
    String documento = '',
    int? idUsuario,
    String estatus = '',
    DateTime? initDate,
    DateTime? lastDate,
    String sortBy = 'created_at',
    String orderBy = 'asc',
    int limit = 20,
    int page = 1,
    bool conDetalle = false,
  }) async {
    final usuarioAlias = alias(db.usuarioTable, 'usuario');
    final query = select(db.notificacionTable).join([
      if (conDetalle)
        leftOuterJoin(
          usuarioAlias,
          usuarioAlias.idInt.equalsExp(db.notificacionTable.usuarioInt),
        ),
    ]);

    if (tipo.isNotEmpty) {
      final value = '%${tipo.toLowerCase()}%';
      query.where(db.notificacionTable.tipo.lower().like(value));
    }

    if (documento.isNotEmpty) {
      final value = '%${documento.toLowerCase()}%';
      query.where(db.notificacionTable.documento.lower().like(value));
    }

    if (idUsuario != null) {
      query.where(db.notificacionTable.usuarioInt.equals(idUsuario));
    }

    if (estatus.isNotEmpty) {
      final value = '%${estatus.toLowerCase()}%';
      query.where(db.notificacionTable.estatus.lower().like(value));
    }

    if (initDate != null) {
      query
          .where(db.notificacionTable.createdAt.isBiggerOrEqualValue(initDate));
    }

    if (lastDate != null) {
      query.where(
          db.notificacionTable.createdAt.isSmallerOrEqualValue(lastDate));
    }

    if (initDate != null && lastDate != null) {
      query.where(
        db.notificacionTable.createdAt.isBetweenValues(initDate, lastDate),
      );
    }
    OrderingTerm? ordering;

    switch (sortBy) {
      case 'tipo':
        ordering = orderBy == 'desc'
            ? OrderingTerm.desc(db.notificacionTable.tipo)
            : OrderingTerm.asc(db.notificacionTable.tipo);
        break;
      case 'documento':
        ordering = orderBy == 'desc'
            ? OrderingTerm.desc(db.notificacionTable.documento)
            : OrderingTerm.asc(db.notificacionTable.documento);
        break;
      case 'created_at':
        ordering = orderBy == 'desc'
            ? OrderingTerm.desc(db.notificacionTable.createdAt)
            : OrderingTerm.asc(db.notificacionTable.createdAt);
        break;
      default:
        ordering = orderBy == 'desc'
            ? OrderingTerm.desc(db.notificacionTable.idInt)
            : OrderingTerm.asc(db.notificacionTable.idInt);
    }

    query.orderBy([ordering]);
    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final rows = await query.get();
    return rows.map(
      (row) {
        final notificacion = row.readTable(db.notificacionTable);
        final usuario = row.readTableOrNull(usuarioAlias);
        return Notificacion(
          idInt: notificacion.idInt,
          id: notificacion.id,
          tipo: notificacion.tipo,
          mensaje: notificacion.mensaje,
          // ruta: notificacion.ruta,
          // documento: notificacion.documento,
          // estatus: notificacion.estatus,
          createdAt: notificacion.createdAt,
          usuario: Usuario.fromJson(usuario?.toJson() ?? mapEmpty),
        );
      },
    ).toList();
  }

  // CREATE
  Future<Notificacion?> insert(Notificacion notificacion) async {
    var response = await into(db.notificacionTable).insertReturningOrNull(
      NotificacionTableData.fromJson(
        notificacion.toJson(),
      ),
    );

    if (response == null) return null;
    return Notificacion.fromJson(response.toJson());
  }

  // READ: Notificacion por ID
  Future<Notificacion?> getByID(int id) async {
    final usuarioAlias = alias(db.usuarioTable, 'usuario');
    final query = select(db.notificacionTable).join([
      leftOuterJoin(
        usuarioAlias,
        usuarioAlias.idInt.equalsExp(db.notificacionTable.usuarioInt),
      ),
    ]);

    query.where(db.notificacionTable.idInt.equals(id));
    var row = await query.getSingleOrNull();
    if (row == null) return null;
    final notificacion = row.readTable(db.notificacionTable);
    final usuario = row.readTableOrNull(usuarioAlias);

    return Notificacion(
      idInt: notificacion.idInt,
      id: notificacion.id,
      tipo: notificacion.tipo,
      mensaje: notificacion.mensaje,
      // ruta: notificacion.ruta,
      // documento: notificacion.documento,
      // estatus: notificacion.estatus,
      createdAt: notificacion.createdAt,
      usuario: Usuario.fromJson(usuario?.toJson() ?? mapEmpty),
    );
  }

  // UPDATE
  Future<Notificacion?> updat3(Notificacion notificacion) async {
    var response = await update(db.notificacionTable).replace(
      NotificacionTableData.fromJson(
        notificacion.toJson(),
      ),
    );

    if (!response) return null;
    return await getByID(notificacion.idInt ?? 0);
  }

  // SAVE
  Future<Notificacion?> save(Notificacion notificacion) async {
    if (notificacion.idInt == null) {
      return await insert(notificacion);
    } else {
      return await updat3(notificacion);
    }
  }

  // DELETE
  Future<int> delet3(int id) {
    var response = (delete(db.notificacionTable)
          ..where((u) {
            return u.idInt.equals(id);
          }))
        .go();

    return response;
  }
}

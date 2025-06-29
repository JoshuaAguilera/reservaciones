import 'package:drift/drift.dart';

import '../../models/imagen_model.dart';
import '../../models/rol_model.dart';
import '../../models/usuario_model.dart';
import '../database.dart';
import '../tables/usuario_table.dart';

part 'usuario_dao.g.dart';

@DriftAccessor(tables: [UsuarioTable])
class UsuarioDao extends DatabaseAccessor<AppDatabase> with _$UsuarioDaoMixin {
  UsuarioDao(AppDatabase db) : super(db);

  // LIST
  Future<List<Usuario>> getList({
    String username = '',
    String correo = '',
    String estatus = 'registrado',
    DateTime? initDate,
    DateTime? lastDate,
    String? sortBy,
    String order = 'asc',
    int limit = 20,
    int page = 1,
  }) async {
    final rolAlias = alias(db.rolTable, 'rol');
    final imagenAlias = alias(db.imagenTable, 'image');

    final query = select(db.usuarioTable).join([
      leftOuterJoin(
        rolAlias,
        rolAlias.idInt.equalsExp(db.usuarioTable.rolInt),
      ),
      leftOuterJoin(
        imagenAlias,
        imagenAlias.idInt.equalsExp(db.usuarioTable.imagenInt),
      ),
    ]);

    if (username.isNotEmpty) {
      query.where(usuarioTable.username.like('%$username%'));
    }

    if (correo.isNotEmpty) {
      query.where(usuarioTable.correoElectronico.like('%$correo%'));
    }

    if (estatus.isNotEmpty) {
      query.where(usuarioTable.estatus.like('%$estatus%'));
    }

    if (initDate != null) {
      query.where(usuarioTable.createdAt.isBiggerOrEqualValue(initDate));
    }

    if (lastDate != null) {
      query.where(usuarioTable.createdAt.isSmallerOrEqualValue(lastDate));
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
            ? OrderingTerm.desc(db.usuarioTable.idInt)
            : OrderingTerm.asc(db.usuarioTable.idInt);
    }

    query.orderBy([ordering]);

    final offset = (page - 1) * limit;
    query.limit(limit, offset: offset);

    final rows = await query.get();

    // Mapear resultados con joins
    return rows.map((row) {
      final user = row.readTable(db.usuarioTable);
      final rol = row.readTableOrNull(rolAlias);
      final image = row.readTableOrNull(imagenAlias);

      return Usuario(
        idInt: user.idInt,
        id: user.id,
        estatus: user.estatus,
        createdAt: user.createdAt,
        apellido: user.apellido,
        correoElectronico: user.correoElectronico,
        fechaNacimiento: user.fechaNacimiento,
        nombre: user.nombre,
        telefono: user.telefono,
        username: user.username,
        imagen: Imagen.fromJson(image?.toJson() ?? <String, dynamic>{}),
        rol: Rol.fromJson(rol?.toJson() ?? <String, dynamic>{}),
      );
    }).toList();
  }

  // CREATE
  Future<int> insert(Usuario usuario) {
    return into(db.usuarioTable).insert(
      UsuarioTableData.fromJson(usuario.toJson()),
    );
  }

  // READ: Usuario por ID
  Future<Usuario?> getByID(int id) async {
    final rolAlias = alias(db.rolTable, 'rol');
    final imagenAlias = alias(db.imagenTable, 'image');

    final query = select(db.usuarioTable).join([
      leftOuterJoin(
        rolAlias,
        rolAlias.idInt.equalsExp(db.usuarioTable.rolInt),
      ),
      leftOuterJoin(
        imagenAlias,
        imagenAlias.idInt.equalsExp(db.usuarioTable.imagenInt),
      ),
    ]);

    query.where(db.cotizacionTable.idInt.equals(id));

    var row = await query.getSingleOrNull();
    if (row == null) return null;
    final user = row.readTable(db.usuarioTable);
    final rol = row.readTableOrNull(rolAlias);
    final image = row.readTableOrNull(imagenAlias);

    return Usuario(
      idInt: user.idInt,
      id: user.id,
      estatus: user.estatus,
      createdAt: user.createdAt,
      apellido: user.apellido,
      correoElectronico: user.correoElectronico,
      fechaNacimiento: user.fechaNacimiento,
      nombre: user.nombre,
      telefono: user.telefono,
      username: user.username,
      imagen: Imagen.fromJson(image?.toJson() ?? <String, dynamic>{}),
      rol: Rol.fromJson(rol?.toJson() ?? <String, dynamic>{}),
    );
  }

  // UPDATE
  Future<bool> updat3(Usuario usuario) {
    var response = update(db.usuarioTable).replace(
      UsuarioTableData.fromJson(usuario.toJson()),
    );

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

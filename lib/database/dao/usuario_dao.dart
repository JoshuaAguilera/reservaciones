import 'package:drift/drift.dart';

import '../../models/imagen_model.dart';
import '../../models/rol_model.dart';
import '../../models/usuario_model.dart';
import '../../utils/encrypt/encrypter.dart';
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
    int? rolId,
    DateTime? initDate,
    DateTime? lastDate,
    String? sortBy,
    String order = 'asc',
    int limit = 20,
    int page = 1,
    bool conDetalle = false,
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

    if (rolId != null) {
      query.where(db.usuarioTable.rolInt.equals(rolId));
    }

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

  //EXISTS
  Future<bool> exists({String? username, int? id}) async {
    final query = select(usuarioTable);
    if (username != null) query.where((u) => u.username.equals(username));
    if (id != null) query.where((u) => u.idInt.equals(id));
    final usuario = await query.getSingleOrNull();

    final exists = usuario != null;
    return exists;
  }

  // CREATE
  Future<Usuario?> insert(Usuario usuario) async {
    var response = await into(db.usuarioTable).insertReturningOrNull(
      UsuarioTableData.fromJson(usuario.toJson()),
    );

    if (response == null) return null;
    return Usuario.fromJson(response.toJson());
  }

  // READ: Usuario por ID
  Future<Usuario?> getByID({
    int? id,
    String? username,
    String? password,
    String? notStatus,
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

    if (id != null) query.where(db.usuarioTable.idInt.equals(id));

    if (username != null) {
      query.where(db.usuarioTable.username.equals(username));
    }

    if (password != null) {
      String posPassword = EncrypterTool.encryptData(password, null);
      query.where(db.usuarioTable.password.equals(posPassword));
    }

    if (notStatus != null) {
      query.where(db.usuarioTable.estatus.equals(notStatus).not());
    }

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
  Future<Usuario?> updat3(Usuario usuario) async {
    var response = await update(db.usuarioTable).replace(
      UsuarioTableData.fromJson(usuario.toJson()),
    );

    if (response == 0) return null;
    return await getByID(id: usuario.idInt);
  }

  // SAVE
  Future<Usuario?> save(Usuario usuario) async {
    if (usuario.idInt == null) {
      return await insert(usuario);
    } else {
      return await updat3(usuario);
    }
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

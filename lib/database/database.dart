import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import 'tables/habitacion_table.dart';
import 'tables/cotizaciones_table.dart';
import 'tables/periodo_table.dart';
import 'tables/politicas_table.dart';
import 'tables/tarifa_rack_table.dart';
import 'tables/tarifa_table.dart';
import 'tables/tarifa_x_dia_table.dart';
import 'tables/temporada_table.dart';
import 'tables/user_activity_table.dart';
import 'tables/usuario_table.dart';
part 'database.g.dart';

// @DriftDatabase(tables: [
//  Usuario,
//   Cotizacion,
//   Habitacion,
//   TarifaXDiaTable,
//   Periodo,
//   Temporada,
//   Tarifa,
//   UserActivity,
//   TarifaRack,
//   Politicas,
// ])
// class AppDatabase extends _$AppDatabase {}

@DriftDatabase(tables: [
  Usuario,
  Cotizacion,
  Habitacion,
  TarifaXDiaTable,
  Periodo,
  Temporada,
  Tarifa,
  UserActivity,
  TarifaRack,
  Politicas,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  //cotizaciones Dao
  Future<List<CotizacionData>> getCotizacionesByFolio(String folioQuotes) {
    return (select(cotizacion)
          ..where((t) => t.folioPrincipal.equals(folioQuotes)))
        .get();
  }

  Future<List<CotizacionData>> getCotizacionesSearch(String search) {
    return (select(cotizacion)..where((t) => t.nombreHuesped.contains(search)))
        .get();
  }

  Future<List<CotizacionData>> getCotizacionesUltimoDia({String search = ""}) {
    if (search.isEmpty) {
      return (select(cotizacion)
            ..where(
              (t) => t.fecha.isBetweenValues(
                DateTime.now().subtract(const Duration(days: 1)),
                DateTime.now(),
              ),
            ))
          .get();
    } else {
      return (select(cotizacion)
            ..where((t) => t.nombreHuesped.contains(search))
            ..where((t) => t.fecha.isBetweenValues(
                DateTime.now().subtract(const Duration(days: 1)),
                DateTime.now())))
          .get();
    }
  }

  Future<List<CotizacionData>> getCotizacionesUltimaSemana(
      {String search = ""}) {
    if (search.isEmpty) {
      return (select(cotizacion)
            ..where((t) => t.fecha.isBetweenValues(
                DateTime.now().subtract(const Duration(days: 7)),
                DateTime.now())))
          .get();
    } else {
      return (select(cotizacion)
            ..where((t) => t.nombreHuesped.contains(search))
            ..where((t) => t.fecha.isBetweenValues(
                DateTime.now().subtract(const Duration(days: 7)),
                DateTime.now())))
          .get();
    }
  }

  Future<List<CotizacionData>> getCotizacionesUltimoMes({String search = ""}) {
    if (search.isEmpty) {
      return (select(cotizacion)
            ..where((t) => t.fecha.isBetweenValues(
                DateTime.now().subtract(const Duration(days: 30)),
                DateTime.now())))
          .get();
    } else {
      return (select(cotizacion)
            ..where((t) => t.nombreHuesped.contains(search))
            ..where((t) => t.fecha.isBetweenValues(
                DateTime.now().subtract(const Duration(days: 30)),
                DateTime.now())))
          .get();
    }
  }

  Future<List<CotizacionData>> getCotizacionesPeriodo(
      DateTime initTime, DateTime lastTime,
      {String search = ""}) {
    if (search.isEmpty) {
      return (select(cotizacion)
            ..where((t) => t.fecha.isBetweenValues(initTime, lastTime)))
          .get();
    } else {
      return (select(cotizacion)
            ..where((t) => t.nombreHuesped.contains(search))
            ..where((t) => t.fecha.isBetweenValues(initTime, lastTime)))
          .get();
    }
  }

  Future<List<CotizacionData>> getCotizacionesHoy() {
    return (select(cotizacion)
          ..where(
            (t) => t.fecha.isBetweenValues(
              DateTime.parse(DateTime.now().toIso8601String().substring(0, 10)),
              DateTime.now(),
            ),
          ))
        .get();
  }

  Future<List<CotizacionData>> getCotizacionesRecientes() {
    return (select(cotizacion)
          ..orderBy([
            (t) => OrderingTerm(expression: t.fecha, mode: OrderingMode.desc)
          ]))
        .get();
  }

  Future<List<CotizacionData>> getHistorialCotizaciones() {
    return (select(cotizacion)).get();
  }

  Future deleteCotizacionByFolio(String folio) {
    return (delete(cotizacion)..where((t) => t.folioPrincipal.equals(folio)))
        .go();
  }

  Future<List<CotizacionData>> getCotizacionByPeriod(
    DateTime initTime,
    DateTime lastTime,
  ) {
    return (select(cotizacion)
          ..where(
            (t) => t.fecha.isBetweenValues(initTime, lastTime),
          ))
        .get();
  }

  //habitacion DAO

  Future<List<HabitacionData>> getAllHabitaciones() {
    return (select(habitacion)).get();
  }

  Future<List<HabitacionData>> getHabitacionesByFolio(String folio) {
    return (select(habitacion)..where((t) => t.folioCotizacion.equals(folio)))
        .get();
  }

  Future<List<HabitacionData>> getHabitacionesByPeriod(
    DateTime initTime,
    DateTime lastTime,
  ) {
    return (select(habitacion)
          ..where((t) => t.fecha.isBetweenValues(initTime, lastTime)))
        .get();
  }

  Future<List<HabitacionData>> getHabitacionesHoy() {
    return (select(habitacion)
          ..where((t) => t.fecha.isBetweenValues(
              DateTime.parse(DateTime.now().toIso8601String().substring(0, 10)),
              DateTime.now())))
        .get();
  }

  Future<int> updateHabitacion(HabitacionData hab) {
    return (update(habitacion)..where((t) => t.id.equals(hab.id))).write(hab);
  }

  Future deleteHabitacionByFolio(String folio) {
    return (delete(habitacion)..where((t) => t.folioCotizacion.equals(folio)))
        .go();
  }

  //tarifaXdia DAO

  Future<List<TarifaXDiaTableData>> getTarifaXDiaByFolio(String folio) {
    return (select(tarifaXDiaTable)..where((t) => t.subfolio.equals(folio)))
        .get();
  }

  Future<int> updateTarifaXDia(TarifaXDiaTableData tarifa) {
    return (update(tarifaXDiaTable)..where((t) => t.id.equals(tarifa.id)))
        .write(tarifa);
  }

  Future deleteTarifaXDiaByFolio(String folio) {
    return (delete(tarifaXDiaTable)..where((t) => t.subfolio.equals(folio)))
        .go();
  }

  //usuario dao

  Future<List<UsuarioData>> getUsuariosByUsername(
      String userName, int? userId) async {
    if (userId != null) {
      return await (select(usuario)
            ..where(
              (tbl) => tbl.id.equals(userId).not(),
            )
            ..where((t) => t.username.equals(userName)))
          .get();
    } else {
      return await (select(usuario)..where((t) => t.username.equals(userName)))
          .get();
    }
  }

  Future<List<UsuarioData>> getUsuarioByUsernameAndID(
      String userName, int id) async {
    return await (select(usuario)
          ..where((t) => t.username.equals(userName))
          ..where((tbl) => tbl.id.equals(id)))
        .get();
  }

  Future<List<UsuarioData>> loginUser(String userName, String password) async {
    return await (select(usuario)
          ..where((t) => t.username.equals(userName))
          ..where((tbl) => tbl.password.equals(password)))
        .get();
  }

  Future<int> updateUsuario(UsuarioData user) {
    return (update(usuario)..where((t) => t.id.equals(user.id))).write(user);
  }

  Future<int> deleteUsuario(UsuarioData user) {
    UsuarioData selectUser = UsuarioData(
      id: user.id,
      username: user.username,
      apellido: user.apellido,
      correoElectronico: user.correoElectronico,
      fechaNacimiento: user.fechaNacimiento,
      nombre: user.nombre,
      numCotizaciones: user.numCotizaciones,
      password: user.password,
      passwordCorreo: user.passwordCorreo,
      rol: user.rol,
      telefono: user.telefono,
      status: "INACTIVO",
    );
    return (update(usuario)..where((t) => t.id.equals(user.id)))
        .write(selectUser);
  }

  Future<int> updatePasswordUser(
      int userId, String username, String newPassword) {
    return (update(usuario)..where((t) => t.id.equals(userId))).write(
        UsuarioData(id: userId, username: username, password: newPassword));
  }

  Future<int> updatePasswordMailUser(
      int userId, String username, String newPassword) {
    return (update(usuario)..where((t) => t.id.equals(userId))).write(
        UsuarioData(
            id: userId, username: username, passwordCorreo: newPassword));
  }

  Future<List<UsuarioData>> getListUser(int idAdmin) async {
    return await (select(usuario)
          ..where((u) => u.status.equals("INACTIVO").not())
          ..where((u) => u.id.equals(idAdmin).not()))
        .get();
  }

  Future<List<UsuarioData>> getUsersSearch(String search, int idAdmin) {
    return (select(usuario)
          ..where((u) => u.status.equals("INACTIVO").not())
          ..where((u) => u.id.equals(idAdmin).not())
          ..where((t) => t.username.contains(search)))
        .get();
  }

  //tarifa dao

  // -- //Methods Get

  Future<List<TarifaRackData>> getAllTarifasRack() {
    return (select(tarifaRack)).get();
  }

  Future<List<TemporadaData>> getSeasonByCode(String code) {
    return (select(temporada)..where((tbl) => tbl.code.equals(code))).get();
  }

  Future<List<TarifaData>> getTariffByCode(String code) {
    return (select(tarifa)..where((tbl) => tbl.code.equals(code))).get();
  }

  Future<List<PeriodoData>> getPeriodByCode(String code) {
    return (select(periodo)..where((tbl) => tbl.code.equals(code))).get();
  }

  // -- //Methods Update

  Future<int> updateTariff(
      {required TarifaCompanion tarifaUpdate,
      required String codeUniv,
      required int id}) {
    return (update(tarifa)
          ..where((t) => t.code.equals(codeUniv))
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .write(tarifaUpdate);
  }

  Future<int> updateSeason({
    required TemporadaCompanion tempUpdate,
    required String codeUniv,
    required int id,
  }) {
    return (update(temporada)
          ..where((t) => t.code.equals(codeUniv))
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .write(tempUpdate);
  }

  Future<int> updateTariffRack({
    required TarifaRackCompanion tarifaUpdate,
    required String codeUniv,
    required int id,
  }) {
    return (update(tarifaRack)
          ..where((t) => t.code.equals(codeUniv))
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .write(tarifaUpdate);
  }

  // -- //Methods Delete

  Future<int> deletePeriodByIDandCode(String codeUniv, int id) {
    return (delete(periodo)
          ..where(
            (tbl) => tbl.code.equals(codeUniv),
          )
          ..where((t) => t.id.equals(id)))
        .go();
  }

  Future<int> deleteTariffByIDandCode(String codeUniv, int id) {
    return (delete(tarifa)
          ..where(
            (tbl) => tbl.code.equals(codeUniv),
          )
          ..where((t) => t.id.equals(id)))
        .go();
  }

  Future<int> deleteSeasonByIDandCode(String codeUniv, int id) {
    return (delete(temporada)
          ..where(
            (tbl) => tbl.code.equals(codeUniv),
          )
          ..where((t) => t.id.equals(id)))
        .go();
  }

  Future<int> deleteTariffRackByIDandCode(String codeUniv, int id) {
    return (delete(tarifaRack)
          ..where(
            (tbl) => tbl.code.equals(codeUniv),
          )
          ..where((t) => t.id.equals(id)))
        .go();
  }

  // -- // Policies

  Future<List<Politica>> getTariffPolicy() {
    return (select(politicas)).get();
  }

  Future<int> updateTariffPolicy(
      {required Politica politica, required int id}) {
    return (update(politicas)..where((tbl) => tbl.id.equals(id)))
        .write(politica);
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.

    //final dbFolder = "/";//DesCommit when release
    //final file = File(p.join(dbFolder, 'dbReservaciones.sqlite'));

    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'dbReservaciones.sqlite'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}

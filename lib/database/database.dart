import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import '../res/helpers/constants.dart';
import 'dao/cliente_dao.dart';
import 'dao/cotizacion_dao.dart';
import 'dao/tarifa_base_dao.dart';
import 'dao/tarifa_dao.dart';
import 'dao/tarifa_rack_dao.dart';
import 'dao/usuario_dao.dart';
import 'tables/cliente_table.dart';
import 'tables/habitacion_table.dart';
import 'tables/cotizacion_table.dart';
import 'tables/images_table.dart';
import 'tables/periodo_table.dart';
import 'tables/politicas_table.dart';
import 'tables/tarifa_base_table.dart';
import 'tables/tarifa_rack_table.dart';
import 'tables/tarifa_table.dart';
import 'tables/tarifa_x_dia_table.dart';
import 'tables/temporada_table.dart';
import 'tables/temporada_tarifa_table.dart';
import 'tables/user_activity_table.dart';
import 'tables/usuario_table.dart';
part 'database.g.dart';

// @DriftDatabase(
//   tables: [
//     UsuarioTable,
//     CotizacionTable,
//     HabitacionTable,
//     TarifaXDiaTable,
//     PeriodoTable,
//     TemporadaTable,
//     TarifaTable,
//     UserActivity,
//     TarifaRackTable,
//     PoliticaTable,
//     ImageTable,
//     TemporadaTarifaTable,
//     TarifaBaseTable,
//     ClienteTable,
//   ],
//   daos: [
//     TarifaBaseDao,
//     TarifaDao,
//     TarifaRackDao,
//     CotizacionDao,
//     UsuarioDao,
//     ClienteDao,
//   ],
// )
// class AppDatabase extends _$AppDatabase {}

@DriftDatabase(
  tables: [
    UsuarioTable,
    CotizacionTable,
    HabitacionTable,
    TarifaXDiaTable,
    PeriodoTable,
    TemporadaTable,
    TarifaTable,
    UserActivity,
    TarifaRackTable,
    PoliticaTable,
    ImageTable,
    TemporadaTarifaTable,
    TarifaBaseTable,
    ClienteTable,
  ],
  daos: [
    TarifaBaseDao,
    TarifaDao,
    TarifaRackDao,
    CotizacionDao,
    UsuarioDao,
    ClienteDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  //habitacion DAO

  Future<List<HabitacionTableData>> getAllHabitaciones() {
    return (select(habitacionTable)).get();
  }

  Future<List<HabitacionTableData>> getHabitacionesByFolio(String folio) {
    return (select(habitacionTable)
          ..where((t) => t.folioCotizacion.equals(folio)))
        .get();
  }

  Future<List<HabitacionTableData>> getHabitacionesByPeriod(
    DateTime initTime,
    DateTime lastTime,
  ) {
    return (select(habitacionTable)
          ..where((t) => t.fecha.isBetweenValues(initTime, lastTime)))
        .get();
  }

  Future<List<HabitacionTableData>> getHabitacionesHoy() {
    return (select(habitacionTable)
          ..where((t) => t.fecha.isBetweenValues(
              DateTime.parse(DateTime.now().toIso8601String().substring(0, 10)),
              DateTime.now())))
        .get();
  }

  Future<int> updateHabitacion(HabitacionTableData hab) {
    return (update(habitacionTable)..where((t) => t.id.equals(hab.id)))
        .write(hab);
  }

  Future<int> deleteHabitacionByFolio(String folio) {
    return (delete(habitacionTable)
          ..where((t) => t.folioCotizacion.equals(folio)))
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

  Future<List<UsuarioTableData>> loginUser(
      String userName, String password) async {
    return await (select(usuarioTable)
          ..where((tbl) => tbl.estatus.equals("inactivo").not())
          ..where((t) => t.username.equals(userName))
          ..where((tbl) => tbl.password.equals(password)))
        .get();
  }

  // Image dao

  Future<int> updateURLImage(int id, String code, String newUrl) {
    return (update(imageTable)..where((t) => t.id.equals(id)))
        .write(ImageTableData(
      id: id,
      code: code,
      urlImage: newUrl,
    ));
  }

  Future<List<ImageTableData>> getImageById(int id) async {
    return await (select(imageTable)..where((tbl) => tbl.id.equals(id))).get();
  }

  //tarifa dao

  // -- //Methods Get

  Future<List<TarifaRackTableData>> getAllTarifasRack() {
    return (select(tarifaRackTable)).get();
  }

  Future<List<TemporadaTableData>> getSeasonByCode(String code) {
    return (select(temporadaTable)..where((tbl) => tbl.code.equals(code)))
        .get();
  }

  Future<List<TarifaTableData>> getTariffByCode(String code) {
    return (select(tarifaTable)..where((tbl) => tbl.code.equals(code))).get();
  }

  Future<List<PeriodoTableData>> getPeriodByCode(String code) {
    return (select(periodoTable)..where((tbl) => tbl.code.equals(code))).get();
  }

  // -- //Methods Update

  Future<int> updateTariff(
      {required TarifaTableCompanion tarifaUpdate,
      required String codeTariff,
      required int id}) {
    return (update(tarifaTable)
          ..where((t) => t.code.equals(codeTariff))
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .write(tarifaUpdate);
  }

  Future<int> updateSeason({
    required TemporadaTableCompanion tempUpdate,
    required String codeUniv,
    required int id,
  }) {
    return (update(temporadaTable)
          ..where((t) => t.code.equals(codeUniv))
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .write(tempUpdate);
  }

  Future<int> updateTariffRack({
    required TarifaRackTableCompanion tarifaUpdate,
    required String codeUniv,
    required int id,
  }) {
    return (update(tarifaRackTable)
          ..where((t) => t.code.equals(codeUniv))
          ..where((tbl) => tbl.id.equals(id)))
        .write(tarifaUpdate);
  }

  // -- //Methods Delete

  Future<int> deletePeriodByIDandCode(String codeUniv, int id) {
    return (delete(periodoTable)
          ..where((tbl) => tbl.code.equals(codeUniv))
          ..where((t) => t.id.equals(id)))
        .go();
  }

  Future<int> deleteTariffByIDandCode(String codeUniv, int id) {
    return (delete(tarifaTable)
          ..where(
            (tbl) => tbl.code.equals(codeUniv),
          )
          ..where((t) => t.id.equals(id)))
        .go();
  }

  Future<int> deleteSeasonByIDandCode(String code, int id) {
    return (delete(temporadaTable)
          ..where((tbl) => tbl.code.equals(code))
          ..where((t) => t.id.equals(id)))
        .go();
  }

  Future<int> deleteTariffRackByIDandCode(String codeUniv, int id) {
    return (delete(tarifaRackTable)
          ..where(
            (tbl) => tbl.code.equals(codeUniv),
          )
          ..where((t) => t.id.equals(id)))
        .go();
  }

  // -- // Policies

  Future<List<PoliticaTableData>> getTariffPolicy() {
    return (select(politicaTable)).get();
  }

  Future<int> updateTariffPolicy(
      {required PoliticaTableData politica, required int id}) {
    return (update(politicaTable)..where((tbl) => tbl.id.equals(id)))
        .write(politica);
  }

  // -- // Tarifa Base Dao
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(
    () async {
      // put the database file, called db.sqlite here, into the documents folder
      // for your app.

      //Location BD for release version
      final dbFolder = "/";
      //Location BD for beta version
      final dbFolderBeta = await getApplicationDocumentsDirectory();

      final file = File(p.join(
          inDevelop ? dbFolderBeta.path : dbFolder, 'dbReservaciones.sqlite'));

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

      return NativeDatabase.createInBackground(
        file,
        setup: (database) => database.execute('PRAGMA busy_timeout = 5000;'),
      );
    },
  );
}

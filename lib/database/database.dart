import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import '../res/helpers/constants.dart';
import '../res/helpers/general_helpers.dart';
import 'dao/categoria_dao.dart';
import 'dao/cliente_dao.dart';
import 'dao/cotizacion_dao.dart';
import 'dao/habitacion_dao.dart';
import 'dao/imagen_dao.dart';
import 'dao/notificacion_dao.dart';
import 'dao/periodo_dao.dart';
import 'dao/politica_tarifario_dao.dart';
import 'dao/registro_tarifa_dao.dart';
import 'dao/resumen_operacion_dao.dart';
import 'dao/rol_dao.dart';
import 'dao/tarifa_base_dao.dart';
import 'dao/tarifa_dao.dart';
import 'dao/tarifa_rack_dao.dart';
import 'dao/tarifa_x_dia_dao.dart';
import 'dao/tarifa_x_habitacion_dao.dart';
import 'dao/temporada_dao.dart';
import 'dao/tipo_hab_dao.dart';
import 'dao/usuario_dao.dart';
import 'tables/categoria_table.dart';
import 'tables/cliente_table.dart';
import 'tables/habitacion_table.dart';
import 'tables/cotizacion_table.dart';
import 'tables/imagen_table.dart';
import 'tables/periodo_table.dart';
import 'tables/politica_tarifario_table.dart';
import 'tables/reservacion_table.dart';
import 'tables/resumen_operacion_table.dart';
import 'tables/rol_table.dart';
import 'tables/tarifa_base_table.dart';
import 'tables/tarifa_rack_table.dart';
import 'tables/tarifa_table.dart';
import 'tables/tarifa_x_dia_table.dart';
import 'tables/tarifa_x_habitacion_table.dart';
import 'tables/temporada_table.dart';
import 'tables/temporada_tarifa_table.dart';
import 'tables/notificacion_table.dart';
import 'tables/tipo_habitacion_table.dart';
import 'tables/usuario_table.dart';
part 'database.g.dart';

@DriftDatabase(
  tables: [
    CategoriaTable,
    ClienteTable,
    CotizacionTable,
    HabitacionTable,
    ImagenTable,
    NotificacionTable,
    PeriodoTable,
    PoliticaTarifarioTable,
    ReservacionTable,
    ResumenOperacionTable,
    RolTable,
    TarifaBaseTable,
    TarifaRackTable,
    TarifaTable,
    TarifaXDiaTable,
    TarifaXHabitacionTable,
    TemporadaTable,
    TarifaTemporadaTable,
    TipoHabitacionTable,
    UsuarioTable,
    ReservacionBrazaleteTable,
    RegistroTarifaTable,
  ],
  daos: [
    CategoriaDao,
    ClienteDao,
    CotizacionDao,
    HabitacionDao,
    PeriodoDao,
    ResumenOperacionDao,
    TarifaBaseDao,
    TarifaDao,
    TarifaRackDao,
    TarifaXDiaDao,
    TarifaXHabitacionDao,
    TemporadaDao,
    UsuarioDao,
    ImagenDao,
    PoliticaTarifarioDao,
    RegistroTarifaDao,
    RolDao,
    TipoHabitacionDao,
    NotificacionDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> count<T extends Table, D>(
      TableInfo<T, D> tabla, Expression<bool> Function(T tbl) condicion) async {
    final countExp = tabla.$primaryKey.first.count();
    final query = selectOnly(tabla)
      ..addColumns([countExp])
      ..where(condicion(tabla as dynamic));
    final row = await query.getSingle();
    return row.read(countExp) ?? 0;
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(
    () async {
      // put the database file, called db.sqlite here, into the documents folder
      // for your app.

      //Location BD for release version
      const dbFolder = "/";
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

import 'package:drift/drift.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/database/tables/tarifa_base_table.dart';
import 'package:generador_formato/database/tables/tarifa_table.dart';
import 'package:generador_formato/models/tarifa_base_model.dart';
import 'package:generador_formato/models/tarifa_model.dart' as tf;
part 'tarifa_base_dao.g.dart';

@DriftAccessor(tables: [TarifaBase, Tarifa])
class TarifaBaseDao extends DatabaseAccessor<AppDatabase>
    with _$TarifaBaseDaoMixin {
  TarifaBaseDao(AppDatabase db) : super(db);

  Future<List<TarifaBaseInt>> getBaseTariffComplement(
      {int? tarifaBaseId}) async {
    final query = customSelect(
      '''
      SELECT 
        c.id AS tarifaBaseId, 
        c.code AS tarifaBaseCode, 
        c.nombre AS tarifaBaseNombre,
        c.desc_integrado AS tarifaBaseDescuento,
        c.upgrade_categoria AS tarifaBaseUpgradeCategoria,
        c.upgrade_menor AS tarifaBaseUpgradeMenor, 
        c.upgrade_pax_adic AS tarifaBaseUpgradePaxAdic, 
        c.tarifa_padre_id AS tarifaPadreId, 
        c.tarifa_origen_id AS tarifaOrigenId, 
        p.id AS tarifaId, 
        p.code AS tarifaCode,
        p.fecha AS tarifaFecha,
        p.categoria AS tarifaCategoria,
        p.tarifa_adulto_s_g_lo_d_b_l AS tarifaAdultoSGLoDBL,
        p.tarifa_adulto_t_p_l AS tarifaAdultoTPL,
        P.tarifa_adulto_c_p_l_e AS tarifaAdultoCPLE,
        p.tarifa_menores7a12 AS tarifaMenores7a12,
        p.tarifa_pax_adicional AS tarifaPaxAdicional
      FROM tarifa_base c
      LEFT JOIN tarifa p 
        ON c.id = p.tarifa_padre_id
        ${tarifaBaseId != null ? 'WHERE c.id = ?' : ''}
        ORDER BY c.id, p.id
      ''',
      variables: tarifaBaseId != null ? [Variable<int>(tarifaBaseId)] : [],
      readsFrom: {tarifaBase, tarifa},
    );

    final rows = await query.get();

    final Map<int, List<tf.Tarifa>> tarifasPorTarifaBase = {};

    for (final row in rows) {
      final tarifaBaseId = row.read<int>('tarifaBaseId');
      final tarifaId = row.read<int?>('tarifaId');
      final code = row.read<String?>('tarifaCode');
      final categoria = row.read<String?>('tarifaCategoria');
      final fecha = row.read<DateTime?>('tarifaFecha');
      final tarifaAdultoSGLoDBL = row.read<double?>("tarifaAdultoSGLoDBL");
      final tarifaAdultoTPL = row.read<double?>("tarifaAdultoTPL");
      final tarifaAdultoCPLE = row.read<double?>("tarifaAdultoCPLE");
      final tarifaMenores7a12 = row.read<double?>("tarifaMenores7a12");
      final tarifaPaxAdicional = row.read<double?>("tarifaPaxAdicional");

      if (tarifaId != null && code != null) {
        final tarifaData = tf.Tarifa(
          id: tarifaId,
          code: code,
          categoria: categoria,
          fecha: fecha.toString().substring(0, 10),
          tarifaAdulto1a2: tarifaAdultoSGLoDBL,
          tarifaAdulto3: tarifaAdultoTPL,
          tarifaAdulto4: tarifaAdultoCPLE,
          tarifaMenores7a12: tarifaMenores7a12,
          tarifaPaxAdicional: tarifaPaxAdicional,
          tarifaBaseId: tarifaBaseId,
        );
        tarifasPorTarifaBase
            .putIfAbsent(tarifaBaseId, () => [])
            .add(tarifaData);
      }
    }

    final List<TarifaBaseInt> tarifasBase = [];

    for (final row in rows) {
      final tarifaBaseId = row.read<int>('tarifaBaseId');
      final tarifaOrigenId = row.read<int?>('tarifaOrigenId');
      final code = row.read<String?>('tarifaBaseCode');
      final nombre = row.read<String?>('tarifaBaseNombre');
      final descuento = row.read<double?>('tarifaBaseDescuento');
      final upgradeCategoria = row.read<double?>('tarifaBaseUpgradeCategoria');
      final upgradeMenor = row.read<double?>('tarifaBaseUpgradeMenor');
      final upgradePaxAdic = row.read<double?>('tarifaBaseUpgradePaxAdic');
      final tarifaPadreId = row.read<int?>('tarifaPadreId');

      if (!tarifasBase.any((c) => c.id == tarifaBaseId)) {
        tarifasBase.add(
          TarifaBaseInt(
            id: tarifaBaseId,
            code: code,
            nombre: nombre,
            descIntegrado: descuento,
            upgradeCategoria: upgradeCategoria,
            upgradeMenor: upgradeMenor,
            upgradePaxAdic: upgradePaxAdic,
            tarifaOrigenId: tarifaOrigenId,
            tarifaPadre: tarifaPadreId != null
                ? (await getBaseTariffComplement(tarifaBaseId: tarifaPadreId))
                    .first
                : null,
            tarifas: tarifasPorTarifaBase[tarifaBaseId] ?? [],
          ),
        );
      }
    }

    return tarifasBase;
  }

  Future<int> updateBaseTariff(
      {required TarifaBaseData baseTariff,
      required int id,
      required String code}) {
    return (update(tarifaBase)
          ..where((tbl) => tbl.code.equals(code))
          ..where((tbl) => tbl.id.equals(id)))
        .write(baseTariff);
  }

  Future<int> removeOrigenTarifaId({required int? origenId}) {
    return (update(tarifaBase)
          ..where((tbl) => tbl.tarifaOrigenId.equals(origenId!)))
        .write(
      const TarifaBaseCompanion(
        tarifaOrigenId: Value(null),
      ),
    );
  }

  Future<int> removePadreTarifaId({required int? padreId}) {
    return (update(tarifaBase)
          ..where((tbl) => tbl.tarifaPadreId.equals(padreId!)))
        .write(
      const TarifaBaseCompanion(
        tarifaPadreId: Value(null),
        tarifaOrigenId: Value(null),
        descIntegrado: Value(null),
      ),
    );
  }

  Future<int> deleteBaseTariff(TarifaBaseInt tarifaBaseSelect) {
    removePadreTarifaId(padreId: tarifaBaseSelect.id);
    removeOrigenTarifaId(origenId: tarifaBaseSelect.id);

    return (delete(tarifaBase)..where((t) => t.id.equals(tarifaBaseSelect.id!)))
        .go();
  }
}

import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/cliente_table.dart';
import '../tables/cotizacion_table.dart';
import '../tables/usuario_table.dart';
import 'tarifa_dao.dart';

part 'cotizacion_dao.g.dart';

@DriftAccessor(tables: [CotizacionTable, ClienteTable, UsuarioTable])
class CotizacionDao extends DatabaseAccessor<AppDatabase>
    with _$CotizacionDaoMixin {
  CotizacionDao(AppDatabase db) : super(db);

  Future<List<CotizacionTable>> getBaseTariffComplement({
    String? cliente,
    int? userId,
  }) async {
    final query = customSelect(
      '''
      SELECT 
        c.id AS tarifaBaseId, 
        c.code AS tarifaBaseCode, 
        c.nombre AS tarifaBaseNombre,
        c.with_auto AS withAuto,
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
        ${tarifaPadreId != null ? 'WHERE c.tarifa_padre_id = ?' : ''}
        ORDER BY c.id, p.id
      ''',
      variables: tarifaBaseId != null
          ? [Variable<int>(tarifaBaseId)]
          : tarifaPadreId != null
              ? [Variable<int>(tarifaPadreId)]
              : [],
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
      final withAuto = row.read<bool?>('withAuto');
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
            withAuto: withAuto,
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

  Future<int> propageChangesTariff(
      {required TarifaBaseData baseTariff,
      required List<tf.Tarifa> tarifasBase}) async {
    int tarifaId = baseTariff.id;
    final tarifaDao = TarifaDao(db);

    List<TarifaBaseInt> _tariffs =
        await getBaseTariffComplement(tarifaPadreId: tarifaId);

    if (_tariffs.isNotEmpty) {
      for (var tarifaBase in _tariffs) {
        if ((tarifaBase.tarifas ?? []).isEmpty) {
          continue;
        }

        double divisor = tarifaBase.descIntegrado ?? 1;

        for (var element in (tarifaBase.tarifas!)) {
          tf.Tarifa? selectTariff = await tarifasBase
              .where((elementInt) =>
                  elementInt.categoria == (element.categoria ?? ''))
              .firstOrNull;

          if (selectTariff == null) continue;

          element.tarifaAdulto4 = Utility.formatNumberRound(
              (selectTariff.tarifaAdulto4 ?? 0) / divisor);
          element.tarifaAdulto1a2 = Utility.formatNumberRound(
              (selectTariff.tarifaAdulto1a2 ?? 0) / divisor);
          element.tarifaAdulto3 = Utility.formatNumberRound(
              (selectTariff.tarifaAdulto3 ?? 0) / divisor);
          element.tarifaMenores7a12 = Utility.formatNumberRound(
              (selectTariff.tarifaMenores7a12 ?? 0) / divisor);

          await tarifaDao.updateForBaseTariff(
            tarifaData: TarifaCompanion(
              tarifaAdultoCPLE: Value(element.tarifaAdulto4),
              tarifaAdultoSGLoDBL: Value(element.tarifaAdulto1a2),
              tarifaAdultoTPL: Value(element.tarifaAdulto3),
              tarifaMenores7a12: Value(element.tarifaMenores7a12),
              tarifaPaxAdicional: Value(element.tarifaPaxAdicional),
            ),
            baseTariffId: tarifaBase.id!,
            id: element.id ?? 0,
          );
        }

        await propageChangesTariff(
          baseTariff: TarifaBaseData(
              id: tarifaBase.id!, descIntegrado: tarifaBase.descIntegrado),
          tarifasBase: tarifaBase.tarifas ?? List<tf.Tarifa>.empty(),
        );
      }
    }

    tarifaDao.close();

    return tarifaId;
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

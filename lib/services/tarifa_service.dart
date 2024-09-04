import 'dart:ui';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:generador_formato/models/periodo_model.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/models/tarifa_model.dart';
import 'package:generador_formato/models/temporada_model.dart';
import 'package:generador_formato/services/base_service.dart';

import '../database/database.dart';

class TarifaService extends BaseService {
  Future<bool> saveTarifaBD({
    required String name,
    required List<Periodo> periodos,
    required Color colorIdentificativo,
    required List<bool> diasAplicacion,
    required Temporada tempProm,
    required Temporada tempBar1,
    required Temporada tempBar2,
    required TarifaTemporada tarifaVR,
    required TarifaTemporada tarifaVPM,
  }) async {
    String codeUniversal =
        "${UniqueKey().hashCode.toString()}-$userId-$userName-${DateTime.now().toString()}";
    DateTime now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    final database = AppDatabase();

    try {
      database.transaction(
        () async {
          for (var element in periodos) {
            await database.into(database.periodo).insert(
                  PeriodoCompanion.insert(
                    code: codeUniversal,
                    fecha: Value(now),
                    fechaFinal: Value(element.fechaFinal),
                    fechaInicial: Value(element.fechaInicial),
                    enLunes: Value(diasAplicacion[0]),
                    enMartes: Value(diasAplicacion[1]),
                    enMiercoles: Value(diasAplicacion[2]),
                    enJueves: Value(diasAplicacion[3]),
                    enViernes: Value(diasAplicacion[4]),
                    enSabado: Value(diasAplicacion[5]),
                    enDomingo: Value(diasAplicacion[6]),
                  ),
                );
          }

          await database.into(database.tarifa).insert(
                TarifaCompanion.insert(
                  code: codeUniversal,
                  categoria: Value(tarifaVR.categoria),
                  fecha: Value(now),
                  tarifaAdultoSGLoDBL: Value(tarifaVR.tarifaAdulto1a2),
                  tarifaMenores7a12: Value(tarifaVR.tarifaMenores7a12),
                  tarifaPaxAdicional: Value(tarifaVR.tarifaPaxAdicional),
                ),
              );
          await database.into(database.tarifa).insert(
                TarifaCompanion.insert(
                  code: codeUniversal,
                  categoria: Value(tarifaVPM.categoria),
                  fecha: Value(now),
                  tarifaAdultoSGLoDBL: Value(tarifaVPM.tarifaAdulto1a2),
                  tarifaMenores7a12: Value(tarifaVPM.tarifaMenores7a12),
                  tarifaPaxAdicional: Value(tarifaVPM.tarifaPaxAdicional),
                ),
              );

          await database.into(database.temporada).insert(
                TemporadaCompanion.insert(
                  code: codeUniversal,
                  nombre: "Promoción ${tempProm.porcentajePromocion}%",
                  codeTarifa: Value(codeUniversal),
                  estanciaMinima: Value(tempProm.estanciaMinima),
                  fecha: Value(now),
                  porcentajePromocion: Value(tempProm.porcentajePromocion),
                ),
              );
          await database.into(database.temporada).insert(
                TemporadaCompanion.insert(
                  code: codeUniversal,
                  nombre: "BAR I",
                  codeTarifa: Value(codeUniversal),
                  estanciaMinima: Value(tempBar1.estanciaMinima),
                  fecha: Value(now),
                  porcentajePromocion: Value(tempBar1.porcentajePromocion),
                ),
              );
          await database.into(database.temporada).insert(
                TemporadaCompanion.insert(
                  code: codeUniversal,
                  nombre: "BAR II",
                  codeTarifa: Value(codeUniversal),
                  estanciaMinima: Value(tempBar2.estanciaMinima),
                  fecha: Value(now),
                  porcentajePromocion: Value(tempBar2.porcentajePromocion),
                ),
              );

          await database.into(database.tarifaRack).insert(
                TarifaRackCompanion.insert(
                  code: codeUniversal,
                  fecha: Value(now),
                  codePeriodo: Value(codeUniversal),
                  codeTemporada: Value(codeUniversal),
                  colorIdentificacion:
                      Value("#${colorIdentificativo.toHexString()}"),
                  nombreRack: Value(name),
                  usuarioId: Value(userId),
                ),
              );
        },
      );
      await database.close();
      return true;
    } catch (e) {
      print(e);
      await database.close();
      return false;
    }
  }

  Future<List<RegistroTarifa>> getTarifasBD() async {
    List<RegistroTarifa> tarifasRegistradas = [];
    List<TarifaRackData> tarifas = [];

    print("Recargando tarifas");

    final db = AppDatabase();

    try {
      tarifas = await db.getAllTarifasRack();
      await db.close();

      for (var tarifa in tarifas) {
        RegistroTarifa newRegistroTarifa = RegistroTarifa(
          code: tarifa.code,
          color: colorFromHex(tarifa.colorIdentificacion ?? '#ffffff'),
          fechaRegistro: tarifa.fecha,
          nombre: tarifa.nombreRack,
          userId: tarifa.usuarioId,
          id: tarifa.id,
        );

        final databaseQuery = AppDatabase();
        await databaseQuery.transaction(
          () async {
            newRegistroTarifa.periodos =
                await databaseQuery.getPeriodByCode(tarifa.code);

            newRegistroTarifa.temporadas =
                await databaseQuery.getSeasonByCode(tarifa.code);

            newRegistroTarifa.tarifas =
                await databaseQuery.getTariffByCode(tarifa.code);
          },
        );

        await databaseQuery.close();

        tarifasRegistradas.add(newRegistroTarifa);
      }
    } catch (e) {
      print(e);
      await db.close();
    }

    return tarifasRegistradas;
  }
}

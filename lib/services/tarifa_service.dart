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
    required List<Temporada> temporadas,
    required TarifaTemporada tarifaVR,
    required TarifaTemporada tarifaVPM,
  }) async {
    String codeUniversal =
        "${UniqueKey().hashCode.toString()}-$userId-$userName-${DateTime.now().toString()}";
    DateTime now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    final database = AppDatabase();

    try {
      await database.transaction(
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
                  tarifaAdultoCPLE: Value(tarifaVR.tarifaAdulto4),
                  tarifaAdultoTPL: Value(tarifaVR.tarifaAdulto3),
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
                  tarifaAdultoCPLE: Value(tarifaVPM.tarifaAdulto4),
                  tarifaAdultoTPL: Value(tarifaVPM.tarifaAdulto3),
                ),
              );

          for (var element in temporadas) {
            await database.into(database.temporada).insert(
                  TemporadaCompanion.insert(
                    code: codeUniversal,
                    nombre: element.nombre ?? '',
                    codeTarifa: Value(codeUniversal),
                    estanciaMinima: Value(element.estanciaMinima),
                    fecha: Value(now),
                    porcentajePromocion: Value(element.porcentajePromocion),
                    forGroup: Value(
                      element.forGroup,
                    ),
                  ),
                );
          }

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

  Future<bool> UpdateTarifaBD({
    required String name,
    required RegistroTarifa oldRegister,
    required String codeUniversal,
    required List<Periodo> periodos,
    required Color colorIdentificativo,
    required List<bool> diasAplicacion,
    required List<Temporada> temporadas,
    required TarifaTemporada tarifaVR,
    required TarifaTemporada tarifaVPM,
  }) async {
    final database = AppDatabase();
    DateTime now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    try {
      await database.transaction(
        () async {
          //Update periods
          for (var element in oldRegister.periodos!) {
            await database.deletePeriodByIDandCode(codeUniversal, element.id);
          }

          for (var element in periodos) {
            await database.into(database.periodo).insert(
                  PeriodoCompanion.insert(
                    code: codeUniversal,
                    fecha: Value(oldRegister.fechaRegistro),
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

          await database.updateTariff(
            codeUniv: codeUniversal,
            id: oldRegister.tarifas!.first.id,
            tarifaUpdate: TarifaCompanion(
              tarifaAdultoSGLoDBL: Value(tarifaVR.tarifaAdulto1a2),
              tarifaMenores7a12: Value(tarifaVR.tarifaMenores7a12),
              tarifaPaxAdicional: Value(tarifaVR.tarifaPaxAdicional),
              tarifaAdultoCPLE: Value(tarifaVR.tarifaAdulto4),
              tarifaAdultoTPL: Value(tarifaVR.tarifaAdulto3),
            ),
          );
          await database.updateTariff(
            codeUniv: codeUniversal,
            id: oldRegister.tarifas![1].id,
            tarifaUpdate: TarifaCompanion(
              tarifaAdultoSGLoDBL: Value(tarifaVPM.tarifaAdulto1a2),
              tarifaMenores7a12: Value(tarifaVPM.tarifaMenores7a12),
              tarifaPaxAdicional: Value(tarifaVPM.tarifaPaxAdicional),
              tarifaAdultoCPLE: Value(tarifaVPM.tarifaAdulto4),
              tarifaAdultoTPL: Value(tarifaVPM.tarifaAdulto3),
            ),
          );

          for (var element in oldRegister.temporadas!) {
            if (!temporadas.any((elementInt) =>
                elementInt.id != null && elementInt.id == element.id)) {
              await database.deleteSeasonByIDandCode(codeUniversal, element.id);
              print("Delete ${element.id}: ${element.nombre}");
            }
          }

          for (var element in temporadas) {
            if (element.id != null) {
              await database.updateSeason(
                tempUpdate: TemporadaCompanion(
                  estanciaMinima: Value(element.estanciaMinima),
                  porcentajePromocion: Value(element.porcentajePromocion),
                  forGroup: Value(
                    element.forGroup,
                  ),
                ),
                codeUniv: codeUniversal,
                id: element.id!,
              );
            } else {
              await database.into(database.temporada).insert(
                    TemporadaCompanion.insert(
                      code: codeUniversal,
                      nombre: element.nombre ?? '',
                      codeTarifa: Value(codeUniversal),
                      estanciaMinima: Value(element.estanciaMinima),
                      fecha: Value(now),
                      porcentajePromocion: Value(element.porcentajePromocion),
                    ),
                  );
            }
          }

          await database.updateTariffRack(
              tarifaUpdate: TarifaRackCompanion(
                colorIdentificacion:
                    Value("#${colorIdentificativo.toHexString()}"),
                nombreRack: Value(name),
              ),
              codeUniv: codeUniversal,
              id: oldRegister.id!);
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

  Future<bool> deleteTarifaRack(RegistroTarifa tarifa) async {
    final database = AppDatabase();

    try {
      await database.transaction(
        () async {
          //Update periods
          for (var element in tarifa.periodos!) {
            await database.deletePeriodByIDandCode(tarifa.code!, element.id);
          }

          for (var element in tarifa.tarifas!) {
            await database.deleteTariffByIDandCode(tarifa.code!, element.id);
          }

          for (var element in tarifa.temporadas!) {
            await database.deleteSeasonByIDandCode(tarifa.code!, element.id);
          }

          await database.deleteTariffRackByIDandCode(tarifa.code!, tarifa.id!);
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
          isSelected: true,
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

  Future<Politica?> getTariffPolicy() async {
    Politica? tariffPolicy;
    final db = AppDatabase();

    try {
      List<Politica> resp = await db.getTariffPolicy();
      if (resp.isNotEmpty) tariffPolicy = resp.first;
      await db.close();
    } catch (e) {
      print(e);
      await db.close();
    }

    return tariffPolicy;
  }

  Future<bool> saveTariffPolicy(Politica? policy) async {
    final database = AppDatabase();

    try {
      if (policy?.id != 0) {
        await database.updateTariffPolicy(politica: policy!, id: policy.id);
      } else {
        await database.into(database.politicas).insert(
              PoliticasCompanion.insert(
                fechaActualizacion: Value(DateTime.now()),
                intervaloHabitacionGratuita:
                    Value(policy?.intervaloHabitacionGratuita ?? 0),
                limiteHabitacionCotizacion:
                    Value(policy?.limiteHabitacionCotizacion ?? 0),
              ),
            );
      }
      await database.close();
      return true;
    } catch (e) {
      print(e);
      await database.close();
      return false;
    }
  }
}

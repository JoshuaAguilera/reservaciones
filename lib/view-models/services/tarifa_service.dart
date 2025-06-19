import 'dart:ui';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:generador_formato/database/dao/tarifa_base_dao.dart';
import 'package:generador_formato/database/dao/tarifa_dao.dart';
import 'package:generador_formato/models/periodo_model.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/models/tarifa_base_model.dart';
import 'package:generador_formato/models/tarifa_model.dart';
import 'package:generador_formato/models/temporada_model.dart';
import 'package:generador_formato/view-models/services/base_service.dart';
import 'package:generador_formato/res/helpers/constants.dart';
import 'package:generador_formato/res/helpers/utility.dart';

import '../../database/database.dart';

class TarifaService extends BaseService {
  Future<String> saveBaseTariff(TarifaBaseInt tarifaBase) async {
    String error = "";
    String codeBase = "${Utility.getUniqueCode()}-tarifaBase-$userId-$userName";
    DateTime now = DateTime.now();

    try {
      final database = AppDatabase();

      await database.transaction(
        () async {
          TarifaBaseTableData response =
              await database.into(database.tarifaBaseTable).insertReturning(
                    TarifaBaseTableCompanion.insert(
                      code: Value(codeBase),
                      descIntegrado: Value(tarifaBase.descIntegrado),
                      withAuto: Value(tarifaBase.withAuto),
                      nombre: Value(tarifaBase.nombre),
                      tarifaPadreId: Value(tarifaBase.tarifaPadre?.id),
                      tarifaOrigenId: Value(tarifaBase.tarifaOrigenId),
                      upgradeCategoria: Value(tarifaBase.upgradeCategoria),
                      upgradeMenor: Value(tarifaBase.upgradeMenor),
                      upgradePaxAdic: Value(tarifaBase.upgradePaxAdic),
                    ),
                  );

          for (var element in tarifaBase.tarifas!) {
            await database.into(database.tarifaTable).insert(
                  TarifaTableCompanion.insert(
                    code: Value(codeBase),
                    categoria: Value(element.categoria),
                    fecha: Value(now),
                    tarifaAdultoSGLoDBL: Value(element.tarifaAdulto1a2),
                    tarifaMenores7a12: Value(element.tarifaMenores7a12),
                    tarifaPaxAdicional: Value(element.tarifaPaxAdicional),
                    tarifaAdultoCPLE: Value(element.tarifaAdulto4),
                    tarifaAdultoTPL: Value(element.tarifaAdulto3),
                    tarifaPadreId: Value(response.id),
                  ),
                );
          }

          if (tarifaBase.upgradeCategoria != null) {
            Tarifa? secondTariff = tarifaBase.tarifas
                ?.where((element) => element.categoria == tipoHabitacion.first)
                .firstOrNull;

            double tariffAdultUpgrade = (secondTariff?.tarifaAdulto1a2 ?? 0) +
                (tarifaBase.upgradeCategoria ?? 0);

            double tariffPaxAdicUpgrade =
                (secondTariff?.tarifaPaxAdicional ?? 0) +
                    (tarifaBase.upgradePaxAdic ?? 0);

            double tariffMinorsUpgrade =
                (secondTariff?.tarifaMenores7a12 ?? 0) +
                    (tarifaBase.upgradeMenor ?? 0);

            await database.into(database.tarifaTable).insert(
                  TarifaTableCompanion.insert(
                    code: Value(codeBase),
                    categoria: Value(tipoHabitacion
                        .where((element) =>
                            element != tarifaBase.tarifas?.first.categoria)
                        .first),
                    fecha: Value(now),
                    tarifaAdultoSGLoDBL: Value(tariffAdultUpgrade),
                    tarifaPaxAdicional: Value(tariffPaxAdicUpgrade),
                    tarifaMenores7a12: Value(tariffMinorsUpgrade),
                    tarifaAdultoCPLE:
                        Value(tariffAdultUpgrade + (tariffPaxAdicUpgrade * 2)),
                    tarifaAdultoTPL:
                        Value(tariffAdultUpgrade + tariffPaxAdicUpgrade),
                    tarifaPadreId: Value(response.id),
                  ),
                );
          }
        },
      );

      await database.close();
    } catch (e) {
      error = e.toString();
    }

    return error;
  }

  Future<bool> saveTarifaBD({
    required String name,
    required List<Periodo> periodos,
    required Color colorIdentificativo,
    required List<bool> diasAplicacion,
    required List<Temporada> temporadas,
    required Tarifa tarifaVR,
    required Tarifa tarifaVPM,
    bool withBaseTariff = false,
  }) async {
    String codeRack =
        "${Utility.getUniqueCode()}-tarifa-rack-$userId-$userName";
    String codeSeason =
        "${Utility.getUniqueCode()}-temporada-$userId-$userName-${UniqueKey().hashCode}";
    String codePeriod = "${Utility.getUniqueCode()}-periodo-$userId-$userName";
    DateTime now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    String codeTariff = codeRack;

    if (withBaseTariff) {
      codeTariff = tarifaVR.code ?? codeTariff;
    }

    final database = AppDatabase();

    try {
      await database.transaction(
        () async {
          for (var element in periodos) {
            await database.into(database.periodoTable).insert(
                  PeriodoTableCompanion.insert(
                    code: codePeriod,
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

          if (!withBaseTariff) {
            await database.into(database.tarifaTable).insert(
                  TarifaTableCompanion.insert(
                    code: Value(codeTariff),
                    categoria: Value(tarifaVR.categoria),
                    fecha: Value(now),
                    tarifaAdultoSGLoDBL: Value(tarifaVR.tarifaAdulto1a2),
                    tarifaMenores7a12: Value(tarifaVR.tarifaMenores7a12),
                    tarifaPaxAdicional: Value(tarifaVR.tarifaPaxAdicional),
                    tarifaAdultoCPLE: Value(tarifaVR.tarifaAdulto4),
                    tarifaAdultoTPL: Value(tarifaVR.tarifaAdulto3),
                  ),
                );
            await database.into(database.tarifaTable).insert(
                  TarifaTableCompanion.insert(
                    code: Value(codeTariff),
                    categoria: Value(tarifaVPM.categoria),
                    fecha: Value(now),
                    tarifaAdultoSGLoDBL: Value(tarifaVPM.tarifaAdulto1a2),
                    tarifaMenores7a12: Value(tarifaVPM.tarifaMenores7a12),
                    tarifaPaxAdicional: Value(tarifaVPM.tarifaPaxAdicional),
                    tarifaAdultoCPLE: Value(tarifaVPM.tarifaAdulto4),
                    tarifaAdultoTPL: Value(tarifaVPM.tarifaAdulto3),
                  ),
                );
          }

          for (var element in temporadas) {
            print(element.nombre);

            String codeSeasonCash =
                "${Utility.getUniqueCode()}-temporada-${element.nombre}-${element.estanciaMinima}-${UniqueKey().hashCode}";

            if (element.forCash ?? false) {
              if ((element.tarifas ?? []).isNotEmpty) {
                for (var tariff in element.tarifas!) {
                  await database.into(database.tarifaTable).insert(
                        TarifaTableCompanion.insert(
                          code: Value(codeSeasonCash),
                          categoria: Value(tariff.categoria),
                          fecha: Value(now),
                          tarifaAdultoSGLoDBL: Value(tariff.tarifaAdulto1a2),
                          tarifaMenores7a12: Value(tariff.tarifaMenores7a12),
                          tarifaPaxAdicional: Value(tariff.tarifaPaxAdicional),
                          tarifaAdultoCPLE: Value(tariff.tarifaAdulto4),
                          tarifaAdultoTPL: Value(tariff.tarifaAdulto3),
                        ),
                      );
                }
              }
            }

            await database.into(database.temporadaTable).insert(
                  TemporadaTableCompanion.insert(
                    code: codeSeason,
                    nombre: element.nombre ?? '',
                    codeTarifa: Value(
                      ((element.forCash ?? false) &&
                              (element.tarifas ?? []).isNotEmpty)
                          ? codeSeasonCash
                          : codeTariff,
                    ),
                    estanciaMinima: Value(element.estanciaMinima),
                    fecha: Value(now),
                    porcentajePromocion: Value(element.porcentajePromocion),
                    forGroup: Value(element.forGroup),
                    forCash: Value(element.forCash),
                  ),
                );
          }

          await database.into(database.tarifaRackTable).insert(
                TarifaRackTableCompanion.insert(
                  code: codeRack,
                  fecha: Value(now),
                  codePeriodo: Value(codePeriod),
                  codeTemporada: Value(codeSeason),
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

  Future<bool> updateTarifaBD({
    required String name,
    required RegistroTarifa oldRegister,
    required List<Periodo> periodos,
    required Color colorIdentificativo,
    required List<bool> diasAplicacion,
    required List<Temporada> temporadas,
    required Tarifa tarifaVR,
    required Tarifa tarifaVPM,
    required bool withBaseTariff,
  }) async {
    final database = AppDatabase();
    DateTime now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    String codeTariff = oldRegister.code!;
    bool withPastBaseTariff =
        oldRegister.tarifas?.any((element) => element.tarifaPadreId == null) ??
            false;

    try {
      final tarifaDao = TarifaDao(database);
      await database.transaction(
        () async {
          //Update periods
          for (var element in oldRegister.periodos!) {
            await database.deletePeriodByIDandCode(
                oldRegister.codePeriod ?? '', element.id);
          }

          for (var element in periodos) {
            await database.into(database.periodoTable).insert(
                  PeriodoTableCompanion.insert(
                    code: oldRegister.codePeriod ?? oldRegister.code ?? '',
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

          if (!withBaseTariff) {
            if (!withPastBaseTariff) {
              await database.into(database.tarifaTable).insert(
                    TarifaTableCompanion.insert(
                      code: Value(codeTariff),
                      categoria: Value(tarifaVR.categoria),
                      fecha: Value(now),
                      tarifaAdultoSGLoDBL: Value(tarifaVR.tarifaAdulto1a2),
                      tarifaMenores7a12: Value(tarifaVR.tarifaMenores7a12),
                      tarifaPaxAdicional: Value(tarifaVR.tarifaPaxAdicional),
                      tarifaAdultoCPLE: Value(tarifaVR.tarifaAdulto4),
                      tarifaAdultoTPL: Value(tarifaVR.tarifaAdulto3),
                    ),
                  );
              await database.into(database.tarifaTable).insert(
                    TarifaTableCompanion.insert(
                      code: Value(codeTariff),
                      categoria: Value(tarifaVPM.categoria),
                      fecha: Value(now),
                      tarifaAdultoSGLoDBL: Value(tarifaVPM.tarifaAdulto1a2),
                      tarifaMenores7a12: Value(tarifaVPM.tarifaMenores7a12),
                      tarifaPaxAdicional: Value(tarifaVPM.tarifaPaxAdicional),
                      tarifaAdultoCPLE: Value(tarifaVPM.tarifaAdulto4),
                      tarifaAdultoTPL: Value(tarifaVPM.tarifaAdulto3),
                    ),
                  );
            } else {
              await database.updateTariff(
                codeTariff: oldRegister.code ?? '',
                id: oldRegister.tarifas!.first.id,
                tarifaUpdate: TarifaTableCompanion(
                  tarifaAdultoSGLoDBL: Value(tarifaVR.tarifaAdulto1a2),
                  tarifaMenores7a12: Value(tarifaVR.tarifaMenores7a12),
                  tarifaPaxAdicional: Value(tarifaVR.tarifaPaxAdicional),
                  tarifaAdultoCPLE: Value(tarifaVR.tarifaAdulto4),
                  tarifaAdultoTPL: Value(tarifaVR.tarifaAdulto3),
                ),
              );
              await database.updateTariff(
                codeTariff: oldRegister.code ?? '',
                id: oldRegister.tarifas!.last.id,
                tarifaUpdate: TarifaTableCompanion(
                  tarifaAdultoSGLoDBL: Value(tarifaVPM.tarifaAdulto1a2),
                  tarifaMenores7a12: Value(tarifaVPM.tarifaMenores7a12),
                  tarifaPaxAdicional: Value(tarifaVPM.tarifaPaxAdicional),
                  tarifaAdultoCPLE: Value(tarifaVPM.tarifaAdulto4),
                  tarifaAdultoTPL: Value(tarifaVPM.tarifaAdulto3),
                ),
              );
            }
          } else {
            codeTariff = tarifaVR.code ?? codeTariff;
            if (withPastBaseTariff) {
              tarifaDao.deleteByCode(oldRegister.code ?? '');
            }
          }

          for (var element in oldRegister.temporadas!) {
            if (!temporadas.any((elementInt) =>
                elementInt.id != null && elementInt.id == element.id)) {
              if (element.forCash ?? false) {
                await tarifaDao.deleteByCode(element.codeTarifa ?? '');
              }

              await database.deleteSeasonByIDandCode(
                  oldRegister.codeSeason ?? '', element.id!);
              print("Delete ${element.id}: ${element.nombre}");
            }
          }

          for (var element in temporadas) {
            bool applyNewCashTariff = false;
            bool applyBaseTariff = false;
            bool isCash = (element.forCash ?? false);

            String codeSeasonCash =
                "${Utility.getUniqueCode()}-temporada-${element.nombre}-${element.estanciaMinima}-${UniqueKey().hashCode}";

            if (element.id != null) {
              String codeSeasonTariff = codeTariff;

              if (isCash && element.porcentajePromocion != null) {
                if (element.tarifas?.first.code != codeTariff &&
                    withBaseTariff) {
                  await tarifaDao.deleteByCode(element.codeTarifa ?? '');
                }
                applyBaseTariff = true;
              } else if ((element.tarifas ?? []).isNotEmpty && isCash) {
                for (var tarifa in element.tarifas!) {
                  if (tarifa.id != null && tarifa.code != codeTariff) {
                    database.updateTariff(
                      tarifaUpdate: TarifaTableCompanion(
                        tarifaAdultoSGLoDBL: Value(tarifa.tarifaAdulto1a2),
                        tarifaAdultoTPL: Value(tarifa.tarifaAdulto3),
                        tarifaAdultoCPLE: Value(tarifa.tarifaAdulto4),
                        tarifaMenores7a12: Value(tarifa.tarifaMenores7a12),
                        tarifaPaxAdicional: Value(tarifa.tarifaPaxAdicional),
                      ),
                      codeTariff: tarifa.code!,
                      id: tarifa.id!,
                    );
                  } else {
                    applyNewCashTariff = true;
                    await database.into(database.tarifaTable).insert(
                          TarifaTableCompanion.insert(
                            code: Value(codeSeasonCash),
                            categoria: Value(tarifa.categoria),
                            fecha: Value(now),
                            tarifaAdultoSGLoDBL: Value(tarifa.tarifaAdulto1a2),
                            tarifaMenores7a12: Value(tarifa.tarifaMenores7a12),
                            tarifaPaxAdicional:
                                Value(tarifa.tarifaPaxAdicional),
                            tarifaAdultoCPLE: Value(tarifa.tarifaAdulto4),
                            tarifaAdultoTPL: Value(tarifa.tarifaAdulto3),
                          ),
                        );
                  }
                }
              }

              if (isCash) codeSeasonTariff = element.codeTarifa!;
              if (applyBaseTariff && isCash) codeSeasonTariff = codeTariff;
              if (applyNewCashTariff) codeSeasonTariff = codeSeasonCash;

              await database.updateSeason(
                tempUpdate: TemporadaTableCompanion(
                  nombre: Value(element.nombre ?? ''),
                  codeTarifa: Value(codeSeasonTariff),
                  estanciaMinima: Value(element.estanciaMinima),
                  porcentajePromocion: Value(element.porcentajePromocion),
                ),
                codeUniv: oldRegister.codeSeason ?? oldRegister.code ?? '',
                id: element.id!,
              );
              continue;
            }

            if (isCash) {
              if ((element.tarifas ?? []).isNotEmpty) {
                for (var tariff in element.tarifas!) {
                  await database.into(database.tarifaTable).insert(
                        TarifaTableCompanion.insert(
                          code: Value(codeSeasonCash),
                          categoria: Value(tariff.categoria),
                          fecha: Value(now),
                          tarifaAdultoSGLoDBL: Value(tariff.tarifaAdulto1a2),
                          tarifaMenores7a12: Value(tariff.tarifaMenores7a12),
                          tarifaPaxAdicional: Value(tariff.tarifaPaxAdicional),
                          tarifaAdultoCPLE: Value(tariff.tarifaAdulto4),
                          tarifaAdultoTPL: Value(tariff.tarifaAdulto3),
                        ),
                      );
                }
              }
            }

            await database.into(database.temporadaTable).insert(
                  TemporadaTableCompanion.insert(
                    code: oldRegister.codeSeason ?? oldRegister.code ?? '',
                    nombre: element.nombre ?? '',
                    codeTarifa: Value(
                      ((element.forCash ?? false) &&
                              (element.tarifas ?? []).isNotEmpty)
                          ? codeSeasonCash
                          : codeTariff,
                    ),
                    estanciaMinima: Value(element.estanciaMinima),
                    fecha: Value(now),
                    porcentajePromocion: Value(element.porcentajePromocion),
                    forGroup: Value(element.forGroup),
                    forCash: Value(element.forCash),
                  ),
                );
          }

          await database.updateTariffRack(
            tarifaUpdate: TarifaRackTableCompanion(
              colorIdentificacion:
                  Value("#${colorIdentificativo.toHexString()}"),
              nombreRack: Value(name),
            ),
            codeUniv: oldRegister.code ?? '',
            id: oldRegister.id!,
          );
        },
      );
      await tarifaDao.close();
      await database.close();
      return true;
    } catch (e) {
      print(e);
      await database.close();
      return false;
    }
  }

  Future<String> updateBaseTariff(TarifaBaseInt tarifaBase,
      {bool propageChanges = false}) async {
    String response = '';

    try {
      final database = AppDatabase();
      final tarifaBaseDao = TarifaBaseDao(database);
      final tarifaDao = TarifaDao(database);
      Tarifa? saveTariff;

      List<Tarifa> tarifasRegister =
          tarifaBase.tarifas?.map((element) => element.copyWith()).toList() ??
              [];
      await database.transaction(
        () async {
          TarifaBaseTableData tarifaBaseNueva = TarifaBaseTableData(
            id: tarifaBase.id!,
            descIntegrado: tarifaBase.descIntegrado,
            nombre: tarifaBase.nombre,
            tarifaPadreId: tarifaBase.tarifaPadre?.id,
            upgradeCategoria: tarifaBase.upgradeCategoria,
            upgradeMenor: tarifaBase.upgradeMenor,
            upgradePaxAdic: tarifaBase.upgradePaxAdic,
            tarifaOrigenId: tarifaBase.tarifaOrigenId,
            withAuto: tarifaBase.withAuto,
          );

          await tarifaBaseDao.updateBaseTariff(
            baseTariff: tarifaBaseNueva,
            code: tarifaBase.code!,
            id: tarifaBase.id!,
          );
          if (tarifaBase.upgradeCategoria != null) {
            Tarifa? secondTariff = tarifasRegister
                .where((element) => element.categoria == tipoHabitacion.first)
                .firstOrNull;

            double tariffAdultUpgrade = (secondTariff?.tarifaAdulto1a2 ?? 0) +
                (tarifaBase.upgradeCategoria ?? 0);

            double tariffPaxAdicUpgrade =
                (secondTariff?.tarifaPaxAdicional ?? 0) +
                    (tarifaBase.upgradePaxAdic ?? 0);

            double tariffMinorsUpgrade =
                (secondTariff?.tarifaMenores7a12 ?? 0) +
                    (tarifaBase.upgradeMenor ?? 0);

            saveTariff = Tarifa();
            saveTariff?.tarifaAdulto1a2 = tariffAdultUpgrade;
            saveTariff?.tarifaAdulto3 =
                tariffAdultUpgrade + tariffPaxAdicUpgrade;
            saveTariff?.tarifaAdulto4 =
                tariffAdultUpgrade + (tariffPaxAdicUpgrade * 2);
            saveTariff?.tarifaMenores7a12 = tariffMinorsUpgrade;
            saveTariff?.tarifaPaxAdicional = tariffPaxAdicUpgrade;
            saveTariff?.categoria = tipoHabitacion.last;
            saveTariff?.tarifaBaseId = tarifaBase.id;
            saveTariff?.id = tarifasRegister
                .firstWhere(
                    (element) => element.categoria == tipoHabitacion.last)
                .id;

            await tarifaDao.updateForBaseTariff(
              tarifaData: TarifaTableCompanion(
                tarifaAdultoSGLoDBL: Value(saveTariff?.tarifaAdulto1a2),
                tarifaPaxAdicional: Value(saveTariff?.tarifaPaxAdicional),
                tarifaMenores7a12: Value(saveTariff?.tarifaMenores7a12),
                tarifaAdultoCPLE: Value(saveTariff?.tarifaAdulto3),
                tarifaAdultoTPL: Value(saveTariff?.tarifaAdulto4),
              ),
              baseTariffId: tarifaBase.id!,
              id: tarifasRegister
                      .firstWhere(
                          (element) => element.categoria == tipoHabitacion.last)
                      .id ??
                  0,
            );

            tarifasRegister.removeWhere(
                (element) => element.categoria != tipoHabitacion.first);
          }
          for (var element in tarifasRegister) {
            await tarifaDao.updateForBaseTariff(
              tarifaData: TarifaTableCompanion(
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

          if (propageChanges) {
            if (saveTariff != null) {
              tarifasRegister.add(saveTariff!);
            }

            await tarifaBaseDao.propageChangesTariff(
              baseTariff: tarifaBaseNueva,
              tarifasBase: tarifasRegister,
            );
          }
        },
      );
      await database.close();
    } catch (e) {
      print(e);
      response = (e.toString());
    }

    return response;
  }

  Future<bool> deleteTarifaRack(RegistroTarifa tarifa) async {
    final database = AppDatabase();
    final tarifaDao = TarifaDao(database);
    try {
      await database.transaction(
        () async {
          //Update periods
          for (var element in tarifa.periodos!) {
            await database.deletePeriodByIDandCode(
                tarifa.codePeriod ?? '', element.id);
          }

          for (var element in tarifa.tarifas!) {
            await database.deleteTariffByIDandCode(
                tarifa.code ?? '', element.id);
          }

          for (var element in tarifa.temporadas!) {
            if ((element.forCash ?? false) &&
                element.porcentajePromocion == null) {
              tarifaDao.deleteByCode(element.codeTarifa ?? '');
            }
            if (element.id != null) {
              await database.deleteSeasonByIDandCode(
                  tarifa.codeSeason ?? '', element.id!);
            }
          }

          await database.deleteTariffRackByIDandCode(tarifa.code!, tarifa.id!);
        },
      );
      await tarifaDao.close();
      await database.close();
      return true;
    } catch (e) {
      print(e);
      await tarifaDao.close();
      await database.close();
      return false;
    }
  }

  Future<List<RegistroTarifa>> getTarifasBD() async {
    List<RegistroTarifa> tarifasRegistradas = [];
    List<TarifaRackTableData> tarifas = [];

    print("Recargando tarifas");

    final db = AppDatabase();

    try {
      tarifas = await db.getAllTarifasRack();
      await db.close();

      for (var tarifa in tarifas) {
        RegistroTarifa newRegistroTarifa = RegistroTarifa(
          isSelected: true,
          code: tarifa.code,
          codeSeason: tarifa.codeTemporada,
          codePeriod: tarifa.codePeriodo,
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
                await databaseQuery.getPeriodByCode(tarifa.codePeriodo ?? '');

            newRegistroTarifa.temporadas = Utility.getTemporadas(
                await databaseQuery
                    .getSeasonByCode(tarifa.codeTemporada ?? ''));

            newRegistroTarifa.tarifas = await databaseQuery.getTariffByCode(
                newRegistroTarifa.temporadas?.first.codeTarifa ?? '');

            final tarifaDao = TarifaDao(databaseQuery);

            for (var temporada
                in newRegistroTarifa.temporadas ?? List<Temporada>.empty()) {
              if (temporada.forCash ?? false) {
                temporada.tarifas = await tarifaDao
                    .getTarifasByCode(temporada.codeTarifa ?? '');

                if (newRegistroTarifa.temporadas
                        ?.where((element) => !(element.forCash ?? false))
                        .firstOrNull
                        ?.codeTarifa ==
                    temporada.codeTarifa) {
                  temporada.useTariff = true;
                }
              }
            }

            tarifaDao.close();
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

  Future<List<TarifaBaseInt>> getBaseTariff() async {
    List<TarifaBaseInt> tarifasBase = [];

    try {
      final db = AppDatabase();
      final tarifaBaseDao = TarifaBaseDao(db);
      tarifasBase = await tarifaBaseDao.getBaseTariffComplement();
      await db.close();
      await tarifaBaseDao.close();
    } catch (e) {
      print(e);
    }

    return tarifasBase;
  }

  Future<String> deleteBaseTariff(TarifaBaseInt tarifaBase) async {
    String response = "";
    try {
      final database = AppDatabase();
      final tarifaBaseDao = TarifaBaseDao(database);
      final tarifaDao = TarifaDao(database);
      await database.transaction(
        () async {
          await tarifaDao.removeBaseTariff(tarifaBase.id!);
          await tarifaBaseDao.deleteBaseTariff(tarifaBase);
        },
      );
      await database.close();
    } catch (e) {
      response = (e.toString());
    }

    return response;
  }

  Future<PoliticaTableData?> getTariffPolicy() async {
    PoliticaTableData? tariffPolicy;
    final db = AppDatabase();

    try {
      List<PoliticaTableData> resp = await db.getTariffPolicy();
      if (resp.isNotEmpty) tariffPolicy = resp.first;
      await db.close();
    } catch (e) {
      print(e);
      await db.close();
    }

    return tariffPolicy;
  }

  Future<bool> saveTariffPolicy(PoliticaTableData? policy) async {
    final database = AppDatabase();

    try {
      if (policy?.id != 0) {
        await database.updateTariffPolicy(politica: policy!, id: policy.id);
      } else {
        await database.into(database.politicaTable).insert(
              PoliticaTableCompanion.insert(
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

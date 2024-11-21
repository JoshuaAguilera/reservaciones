import 'package:flutter/material.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/models/temporada_model.dart';
import 'package:generador_formato/services/tarifa_service.dart';
import 'package:riverpod/riverpod.dart';

final editTarifaProvider =
    StateProvider<RegistroTarifa>((ref) => RegistroTarifa());

final allTarifaProvider =
    FutureProvider.family<List<RegistroTarifa>, String>((ref, arg) async {
  final detectChanged = ref.watch(changeTarifasProvider);
  final list = await TarifaService().getTarifasBD();
  return list;
});

final listTarifaProvider =
    FutureProvider.family<List<RegistroTarifa>, String>((ref, arg) {
  final detectChanged = ref.watch(changeTarifasListProvider);
  final todos = ref.watch(allTarifaProvider('')).asData;
  return todos!.value;
});

final tariffPolicyProvider =
    FutureProvider.family<Politica?, String>((ref, arg) async {
  final detectChanged = ref.watch(changeTariffPolicyProvider);
  final list = await TarifaService().getTariffPolicy();
  return list;
});

final changeTarifasProvider = StateProvider<int>((ref) => 0);

final changeTarifasListProvider = StateProvider<int>((ref) => 0);

final changeTariffPolicyProvider = StateProvider<int>((ref) => 0);

final selectedModeViewProvider =
    StateProvider<List<bool>>((ref) => <bool>[true, false, false]);

final temporadasIndividualesProvider = StateProvider<List<Temporada>>((ref) => [
      Temporada(nombre: "Promoción", editable: false),
      Temporada(nombre: "BAR I", editable: false),
      Temporada(nombre: "BAR II", editable: false),
    ]);

final temporadasGrupalesProvider = StateProvider<List<Temporada>>((ref) => [
      // Temporada(
      //   nombre: "Grupos",
      //   editable: false,
      //   forGroup: true,
      // ),
    ]);

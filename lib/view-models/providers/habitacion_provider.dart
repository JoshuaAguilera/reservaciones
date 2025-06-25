import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../database/database.dart';
import '../../models/cotizacion_model.dart';
import '../../models/habitacion_model.dart';
import '../../models/registro_tarifa_model.dart';
import '../../models/tarifa_x_dia_model.dart';
import '../../res/helpers/utility.dart';
import '../services/generador_doc_service.dart';
import 'tarifario_provider.dart';

class HabitacionProvider extends Notifier<List<Habitacion>> {
  @override
  List<Habitacion> build() => [];

  Habitacion _current = Habitacion();
  Habitacion get current => _current;
  late pw.Document pdfPrinc;

  void addItem(Habitacion item, bool groupQuote) {
    _current = item;
    state = [...state, item];
    if (state.length > 1) revisedFreeRooms();

    if (groupQuote) implementGroupTariff([]);
  }

  void addFreeItem(Habitacion habitacion, int interval) {
    int rooms = 0;
    int freeRooms = 0;
    for (var element in state) {
      if (!element.esCortesia) {
        rooms += element.count;
      } else {
        freeRooms++;
      }
    }

    int freeRoomsValid = rooms ~/ interval;

    Habitacion item = habitacion.CopyWith();
    item.esCortesia = true;
    item.count = 1;

    for (var room = freeRooms; room < freeRoomsValid; room++) {
      _current = item;
      state = [...state, item];
    }

    ref.notifyListeners();
  }

  void revisedFreeRooms() {
    final politicaTarifaProvider = ref.watch(tariffPolicyProvider(""));
    politicaTarifaProvider.when(
      data: (data) {
        if (data != null) {
          int rooms = 0;
          List<Habitacion> freeRooms = [];
          for (var element in state) {
            if (!element.esCortesia) {
              rooms += element.count;
            } else {
              freeRooms.add(element);
            }
          }

          int freeRoomsValid = rooms ~/ data.intervaloHabitacionGratuita!;

          if (rooms >= data.intervaloHabitacionGratuita!) {
            for (var element in freeRooms) {
              if (!state.any((element2) =>
                  !element2.esCortesia &&
                  element2.id == element.id)) {
                state.remove(element);
              }
            }

            if (freeRoomsValid >=
                state.where((element) => element.esCortesia).toList().length) {
              addFreeItem(
                  state.reduce((value, element) =>
                      value.count > element.count ? value : element),
                  data.intervaloHabitacionGratuita!);
            }
          } else {
            state.removeWhere((element) => element.esCortesia);
          }

          ref.notifyListeners();
        } else {
          print("Politicas no encontradas");
        }
      },
      error: (error, stackTrace) {
        print("Politicas no encontradas");
      },
      loading: () {
        print("Cargando politicas");
      },
    );
  }

  void editItem(String? folio, Habitacion item) {
    int index = state.indexWhere((element) => element.id == folio);
    if (index != -1) {
      state[index] = item;

      if (state.any((element) =>
          element.id == state[index].id)) {
        Habitacion roomEdit = item.CopyWith();
        roomEdit.esCortesia = true;
        for (var element in state.where((element) =>
            element.id == state[index].id &&
            element.esCortesia)) {
          state[state.indexOf(element)] = roomEdit;
        }
      }
    } else {
      print("Error al editar Habitacion");
    }
  }

  void remove(String folio) {
    state.removeWhere((element) => element.id == folio);
    ref.notifyListeners();
    revisedFreeRooms();
  }

  void removeFreeItem(int intervalo, String folio) {
    int rooms = 0;
    int freeRooms = 0;
    for (var element in state) {
      if (!element.esCortesia) {
        rooms += element.count;
      } else {
        freeRooms++;
      }
    }

    int freeRoomsValid = rooms ~/ intervalo;

    if (freeRoomsValid > 0) {
      for (var room = freeRooms; room > freeRoomsValid; room--) {
        if (state.any(
            (element) => element.id == folio && element.esCortesia)) {
          state.remove(state.firstWhere(
              (element) => element.id == folio && element.esCortesia));
        } else {
          state.remove(state.firstWhere((element) => element.esCortesia));
        }
      }
    } else {
      state.removeWhere((element) => element.esCortesia);
    }
    ref.notifyListeners();
  }

  void changedFreeRoom(String folio, {int indexRoom = -1}) {
    Habitacion newFreeRoom = state
        .firstWhere((element) =>
            !element.esCortesia &&
            (indexRoom != -1
                ? element.id == folio
                : element.id != folio))
        .CopyWith();

    newFreeRoom.esCortesia = true;
    newFreeRoom.count = 1;

    if (indexRoom != -1) {
      state[indexRoom] = newFreeRoom;
      ref.notifyListeners();
    } else {
      state.remove(state.firstWhere((element) => element.esCortesia));
      state = [...state, newFreeRoom];
    }
  }

  void clear() => state = [];

  void implementGroupTariff(List<TarifaXDia?> selectTariffs) {
    for (var item in state) {
      if (selectTariffs.isNotEmpty) {
        TarifaXDia? selectTariff = selectTariffs.firstWhere(
          (element) => element?.folioRoom == item.id,
          orElse: () => null,
        );

        if (selectTariff != null &&
            (selectTariff.tarifasBase ?? []).isNotEmpty) {
          selectTariff.tarifas = selectTariff.tarifasBase;
          selectTariff.tarifa = selectTariff.tarifasBase
              ?.where((element) => element.categoria == item.categoria)
              .toList()
              .firstOrNull;
        }

        selectTariff?.numDays = item.tarifasXHabitacion?.length ?? 0;

        item.tarifaGrupal = selectTariff;
        continue;
      }

      if (item.tarifaGrupal == null) {
        List<TarifaXDia> filterTariffs =
            Utility.getUniqueTariffs(item.tarifasXHabitacion!);
        TarifaXDia? tarifaGrupo =
            filterTariffs.reduce(((a, b) => a.numDays > b.numDays ? a : b));

        tarifaGrupo.temporadaSelect = Utility.getSeasonNow(
          RegistroTarifa(temporadas: tarifaGrupo.temporadas),
          DateTime.parse(item.checkOut!)
              .difference(DateTime.parse(item.checkIn!))
              .inDays,
          isGroup: true,
        );

        tarifaGrupo.numDays = item.tarifasXHabitacion?.length ?? 0;

        item.tarifaGrupal = tarifaGrupo;
      }
    }

    ref.notifyListeners();
  }

  void removeGroupTariff() {
    for (var item in state) {
      item.tarifaGrupal = null;
    }
    ref.notifyListeners();
  }

  Future<pw.Document> generarComprobante(
      Cotizacion cotizacion, bool typeQuote) async {
    if (!typeQuote) {
      return pdfPrinc =
          await GeneradorDocService().generarComprobanteCotizacionIndividual(
        habitaciones: state,
        cotizacion: cotizacion,
        isDirect: true,
      );
    } else {
      return pdfPrinc =
          await GeneradorDocService().generarComprobanteCotizacionGrupal(
        habitaciones: state,
        cotizacion: cotizacion,
        isDirect: true,
      );
    }
  }

  //Definición del provider
  static final provider =
      NotifierProvider<HabitacionProvider, List<Habitacion>>(
          HabitacionProvider.new);
}

final habitacionSelectProvider =
    StateProvider<Habitacion>((ref) => Habitacion());

final detectChangeProvider = StateProvider<int>((ref) => 0);

final listTariffDayProvider = FutureProvider<List<TarifaXDia>>((ref) async {
  final detectChanged = ref.watch(detectChangeProvider);
  final list = ref.watch(habitacionSelectProvider).tarifasXHabitacion ?? [];
  return list;
});

final useCashSeasonProvider = StateProvider<bool>((ref) => false);
final useCashSeasonRoomProvider = StateProvider<bool>((ref) => false);
final typeQuoteProvider = StateProvider<bool>((ref) => false);
final showManagerTariffGroupProvider = StateProvider<bool>((ref) => false);

final detectChangeRoomProvider = StateProvider<int>((ref) => 0);

final listRoomProvider = FutureProvider<List<Habitacion>>((ref) async {
  final detectChanged = ref.watch(detectChangeRoomProvider);
  final list = ref.watch(HabitacionProvider.provider);
  return list;
});

class TarifasProvisionalesProvider
    extends StateNotifier<List<TarifaTableData>> {
  TarifasProvisionalesProvider() : super([]);

  static final provider = StateNotifierProvider<TarifasProvisionalesProvider,
      List<TarifaTableData>>((ref) => TarifasProvisionalesProvider());

  TarifaTableData _current = const TarifaTableData(id: 0, code: "");
  TarifaTableData get current => _current;

  void addItem(TarifaTableData item) {
    _current = item;
    state = [...state, item];
  }

  void remove(String categoria) =>
      state = [...state.where((element) => element.categoria != categoria)];

  void clear() => state = [];

  void addAll(List<TarifaTableData> items) {
    state = items;
  }
}

final descuentoProvisionalProvider = StateProvider<double>((ref) => 0);

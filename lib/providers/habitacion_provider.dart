import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/tarifa_x_dia_model.dart';
import 'package:generador_formato/services/generador_doc_service.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/registro_tarifa_model.dart';
import '../utils/helpers/utility.dart';
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
      if (!element.isFree) {
        rooms += element.count;
      } else {
        freeRooms++;
      }
    }

    int freeRoomsValid = rooms ~/ interval;

    Habitacion item = habitacion.CopyWith();
    item.isFree = true;
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
            if (!element.isFree) {
              rooms += element.count;
            } else {
              freeRooms.add(element);
            }
          }

          int freeRoomsValid = rooms ~/ data.intervaloHabitacionGratuita!;

          if (rooms >= data.intervaloHabitacionGratuita!) {
            for (var element in freeRooms) {
              if (!state.any((element2) =>
                  !element2.isFree &&
                  element2.folioHabitacion == element.folioHabitacion)) {
                state.remove(element);
              }
            }

            if (freeRoomsValid >=
                state.where((element) => element.isFree).toList().length) {
              addFreeItem(
                  state.reduce((value, element) =>
                      value.count > element.count ? value : element),
                  data.intervaloHabitacionGratuita!);
            }
          } else {
            state.removeWhere((element) => element.isFree);
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
    int index = state.indexWhere((element) => element.folioHabitacion == folio);
    if (index != -1) {
      state[index] = item;

      if (state.any((element) =>
          element.folioHabitacion == state[index].folioHabitacion)) {
        Habitacion roomEdit = item.CopyWith();
        roomEdit.isFree = true;
        for (var element in state.where((element) =>
            element.folioHabitacion == state[index].folioHabitacion &&
            element.isFree)) {
          state[state.indexOf(element)] = roomEdit;
        }
      }
    } else {
      print("Error al editar Habitacion");
    }
  }

  void remove(String folio) {
    state.removeWhere((element) => element.folioHabitacion == folio);
    ref.notifyListeners();
    revisedFreeRooms();
  }

  void removeFreeItem(int intervalo, String folio) {
    int rooms = 0;
    int freeRooms = 0;
    for (var element in state) {
      if (!element.isFree) {
        rooms += element.count;
      } else {
        freeRooms++;
      }
    }

    int freeRoomsValid = rooms ~/ intervalo;

    if (freeRoomsValid > 0) {
      for (var room = freeRooms; room > freeRoomsValid; room--) {
        if (state.any(
            (element) => element.folioHabitacion == folio && element.isFree)) {
          state.remove(state.firstWhere(
              (element) => element.folioHabitacion == folio && element.isFree));
        } else {
          state.remove(state.firstWhere((element) => element.isFree));
        }
      }
    } else {
      state.removeWhere((element) => element.isFree);
    }
    ref.notifyListeners();
  }

  void changedFreeRoom(String folio, {int indexRoom = -1}) {
    Habitacion newFreeRoom = state
        .firstWhere((element) =>
            !element.isFree &&
            (indexRoom != -1
                ? element.folioHabitacion == folio
                : element.folioHabitacion != folio))
        .CopyWith();

    newFreeRoom.isFree = true;
    newFreeRoom.count = 1;

    if (indexRoom != -1) {
      state[indexRoom] = newFreeRoom;
      ref.notifyListeners();
    } else {
      state.remove(state.firstWhere((element) => element.isFree));
      state = [...state, newFreeRoom];
    }
  }

  void clear() => state = [];

  void implementGroupTariff(List<TarifaXDia?> selectTariffs) {
    for (var item in state) {
      if (selectTariffs.isNotEmpty) {
        TarifaXDia? selectTariff = selectTariffs.firstWhere(
          (element) => element?.folioRoom == item.folioHabitacion,
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

        item.tarifaGrupal = selectTariff;
        continue;
      }

      if (item.tarifaGrupal == null) {
        List<TarifaXDia> filterTariffs =
            Utility.getUniqueTariffs(item.tarifaXDia!);
        TarifaXDia? tarifaGrupo =
            filterTariffs.reduce(((a, b) => a.numDays > b.numDays ? a : b));

        tarifaGrupo.temporadaSelect = Utility.getSeasonNow(
          RegistroTarifa(temporadas: tarifaGrupo.temporadas),
          DateTime.parse(item.fechaCheckOut!)
              .difference(DateTime.parse(item.fechaCheckIn!))
              .inDays,
          isGroup: true,
        );

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
      return pdfPrinc = await GeneradorDocService()
          .generarComprobanteCotizacionIndividual(
              habitaciones: state, cotizacion: cotizacion);
    } else {
      return pdfPrinc = await GeneradorDocService()
          .generarComprobanteCotizacionGrupal(
              habitaciones: state, cotizacion: cotizacion);
    }
  }

  //Definición del provider
  static final provider =
      NotifierProvider<HabitacionProvider, List<Habitacion>>(
          HabitacionProvider.new);
}

final totalRoomsProvider = Provider<int>((ref) {
  int total = 0;
  List<Habitacion> rooms = ref
      .watch(HabitacionProvider.provider)
      .where((todo) => !todo.isFree)
      .toList();

  for (var element in rooms) {
    total += element.count;
  }

  return total;
});

final habitacionSelectProvider =
    StateProvider<Habitacion>((ref) => Habitacion());

final detectChangeProvider = StateProvider<int>((ref) => 0);

final listTariffDayProvider = FutureProvider<List<TarifaXDia>>((ref) async {
  final detectChanged = ref.watch(detectChangeProvider);
  final list = ref.watch(habitacionSelectProvider).tarifaXDia ?? [];
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

class TarifasProvisionalesProvider extends StateNotifier<List<TarifaData>> {
  TarifasProvisionalesProvider() : super([]);

  static final provider =
      StateNotifierProvider<TarifasProvisionalesProvider, List<TarifaData>>(
          (ref) => TarifasProvisionalesProvider());

  TarifaData _current = const TarifaData(id: 0, code: "");
  TarifaData get current => _current;

  void addItem(TarifaData item) {
    _current = item;
    state = [...state, item];
  }

  void remove(String categoria) =>
      state = [...state.where((element) => element.categoria != categoria)];

  void clear() => state = [];

  void addAll(List<TarifaData> items) {
    state = items;
  }
}

final descuentoProvisionalProvider = StateProvider<double>((ref) => 0);

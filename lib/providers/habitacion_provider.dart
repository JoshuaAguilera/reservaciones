import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/tarifa_x_dia_model.dart';
import 'package:generador_formato/services/generador_doc_service.dart';
import 'package:pdf/widgets.dart' as pw;

import 'tarifario_provider.dart';

class HabitacionProvider extends Notifier<List<Habitacion>> {
  @override
  List<Habitacion> build() => [];

  Habitacion _current = Habitacion();
  Habitacion get current => _current;
  late pw.Document pdfPrinc;

  void addItem(Habitacion item) {
    _current = item;
    state = [...state, item];
  }

  void addFreeItem(Habitacion habitacion, int interval) {
    int rooms = 0;
    for (var element in state) {
      if (!element.isFree) rooms += element.count;
    }

    int freeRoomsValid = rooms ~/ interval;

    if (state.any((element) =>
        element.isFree &&
        element.folioHabitacion == habitacion.folioHabitacion)) {
      state
          .firstWhere((element) =>
              element.isFree &&
              element.folioHabitacion == habitacion.folioHabitacion)
          .count++;
      ref.notifyListeners();
    } else {
      Habitacion item = habitacion.CopyWith();
      item.isFree = true;
      item.count = 1;
      _current = item;
      state = [...state, item];
    }
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
    for (var element in state) {
      if (!element.isFree) rooms += element.count;
    }

    int freeRoomsValid = rooms ~/ intervalo;
    if (state.any((element) =>
            element.folioHabitacion == folio &&
            element.count > 1 &&
            element.isFree) &&
        freeRoomsValid > 0) {
      state
          .firstWhere(
              (element) => element.folioHabitacion == folio && element.isFree)
          .count--;
    } else {
      if (state.any(
          (element) => element.folioHabitacion == folio && element.isFree)) {
        state.removeWhere(
            (element) => element.folioHabitacion == folio && element.isFree);
      } else if (state.any((element) => element.isFree && element.count > 1)) {
        state.firstWhere((element) => element.isFree).count--;
      } else {
        state.removeWhere((element) => element.isFree);
      }
    }
    ref.notifyListeners();
  }

  void clear() => state = [];

  Future<pw.Document> generarComprobante(Cotizacion cotizacion) async =>
      pdfPrinc = await GeneradorDocService()
          .generarComprobanteCotizacionIndividual(
              habitaciones: state, cotizacion: cotizacion);

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
  final list = ref.watch(habitacionSelectProvider).tarifaXDia ?? [];
  return list;
});

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
}

final descuentoProvisionalProvider = StateProvider<double>((ref) => 0);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/comprobante_cotizacion_model.dart';

final comprobanteProvider =
    StateProvider<ComprobanteCotizacion>((ref) => ComprobanteCotizacion());

final comprobanteGenerado = StateProvider<bool>((ref) => false);

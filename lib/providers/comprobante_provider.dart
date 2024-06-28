import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/comprobante_cotizacion_model.dart';

final comprobanteProvider =
    StateProvider<ComprobanteCotizacion>((ref) => ComprobanteCotizacion());

final comprobanteGeneradoProvider = StateProvider<bool>((ref) => false);

final uniqueFolioProvider =
    StateProvider<String>((ref) => UniqueKey().hashCode.toString());

final comprobanteDetalleProvider =
    StateProvider<ComprobanteCotizacion>((ref) => ComprobanteCotizacion());
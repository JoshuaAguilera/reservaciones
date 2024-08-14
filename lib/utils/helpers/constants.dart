import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/prefijo_telefonico_model.dart';

const List<String> categorias = <String>[
  'HABITACIÓN DELUXE DOBLE',
  'HABITACIÓN DELUXE KING SIZE',
];

const List<String> planes = <String>[
  'PLAN TODO INCLUIDO',
  'SOLO HOSPEDAJE',
  'PLAN SIN ALIMENTOS'
];

const List<String> cotizacionesList = <String>[
  'Cotización Individual',
  'Cotización Grupos',
  // 'Cotización Grupos - Temporada Baja',
];

const List<String> tipoHabitacion = <String>[
  'DELUXE DOBLE VISTA A LA RESERVA',
  'DELUXE DOBLE VISTA PARCIAL AL MAR',
];

const List<String> paxes = <String>[
  '1 o 2',
  '3',
  '4',
];

const List<String> roles = <String>[
  'SUPERADMIN',
  'ADMIN',
  'VENTAS',
];

const List<String> filtros = <String>[
  'Todos',
  'Hace un dia',
  'Hace una semana',
  'Hace un mes',
  // 'Mas cotizado',
  // 'Menos cotizado',
  'Personalizado',
];

const List<String> filtrosRegistro = <String>[
  'Semanal',
  'Mensual',
  'Anual',
];

List<PrefijoTelefonico> getPrefijosTelefonicos() {
  List<PrefijoTelefonico> prefijos = [
    PrefijoTelefonico(
        banderaAssets: "assets/icons/mexico.png",
        nombre: "Mexico",
        prefijo: "+52"),
    PrefijoTelefonico(
        banderaAssets: "assets/icons/usa.png", nombre: "USA", prefijo: "+1"),
    PrefijoTelefonico(
        banderaAssets: "assets/icons/canada.png",
        nombre: "Canada",
        prefijo: "+1"),
    PrefijoTelefonico(
        banderaAssets: "assets/icons/argentina.png",
        nombre: "Argentina",
        prefijo: "+54"),
    PrefijoTelefonico(
        banderaAssets: "assets/icons/brasil.png",
        nombre: "Brasil",
        prefijo: "+55"),
    PrefijoTelefonico(
        banderaAssets: "assets/icons/chile.png",
        nombre: "Chile",
        prefijo: "+56"),
    PrefijoTelefonico(
        banderaAssets: "assets/icons/colombia.png",
        nombre: "Colombia",
        prefijo: "+57"),
    PrefijoTelefonico(
        banderaAssets: "assets/icons/espana.png",
        nombre: "España",
        prefijo: "+34"),
    PrefijoTelefonico(
        banderaAssets: "assets/icons/guatemala.png",
        nombre: "Guatemala",
        prefijo: "+502"),
    PrefijoTelefonico(
        banderaAssets: "assets/icons/peru.png", nombre: "Peru", prefijo: "+51"),
    PrefijoTelefonico(
        banderaAssets: "assets/icons/uruguay.png",
        nombre: "Uruguay",
        prefijo: "+598"),
  ];
  return prefijos;
}

const List<String> monthNames = [
  "Enero",
  "Febrero",
  "Marzo",
  "Abril",
  "Mayo",
  "Junio",
  "Julio",
  "Agosto",
  "Septiembre",
  "Octubre",
  "Noviembre",
  "Diciembre"
];

const List<String> dayNames = [
  "Lunes",
  "Martes",
  "Miercoles",
  "Jueves",
  "Viernes",
  "Sabado",
  "Domingo",
  "Lunes",
  "Martes",
  "Miercoles",
  "Jueves",
  "Viernes",
  "Sabado",
  "Domingo",
  "Lunes",
  "Martes",
  "Miercoles",
  "Jueves",
  "Viernes",
  "Sabado",
  "Domingo",
  "Lunes",
  "Martes",
  "Miercoles",
  "Jueves",
  "Viernes",
  "Sabado",
  "Domingo",
  "Lunes",
  "Martes",
  "Miercoles",
  "Jueves",
  "Viernes",
  "Sabado",
  "Domingo",
  "Lunes",
  "Martes",
  "Miercoles",
  "Jueves",
  "Viernes",
  "Sabado",
  "Domingo",
  "Lunes",
  "Martes",
  "Miercoles",
  "Jueves",
  "Viernes",
  "Sabado",
  "Domingo",
  "Lunes",
  "Martes",
  "Miercoles",
  "Jueves",
  "Viernes",
  "Sabado",
  "Domingo",
  "Lunes",
  "Martes",
  "Miercoles",
  "Jueves",
  "Viernes",
  "Sabado",
  "Domingo",
  "Lunes",
  "Martes",
  "Miercoles",
  "Jueves",
  "Viernes",
  "Sabado",
  "Domingo",
  "Lunes",
  "Martes",
  "Miercoles",
  "Jueves",
  "Viernes",
  "Sabado",
  "Domingo",
];

const List<String> typeSettings = [
  "Generales",
  "Formato Individual",
  "Formato Grupal",
  // "Planes y categorias",
];

const List<String> textFont = <String>[
  'Calibri',
  'Poppins',
  'Bodoni Moda',
  'Times New Roman',
  // 'New York',
  'Lubalin Graph',
  // 'Minion pro',
  'Georgia',
  'Helvetica',
  // 'Futura',
  // 'Franklin Gothic',
  // 'Avenir',
  'Montserrat',
  'Frutiger',
  // 'News Gothic',
  'Gilroy',
  'Univers',
  'EB Garamond',
  'Libre Baskerville'
];

const List<Text> textofFont = <Text>[
  Text(
    'Calibri',
    style: TextStyle(fontFamily: 'calibri_regular'),
  ),
  Text(
    "Poppins",
    style: TextStyle(fontFamily: 'poppins_regular'),
  ),
  Text(
    "Bodoni Moda",
    style: TextStyle(fontFamily: 'bodoniModa-regular'),
  ),
  Text(
    "Times New Roman",
    style: TextStyle(fontFamily: 'timeNewRomanregular'),
  ),
  Text(
    "Lubalin Graph",
    style: TextStyle(fontFamily: 'lubalinGraph_regular'),
  ),
  Text(
    "Georgia",
    style: TextStyle(fontFamily: 'georgia_regular'),
  ),
  Text(
    "Helvetica",
    style: TextStyle(fontFamily: 'helvetica_regular'),
  ),
  // 'Futura',
  // 'Franklin Gothic',
  // 'Avenir',
  // 'Montserrat',
  // 'Frutiger',
  // 'News Gothic',
  // 'Gilroy',
  // 'Univers',
];

List<Widget> modesVisual = <Widget>[
  const Icon(CupertinoIcons.calendar),
  const Icon(Icons.table_chart),
  const Icon(Icons.dehaze_sharp),
];

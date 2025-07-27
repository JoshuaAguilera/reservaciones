import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../res/helpers/animation_helpers.dart';
import '../../res/ui/buttons.dart';
import '../../res/ui/section_container.dart';
import '../../res/ui/text_styles.dart';
import '../../utils/widgets/item_rows.dart';

class ConfigTarifarioView extends StatefulWidget {
  const ConfigTarifarioView({super.key});

  @override
  State<ConfigTarifarioView> createState() => _ConfigTarifarioViewState();
}

class _ConfigTarifarioViewState extends State<ConfigTarifarioView> {
  final List<Map<String, dynamic>> data = List.generate(
    100,
    (index) => {
      "id": index + 1,
      "codigo": "Usuario ${index + 1}",
      "orden": 18 + (index % 50),
      "descripcion": "Descripción del usuario ${index + 1}",
    },
  );

  DataColumn _dataColumn(String text) {
    return DataColumn(
      label: AppText.listTitleText(text: text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedEntry(
      child: SectionContainer(
        padH: 18,
        title: "Tarifario",
        subtitle:
            "Configura los tipos y categorias de habitaciones del Tarifario.",
        isModule: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        children: [
          Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.sectionTitleText(text: "Tipos de Habitaciones"),
                  Buttons.buttonSecundary(
                    text: "Agregar",
                    icon: Iconsax.add_square_outline,
                    onPressed: () {
                      // Action to add new room type
                    },
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: PaginatedDataTable(
                    rowsPerPage: 5,
                    columnSpacing: 35,
                    columns: <DataColumn>[
                      _dataColumn("ID"),
                      _dataColumn("Codigo"),
                      _dataColumn("Orden"),
                      _dataColumn("Descripción"),
                      _dataColumn("Opciones"),
                    ],
                    source: TiposHabitaciones(data),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TiposHabitaciones extends DataTableSource {
  final List<Map<String, dynamic>> data;
  TiposHabitaciones(this.data);

  DataCell _dataCell(String text) {
    return DataCell(
      AppText.simpleText(text: text, overflow: TextOverflow.ellipsis),
    );
  }

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final row = data[index];
    return DataRow(
      color: (index % 2 == 0)
          ? WidgetStateProperty.all(Colors.white)
          : WidgetStateProperty.all(Colors.grey.shade200),
      cells: [
        _dataCell('${row['id']}'),
        _dataCell(row['codigo']),
        _dataCell('${row['orden']}'),
        _dataCell('${row['descripcion']}'),
        DataCell(
          ItemRow.compactOptions(
            onPreseedEdit: () {
              // Action to edit the room type
            },
            onPreseedDelete: () {
              // Action to delete the room type
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => data.length;
  @override
  int get selectedRowCount => 0;
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/cotizacion_model.dart';
import '../../view-models/providers/cotizacion_provider.dart';

class CotizacionesPaginatedTable extends ConsumerStatefulWidget {
  const CotizacionesPaginatedTable({super.key});

  @override
  ConsumerState<CotizacionesPaginatedTable> createState() =>
      _CotizacionesPaginatedTableState();
}

class _CotizacionesPaginatedTableState
    extends ConsumerState<CotizacionesPaginatedTable> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cotizacionesProvider("").notifier).load(1, 20);
    });
  }

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cotizacionesProvider(""));

    if (state.records == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.records?.isEmpty ?? true) {
      return const Center(child: Text('Sin elementos'));
    }
    final tableSource = CotizacionesTableSource(state.records ?? []);

    return SingleChildScrollView(
      child: PaginatedDataTable(
        rowsPerPage: _rowsPerPage,
        availableRowsPerPage: const [5, 10, 20],
        onRowsPerPageChanged: (value) {
          if (value != null) setState(() => _rowsPerPage = value);
        },
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Folio')),
          DataColumn(label: Text('Fecha')),
          DataColumn(label: Text('Cliente')),
          DataColumn(label: Text('Fecha Límite')),
        ],
        source: tableSource,
      ),
    );
  }
}

class CotizacionesTableSource extends DataTableSource {
  final List<Cotizacion> cotizaciones;

  CotizacionesTableSource(this.cotizaciones);

  @override
  DataRow? getRow(int index) {
    if (index >= cotizaciones.length) return null;
    final cot = cotizaciones[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(cot.id.toString())),
        DataCell(Text(cot.folio ?? '')),
        DataCell(Text(cot.createdAt.toString())),
        DataCell(Text(cot.cliente?.fullName ?? '')),
        DataCell(Text(cot.fechaLimite.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => cotizaciones.length;
  @override
  int get selectedRowCount => 0;
}

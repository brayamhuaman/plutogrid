import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class DataTablePage extends StatefulWidget {
  const DataTablePage({Key? key}) : super(key: key);

  @override
  _DataTablePageState createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage> {
  late List<PlutoColumn> columns;
  late List<PlutoRow> rows;

  @override
  void initState() {
    super.initState();

    // Define columns
    columns = [
      PlutoColumn(
        title: 'N°',
        field: 'number',
        type: PlutoColumnType.number(),
        width: 80,
      ),
      PlutoColumn(
        title: 'PAD',
        field: 'pad',
        type: PlutoColumnType.text(),
        width: 100,
      ),
      PlutoColumn(
        title: 'PLACA',
        field: 'placa',
        type: PlutoColumnType.text(),
        width: 100,
      ),
      PlutoColumn(
        title: 'H.INI',
        field: 'h_ini',
        type: PlutoColumnType.text(),
        width: 100,
      ),
      // Condition columns (CON1 to CON6)
      ...List.generate(6, (index) {
        return PlutoColumn(
          title: 'CON${index + 1}',
          field: 'con${index + 1}',
          type: PlutoColumnType.text(),
          width: 80,
          cellPadding: EdgeInsets.zero,
          renderer: (rendererContext) {
            final value = rendererContext.cell.value;
            Color? textColor;
            
            if (value == '+5') {
              textColor = Colors.green;
            } else if (value == '-5') {
              textColor = Colors.red;
            } else if (value == '0') {
              textColor = Colors.black;
            }

            return Text(
              value.toString(),
              style: TextStyle(color: textColor),
              textAlign: TextAlign.center,
            );
          },
        );
      }),
      PlutoColumn(
        title: 'Total',
        field: 'total',
        type: PlutoColumnType.text(),
        width: 80,
      ),
      PlutoColumn(
        title: 'Conductor',
        field: 'conductor',
        type: PlutoColumnType.text(),
        width: 200,
      ),
      PlutoColumn(
        title: 'Cobrador',
        field: 'cobrador',
        type: PlutoColumnType.text(),
        width: 200,
      ),
    ];

    // Define rows
    rows = List.generate(14, (index) {
      return PlutoRow(
        cells: {
          'number': PlutoCell(value: index + 1),
          'pad': PlutoCell(value: '134'),
          'placa': PlutoCell(value: 'ABC-123'),
          'h_ini': PlutoCell(value: '04:35'),
          'con1': PlutoCell(value: index % 2 == 0 ? '+5' : '-5'),
          'con2': PlutoCell(value: index % 2 == 0 ? '+5' : '-5'),
          'con3': PlutoCell(value: index % 2 == 0 ? '+5' : '-5'),
          'con4': PlutoCell(value: index % 2 == 0 ? '+5' : '-5'),
          'con5': PlutoCell(value: index % 2 == 0 ? '+5' : '-5'),
          'con6': PlutoCell(value: index % 2 == 0 ? '+5' : '-5'),
          'total': PlutoCell(value: _calculateTotal(index)),
          'conductor': PlutoCell(value: 'Juan Juan Pérez Pérez'),
          'cobrador': PlutoCell(value: 'Juan Juan Pérez Pérez'),
        },
      );
    });
  }

  String _calculateTotal(int index) {
    // Custom total calculation logic
    switch (index) {
      case 3: return '+12';
      case 4: return '+11';
      case 6: return '+1';
      case 7: return '+36';
      case 9: return '+4';
      case 10: return '+10';
      case 12: return '0';
      case 13: return '+42';
      default: return '+70';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Table'),
      ),
      body: PlutoGrid(
        columns: columns,
        rows: rows,
        onChanged: (PlutoGridOnChangedEvent event) {
          print(event);
        },
        configuration: const PlutoGridConfiguration(
          scrollbar: PlutoGridScrollbarConfig(
            isAlwaysShown: true,
            scrollbarThickness: 8,
          ),
        ),
      ),
    );
  }
}
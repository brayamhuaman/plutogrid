import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'datos.dart';

class DataTablePage extends StatefulWidget {
  const DataTablePage({Key? key}) : super(key: key);

  @override
  _DataTablePageState createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage> {
  late List<PlutoColumn> columns;
  late List<PlutoRow> rows;
  late PlutoGridStateManager
      stateManager; // Para manejar el estado de PlutoGrid
  final TextEditingController searchController = TextEditingController();

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
          textAlign: PlutoColumnTextAlign.center,
          titleTextAlign: PlutoColumnTextAlign.center),
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

            String displayValue;
            if (value == null || value.toString().isEmpty) {
              displayValue = '---'; // Reemplazar valores vacíos o null
              textColor = Color(0xFF8A8A8A); // Color morado
            } else if (value.toString().startsWith('+')) {
              displayValue = value.toString();
              textColor = Color(0xFF006800); // Valores positivos
            } else if (value.toString().startsWith('-')) {
              displayValue = value.toString();
              textColor = Color(0xFFC10000); // Valores negativos
            } else {
              displayValue = value.toString();
              textColor = Color(0xFF8A8A8A); // Valores sin signo
            }

            return Text(
              displayValue,
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
        title: 'Terminal',
        field: 'terminal',
        type: PlutoColumnType.text(),
        width: 100,
        renderer: (rendererContext) {
          final value = rendererContext.cell.value;
          Color textColor;
          String displayValue;

          if (value == null || value.toString().isEmpty) {
            displayValue = '---'; // Reemplazar valores vacíos o null
            textColor = Color(0xFF8A8A8A); // Color morado
          } else if (value == 'A') {
            displayValue = value.toString();
            textColor = Color(0xFF0028C8); // Color morado para 'A'
          } else if (value == 'B') {
            displayValue = value.toString();
            textColor = Color(0xFF6E00B7); // Color azul para 'B'
          } else {
            displayValue = value.toString();
            textColor = Colors.black; // Color negro para otros valores
          }

          return Text(
            displayValue,
            style: TextStyle(color: textColor),
            textAlign: TextAlign.center,
          );
        },
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

    // Define rows de datos.dart
    rows = DatosTabla.filas.map((fila) {
      return PlutoRow(
        cells: {
          'number': PlutoCell(value: fila['number']),
          'pad': PlutoCell(value: fila['pad']),
          'placa': PlutoCell(value: fila['placa']),
          'h_ini': PlutoCell(value: fila['h_ini']),
          'con1': PlutoCell(value: fila['con1']),
          'con2': PlutoCell(value: fila['con2']),
          'con3': PlutoCell(value: fila['con3']),
          'con4': PlutoCell(value: fila['con4']),
          'con5': PlutoCell(value: fila['con5']),
          'con6': PlutoCell(value: fila['con6']),
          'total': PlutoCell(value: fila['total']),
          'terminal': PlutoCell(value: fila['terminal']),
          'conductor': PlutoCell(value: fila['conductor']),
          'cobrador': PlutoCell(value: fila['cobrador']),
        },
      );
    }).toList();
  }

  //BUSQUEDA
  void filterRows(String searchTerm) {
    stateManager.setFilter((row) {
      return row.cells.values.any((cell) => cell.value
          .toString()
          .toLowerCase()
          .contains(searchTerm.toLowerCase()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Tabla de datos'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Buscar datos:', // Etiqueta del TextField
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              //BUSCAR
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ingrese datos de búsqueda',
                    ),
                    onChanged: (value) {
                      filterRows(value); // Filtrar automáticamente al escribir
                    },
                  ),
                ),
              ),
              
            ],
          ),
          const SizedBox(               height: 16), // Espaciado entre el TextField y el PlutoGrid
          Flexible(
            child: PlutoGrid(
              columns: columns,
              rows: rows,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                stateManager = event.stateManager;  
              },
              configuration: PlutoGridConfiguration(
                scrollbar: PlutoGridScrollbarConfig(
                  isAlwaysShown: true,
                  scrollbarThickness: 8,
                ),
              ),
            ),
          ),
             Text('data', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
         ],
      ),
    );
  }
}

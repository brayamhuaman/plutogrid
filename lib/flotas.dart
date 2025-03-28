import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'datos_flotas.dart';

class FlotasPage extends StatefulWidget {
  const FlotasPage({Key? key}) : super(key: key);

  @override
  _FlotasPageState createState() => _FlotasPageState();
}

class _FlotasPageState extends State<FlotasPage> {
  late List<PlutoColumn> columns;
  late List<PlutoRow> rows;

  @override
  void initState() {
    super.initState();

    // Define columns
    columns = [
      PlutoColumn(
        title: 'PAD',
        field: 'pad',
        type: PlutoColumnType.text(),
        width: 150,
      ),
      PlutoColumn(
        title: 'PLACA',
        field: 'placa',
        type: PlutoColumnType.text(),
        width: 150,
      ),
    ];

    // Define rows from datos_flotas.dart
    rows = DatosFlotas.filas.map((fila) {
      return PlutoRow(
        cells: {
          'pad': PlutoCell(value: fila['pad']),
          'placa': PlutoCell(value: fila['placa']),
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Base de Datos de Flota'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Base de Datos de Flota', style: TextStyle(fontSize: 24)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Mantenimiento de la Flota de Vehículos',
                  style: TextStyle(fontSize: 16)),
              const SizedBox(width: 20),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  _showRegistroDialog(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child:
                    const Text('Nuevo', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Lógica para editar
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
                child:
                    const Text('Editar', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Lógica para eliminar
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Eliminar',
                    style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 10),
            ],
          ),

          // Tabla
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlutoGrid(
                columns: columns,
                rows: rows,
                configuration: const PlutoGridConfiguration(
                  scrollbar: PlutoGridScrollbarConfig(
                    isAlwaysShown: true,
                    scrollbarThickness: 8,
                  ),
                  columnFilter: PlutoGridColumnFilterConfig(
                    filters: [], // Deshabilitar filtros
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Diálogo para registro de unidad
  void _showRegistroDialog(BuildContext context) {
     

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Registro de Unidad",style: TextStyle(
                                color: Color(0xFF0869F7),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 15)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Placa",
                            style: TextStyle(
                                color: Color(0xFF0869F7),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 15)),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Radio de 8px
                              borderSide: BorderSide(
                                  color: Color(0xFFB3B5B5)), // Color verde
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Radio de 8px
                              borderSide: BorderSide(
                                  color: Color(0xFFB3B5B5)), // Color verde
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Radio de 8px
                              borderSide: BorderSide(
                                  color: Color(0xFFB3B5B5),
                                  width: 2), // Color verde más ancho
                            ),
                            hintText:
                                'Ingrese placa', // Texto de sugerencia opcional
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Padrón",
                            style: TextStyle(
                                color: Color(0xFF0869F7),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 15)),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Radio de 8px
                              borderSide: BorderSide(
                                  color: Color(0xFFB3B5B5)), // Color verde
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Radio de 8px
                              borderSide: BorderSide(
                                  color: Color(0xFFB3B5B5)), // Color verde
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Radio de 8px
                              borderSide: BorderSide(
                                  color: Color(0xFFB3B5B5),
                                  width: 2), // Color verde más ancho
                            ),
                            hintText:
                                'Ingrese padron', // Texto de sugerencia opcional
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Lógica para guardar
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFF0869F7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Radio de 8px
                ),
              ),
              child: Text("Guardar",
                  style: TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFF313131),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Radio de 8px
                ),
              ),
              child: Text("Cancelar",
                  style: TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'parametricos_api.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConstruccionScreen(),
    ),
  );
}

// 1. Cambiamos a StatefulWidget
class ConstruccionScreen extends StatefulWidget {
  const ConstruccionScreen({super.key});

  @override
  State<ConstruccionScreen> createState() => _ConstruccionScreenState();
}

class _ConstruccionScreenState extends State<ConstruccionScreen> {

 final ParametricosApi apiService = ParametricosApi();

  final primaryBlue = Color(0xFF003D71); // Azul oscuro de la marca

  // Definimos un estilo de texto limpio usando la fuente del sistema (Roboto/SF Pro)
  final baseTextStyle = TextStyle(
    fontFamily: 'sans-serif', // Forzar estética limpia si es necesario
  );

  List<dynamic> lineasTrabajo = [];
  List<DropdownMenuItem<int>> opcionesLineaTrabajo = [];
  int? lineaTrabajoSeleccionada;
  String? incluye;

  void _cargarLineaTrabajo() async {
    opcionesLineaTrabajo = await obtenerOpcionesLineaTrabajo();
    if (opcionesLineaTrabajo.isNotEmpty && lineaTrabajoSeleccionada == null) {
      lineaTrabajoSeleccionada = opcionesLineaTrabajo.first.value;
    }
    setState(() {});
  }

  Future<List<DropdownMenuItem<int>>> obtenerOpcionesLineaTrabajo() async {
    lineasTrabajo = await apiService.obtenerLineaTrabajo();

    // Convertimos la lista de mapas a DropdownMenuItem<int>
    return lineasTrabajo.map<DropdownMenuItem<int>>((linea) {
      return DropdownMenuItem<int>(
        value: linea["idLineaTrabajo"], // 👈 valor que guarda el dropdown
        child: Text(
          linea["nombre"],
          style: const TextStyle(color: Colors.black),
        ), // 👈 lo que se muestra
      );
    }).toList();
  }

  Map<String, dynamic>? obtenerObjetoLineaSeleccionada() {
    if (lineaTrabajoSeleccionada == null || lineasTrabajo.isEmpty) return null;
    
    // Buscamos el mapa que coincida con el ID seleccionado
    return lineasTrabajo.firstWhere(
      (linea) => linea["idLineaTrabajo"] == lineaTrabajoSeleccionada,
      orElse: () => null,
    );
  }
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9), // Fondo gris azulado muy claro
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.water_drop, color: Colors.blue, size: 20),
          ),
        ),
        title: Text(
          'Costos Paramétricos',
          style: baseTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header blanco debajo del AppBar
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cálculo de Construcción',
                    style: baseTextStyle.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Determinación de costos por metro lineal mediante parámetros técnicos.',
                    style: baseTextStyle.copyWith(color: Colors.black54, fontSize: 13),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // CARD 1: Línea y Material
                  _buildSectionCard([
                    _buildDropdown(
                      label: 'LÍNEA DE TRABAJO',
                      currentValue: lineaTrabajoSeleccionada,
                      items: opcionesLineaTrabajo, // Tu lista poblada desde la API
                      baseStyle: baseTextStyle,
                      onChanged: (int? nuevoId) {
                        setState(() {
                          lineaTrabajoSeleccionada = nuevoId;
                        });
                        
                        // Opcional: Aquí ya tienes acceso al objeto completo que se guardó en segundo plano
                        var objetoCompleto = obtenerObjetoLineaSeleccionada();
                        incluye = objetoCompleto?['incluye'];
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildDropdown(
                      label: 'TIPO DE MATERIAL',
                      currentValue: lineaTrabajoSeleccionada,
                      items: opcionesLineaTrabajo, // Tu lista poblada desde la API
                      baseStyle: baseTextStyle,
                      onChanged: (int? nuevoId) {
                        setState(() {
                          lineaTrabajoSeleccionada = nuevoId;
                        });
                        
                        // Opcional: Aquí ya tienes acceso al objeto completo que se guardó en segundo plano
                        var objetoCompleto = obtenerObjetoLineaSeleccionada();
                        incluye = objetoCompleto?['incluye'];
                      },
                    ),
                  ]),
                  
                  const SizedBox(height: 12),

                  // CARD 2: Obra, Tubería y Metros
                  _buildSectionCard([
                    _buildDropdown(
                      label: 'TIPO DE OBRA',
                      currentValue: lineaTrabajoSeleccionada,
                      items: opcionesLineaTrabajo, // Tu lista poblada desde la API
                      baseStyle: baseTextStyle,
                      onChanged: (int? nuevoId) {
                        setState(() {
                          lineaTrabajoSeleccionada = nuevoId;
                        });
                        
                        // Opcional: Aquí ya tienes acceso al objeto completo que se guardó en segundo plano
                        var objetoCompleto = obtenerObjetoLineaSeleccionada();
                        incluye = objetoCompleto?['incluye'];
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildDropdown(
                      label: 'TIPO DE TUBERÍA',
                      currentValue: lineaTrabajoSeleccionada,
                      items: opcionesLineaTrabajo, // Tu lista poblada desde la API
                      baseStyle: baseTextStyle,
                      onChanged: (int? nuevoId) {
                        setState(() {
                          lineaTrabajoSeleccionada = nuevoId;
                        });
                        
                        // Opcional: Aquí ya tienes acceso al objeto completo que se guardó en segundo plano
                        var objetoCompleto = obtenerObjetoLineaSeleccionada();
                        incluye = objetoCompleto?['incluye'];
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildInputField('METROS A CONSTRUIR', '700.00', baseTextStyle, suffix: 'MTS'),
                  ]),

                  const SizedBox(height: 12),

                  // CARD 3: Especificación Técnica (CON IMAGEN LOCAL)
                  _buildSpecCard(baseTextStyle),

                  const SizedBox(height: 12),

                  // CARD 4: Resultados
                  _buildResultCard(primaryBlue, baseTextStyle),

                  const SizedBox(height: 20),

                  // BOTÓN BUSCAR
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.calculate_outlined),
                      label: Text('Buscar Precios', style: baseTextStyle.copyWith(fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(baseTextStyle),
    );
  }

  // Widget para Dropdowns personalizados
  Widget _buildDropdown({
    required String label,
    required int? currentValue,
    required List<DropdownMenuItem<int>> items,
    required ValueChanged<int?> onChanged,
    required TextStyle baseStyle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Etiqueta superior (LÍNEA DE TRABAJO, etc.)
        Text(
          label, 
          style: baseStyle.copyWith(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        
        // Contenedor con el diseño gris estético
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12), // Reducimos el vertical porque el Dropdown añade su propio padding
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline( // Oculta la línea horizontal por defecto de Flutter
            child: DropdownButton<int>(
              value: currentValue,
              items: items,
              onChanged: onChanged,
              isExpanded: true, // Hace que ocupe todo el ancho disponible del contenedor
              icon: const Icon(Icons.unfold_more, color: Colors.blueGrey, size: 20), // Tu ícono personalizado de la UI
              style: baseStyle.copyWith(fontSize: 14, color: Colors.black87),
              hint: Text("Seleccione una opción", style: baseStyle.copyWith(color: Colors.black38)),
              dropdownColor: Colors.white, // Color del menú flotante al abrirse
              borderRadius: BorderRadius.circular(8), // Bordes redondeados también para el menú flotante
            ),
          ),
        ),
      ],
    );
  }

  // Widget para Input de texto
  Widget _buildInputField(String label, String value, TextStyle baseStyle, {String? suffix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: baseStyle.copyWith(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black87)),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value),
          style: baseStyle.copyWith(fontSize: 14),
          decoration: InputDecoration(
            fillColor: const Color(0xFFF5F5F5),
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            suffixText: suffix,
            suffixStyle: baseStyle.copyWith(color: Colors.black54, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  // Tarjeta contenedora blanca
  Widget _buildSectionCard(List<Widget> children) {
    return Card(
      elevation: 0.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: children),
      ),
    );
  }

  // Tarjeta de Especificación Técnica (ACTUALIZADA CON ASSET)
  Widget _buildSpecCard(TextStyle baseStyle) {
    return Card(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            color: const Color(0xFFEEEEEE),
            child: Text(
              'ESPECIFICACIÓN TÉCNICA',
              textAlign: TextAlign.center,
              style: baseStyle.copyWith(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue[900]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    // CAMBIO: Ahora carga desde la carpeta local assets
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/IMA001C.jpg', 
                        height: 150,
                        fit: BoxFit.contain,
                        // Manejo de error por si el archivo no se encuentra o está mal escrito
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 150,
                            width: double.infinity,
                            color: Colors.grey[200],
                            child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(8)),
                      child: IconButton(onPressed: () {}, icon: const Icon(Icons.zoom_in, color: Colors.black87)),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    style: baseStyle.copyWith(color: Colors.black87, fontSize: 13),
                    children: const [
                      TextSpan(text: 'Nota: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'Incluye trazo, nivelación, corte, ruptura de pavimento, excavaciones, rellenos, cama de grava, acarreos y pozos de visita.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Tarjeta de Resultados
  Widget _buildResultCard(Color color, TextStyle baseStyle) {
    return Container(
      decoration: BoxDecoration(
        color:  Color(0xFF003D71).withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: color, width: 6)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('PRECIO POR METRO', style: baseStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
              Text('\$ 13,593.87', style: baseStyle.copyWith(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          const Divider(height: 24, color: Color(0xFF003D71),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('TOTAL SIN IVA', style: baseStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
              Text('\$ 9,515,709.00', style: baseStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  // Barra de navegación inferior
  Widget _buildBottomNav(TextStyle baseStyle) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF003D71),
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
      selectedLabelStyle: baseStyle.copyWith(fontSize: 12),
      unselectedLabelStyle: baseStyle.copyWith(fontSize: 12),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Calculadora'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
        BottomNavigationBarItem(icon: Icon(Icons.architecture), label: 'Proyectos'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
      ],
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
    );
  }
}
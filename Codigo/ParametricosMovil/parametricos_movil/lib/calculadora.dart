import 'package:flutter/material.dart';
import 'parametricos_api.dart';
import 'dart:ui';

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

  final TextEditingController metrosController = TextEditingController(text: '0');
  final TextEditingController precioController = TextEditingController(text: '0');
  final TextEditingController totalController = TextEditingController(text: '0');

  String? textoIncluye;
  String? textoDescripcion;

  List<dynamic> lineasTrabajo = [];
  List<DropdownMenuItem<int>> opcionesLineaTrabajo = [];
  int? lineaTrabajoSeleccionada;
  Map<String, dynamic>? objetoCompletoLineaTrabajo;

  List<dynamic> tiposMaterial = [];
  List<DropdownMenuItem<int>> opcionesTipoMaterial = [];
  int? tipoMaterialSeleccionado;
  Map<String, dynamic>? objetoCompletoTipoMaterial;

  List<dynamic> tiposObra = [];
  List<DropdownMenuItem<int>> opcionesTipoObra = [];
  int? tipoObraSeleccionada;
  Map<String, dynamic>? objetoCompletoTipoObra;

  List<dynamic> tiposTuberia = [];
  List<DropdownMenuItem<int>> opcionesTipoTuberia = [];
  int? tipoTuberiaSeleccionada;
  Map<String, dynamic>? objetoCompletoTipoTuberia;

  List<dynamic> diametrosTuberia = [];
  List<DropdownMenuItem<int>> opcionesDiametrosTuberia = [];
  int? diametroTuberiaSeleccionado;
  Map<String, dynamic>? objetoCompletoDiametroTuberia;

  List<dynamic> tiposExcavacion = [];
  List<DropdownMenuItem<int>> opcionesTipoExcavacion = [];
  int? tipoExcavacionSeleccionada;
  Map<String, dynamic>? objetoCompletoTipoExcavacion;

  List<dynamic> relacionPrecio = [];

  void cargarLineaTrabajo() async {
    opcionesLineaTrabajo = await obtenerOpcionesLineaTrabajo();
/*     if (opcionesLineaTrabajo.isNotEmpty && lineaTrabajoSeleccionada == null) {
      lineaTrabajoSeleccionada = opcionesLineaTrabajo.first.value;
    } */
    setState(() {});
  }

  Future<List<DropdownMenuItem<int>>> obtenerOpcionesLineaTrabajo() async {
    lineasTrabajo = await apiService.obtenerLineaTrabajo();

    return lineasTrabajo.map<DropdownMenuItem<int>>((linea) {
      return DropdownMenuItem<int>(
        value: linea["idLineaTrabajo"],
        child: Text(
          linea["nombre"],
          style: const TextStyle(color: Colors.black),
        ),
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

  void cargarTipoMaterial() async {
    opcionesTipoMaterial = await obtenerOpcionesTipoMaterial();
    setState(() {});
  }

  Future<List<DropdownMenuItem<int>>> obtenerOpcionesTipoMaterial() async {
    tiposMaterial = await apiService.obtenerTipoMaterial();

    return tiposMaterial.map<DropdownMenuItem<int>>((tipo) {
      return DropdownMenuItem<int>(
        value: tipo["idTipoMaterial"],
        child: Text(
          tipo["nombre"],
          style: const TextStyle(color: Colors.black),
        ),
      );
    }).toList();
  }

  Map<String, dynamic>? obtenerObjetoTipoMaterialSeleccionado() {
    if (tipoMaterialSeleccionado == null || tiposMaterial.isEmpty) return null;
    
    // Buscamos el mapa que coincida con el ID seleccionado
    return tiposMaterial.firstWhere(
      (tipo) => tipo["idTipoMaterial"] == tipoMaterialSeleccionado,
      orElse: () => null,
    );
  }
  
  void cargarTipoDeObra(int idClaveTrabajo) async {
    opcionesTipoObra = await obtenerOpcionesTipoObra(idClaveTrabajo);
    setState(() {});
  }

  Future<List<DropdownMenuItem<int>>> obtenerOpcionesTipoObra(int idClaveTrabajo) async {
    tiposObra = await apiService.obtenerTipoObra(idClaveTrabajo: idClaveTrabajo);

    return tiposObra.map<DropdownMenuItem<int>>((tipo) {
      return DropdownMenuItem<int>(
        value: tipo["idTipoObra"],
        child: Text(
          tipo["nombre"],
          style: const TextStyle(color: Colors.black),
        ),
      );
    }).toList();
  }

  Map<String, dynamic>? obtenerObjetoTipoObraSeleccionada() {
    if (tipoObraSeleccionada == null || tiposObra.isEmpty) return null;
    
    // Buscamos el mapa que coincida con el ID seleccionado
    return tiposObra.firstWhere(
      (tipo) => tipo["idTipoObra"] == tipoObraSeleccionada,
      orElse: () => null,
    );
  }

  Future<void> cargarTipoTuberia(int idLineaTrabajo, int idTipoObra) async {
    opcionesTipoTuberia = await obtenerOpcionesTipoTuberia(idLineaTrabajo, idTipoObra);
    if (opcionesTipoTuberia.isNotEmpty && tipoTuberiaSeleccionada == null) {
      tipoTuberiaSeleccionada = opcionesTipoTuberia.first.value;
    }
    setState(() {});
  }

  Future<List<DropdownMenuItem<int>>> obtenerOpcionesTipoTuberia(int idLineaTrabajo, int idTipoObra) async {
    tiposTuberia = await apiService.obtenerRelacionLineaObraTuberia(idLineaTrabajo: idLineaTrabajo, idTipoObra: idTipoObra);

    return tiposTuberia.map<DropdownMenuItem<int>>((tipo) {
      return DropdownMenuItem<int>(
        value: tipo["idTuberia"],
        child: Text(
          tipo["tuberia"],
          style: const TextStyle(color: Colors.black),
        ),
      );
    }).toList();
  }

  Map<String, dynamic>? obtenerObjetoTipoTuberiaSeleccionada() {
    if (tipoTuberiaSeleccionada == null || tiposTuberia.isEmpty) return null;
    
    // Buscamos el mapa que coincida con el ID seleccionado
    return tiposTuberia.firstWhere(
      (tipo) => tipo["idTuberia"] == tipoTuberiaSeleccionada,
      orElse: () => null,
    );
  }

  Future<void> cargarDiametroTuberia(int idRelacionObra) async {
    opcionesDiametrosTuberia = await obtenerOpcionesDiametroTuberia(idRelacionObra);
    if (opcionesDiametrosTuberia.isNotEmpty && diametroTuberiaSeleccionado == null) {
      diametroTuberiaSeleccionado = opcionesDiametrosTuberia.first.value;
    }
    setState(() {});
  }

  Future<List<DropdownMenuItem<int>>> obtenerOpcionesDiametroTuberia(int idRelacionObra) async {
    diametrosTuberia = await apiService.obtenerRelacionObraDiametro(idRelacionObra: idRelacionObra);

    return diametrosTuberia.map<DropdownMenuItem<int>>((tipo) {
      return DropdownMenuItem<int>(
        value: tipo["idDiametro"],
        child: Text(
          tipo["diametro"],
          style: const TextStyle(color: Colors.black),
        ),
      );
    }).toList();
  }

  Map<String, dynamic>? obtenerObjetoDiametroTuberiaSeleccionado() {
    if (diametroTuberiaSeleccionado == null || diametrosTuberia.isEmpty) return null;
    
    // Buscamos el mapa que coincida con el ID seleccionado
    return diametrosTuberia.firstWhere(
      (tipo) => tipo["idDiametro"] == diametroTuberiaSeleccionado,
      orElse: () => null,
    );
  }

  Future<void> cargarTipoExcavacion() async {
    opcionesTipoExcavacion = await obtenerOpcionesTipoExcavacion();
    setState(() {});
  }

  Future<List<DropdownMenuItem<int>>> obtenerOpcionesTipoExcavacion() async {
    tiposExcavacion = await apiService.obtenerExcavacion();

    return tiposExcavacion.map<DropdownMenuItem<int>>((tipo) {
      return DropdownMenuItem<int>(
        value: tipo["idExcavacion"],
        child: Text(
          tipo["nombre"],
          style: const TextStyle(color: Colors.black),
        ),
      );
    }).toList();
  }

  Map<String, dynamic>? obtenerObjetoTipoExcavacionSeleccionada() {
    if (tipoExcavacionSeleccionada == null || tiposExcavacion.isEmpty) return null;
    
    // Buscamos el mapa que coincida con el ID seleccionado
    return tiposExcavacion.firstWhere(
      (tipo) => tipo["idExcavacion"] == tipoExcavacionSeleccionada,
      orElse: () => null,
    );
  }

  Future<void> evaluarYCargarPrecio() async {

    if (objetoCompletoDiametroTuberia != null && objetoCompletoTipoMaterial != null && objetoCompletoTipoExcavacion != null) {
      
      try {
        // 1. Llamamos a tu función pasándole las variables actuales del estado
        final resultado = await apiService.obtenerRelacionFinalPrecio(
          idRelacionDiametro: objetoCompletoDiametroTuberia!['idRelacion'],
          idTipoMaterial: objetoCompletoTipoMaterial!['idTipoMaterial'],
          idExcavacion: objetoCompletoTipoExcavacion!['idExcavacion'],
        );

        // 2. Si la API nos responde con éxito, actualizamos la UI con el nuevo precio
        if (resultado.isNotEmpty) {
          setState(() {
            // Asumiento que tu API regresa el campo 'precio' y tienes un precioController
            precioController.text = '\$ ${resultado[0]['precio']}';
            textoDescripcion = resultado[0]['descripcion']; 
          });
        }
      } catch (e) {
        //print("Error al obtener el precio final: $e");
        precioController.text = '\$ 0.00';
      }

    } else {
      // Opcional: Si el usuario deselecciona algo, podemos resetear el precio a $ 0
      setState(() {
        precioController.text = '\$ 0.00';
      });
    }
  }

  @override
  void initState() {
    super.initState();

    precioController.text = '\$ 0.00';
    totalController.text = '\$ 0.00';

    cargarLineaTrabajo();
    cargarTipoMaterial();
    cargarTipoExcavacion();
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0, 
        
        // Mantenemos tu efecto de desenfoque Glassmorphism
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 30),
            child: Container(
              color: primaryBlue, 
            ),
          ),
        ),
        
        // 🚀 CAMBIADO: Reemplazamos el CircleAvatar con ícono por tu imagen
        leading: Padding(
          padding: const EdgeInsets.all(10.0), // Margen para que no pegue a los bordes
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100), // Recorte circular perfecto
            child: Image.asset(
              'assets/favicon.png', // Tu imagen o logo para el AppBar
              fit: BoxFit.cover, // Hace que llene el círculo limpiamente
            ),
          ),
        ),
        
        title: Text(
          'Costos Paramétricos',
          style: baseTextStyle.copyWith(
            fontWeight: FontWeight.w600, 
            fontSize: 18, 
            color: Colors.white,
          ),
        ),
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
                          objetoCompletoLineaTrabajo = null;
                          textoIncluye = null;
                          tipoObraSeleccionada = null;
                          tipoTuberiaSeleccionada = null; 
                          diametroTuberiaSeleccionado = null;
                          objetoCompletoTipoTuberia = null;
                        });
                        
                        // Opcional: Aquí ya tienes acceso al objeto completo que se guardó en segundo plano
                        objetoCompletoLineaTrabajo = obtenerObjetoLineaSeleccionada();
                        textoIncluye = objetoCompletoLineaTrabajo?['incluye'];

                        cargarTipoDeObra(objetoCompletoLineaTrabajo?['idClaveTrabajo']);
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildDropdown(
                      label: 'TIPO DE MATERIAL',
                      currentValue: tipoMaterialSeleccionado,
                      items: opcionesTipoMaterial, // Tu lista poblada desde la API
                      baseStyle: baseTextStyle,
                      onChanged: (int? nuevoId) async {
                        setState(() {
                          tipoMaterialSeleccionado = nuevoId;
                        });
                        
                        // Opcional: Aquí ya tienes acceso al objeto completo que se guardó en segundo plano
                        objetoCompletoTipoMaterial = obtenerObjetoTipoMaterialSeleccionado();
                        // Cargamos la foto automaticamente
                        await evaluarYCargarPrecio();
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildDropdown(
                      label: 'TIPO DE OBRA',
                      currentValue: tipoObraSeleccionada,
                      items: opcionesTipoObra, // Tu lista poblada desde la API
                      baseStyle: baseTextStyle,
                      onChanged: (int? nuevoId) async {
                        setState(() {
                          tipoObraSeleccionada = nuevoId;
                          tipoTuberiaSeleccionada = null; 
                          diametroTuberiaSeleccionado = null;
                          objetoCompletoTipoTuberia = null;
                          objetoCompletoDiametroTuberia = null;
                        });
                        
                        // Opcional: Aquí ya tienes acceso al objeto completo que se guardó en segundo plano
                        objetoCompletoTipoObra = obtenerObjetoTipoObraSeleccionada();
                        await cargarTipoTuberia(objetoCompletoLineaTrabajo?['idLineaTrabajo'], objetoCompletoTipoObra?['idTipoObra'] );
                        if (tipoTuberiaSeleccionada != null) {
                          objetoCompletoTipoTuberia = obtenerObjetoTipoTuberiaSeleccionada();
                          await cargarDiametroTuberia(objetoCompletoTipoTuberia?['idRelacion']);
                          if (diametroTuberiaSeleccionado != null) {
                            objetoCompletoDiametroTuberia = obtenerObjetoDiametroTuberiaSeleccionado();
                            await evaluarYCargarPrecio();
                          }
                        }
                      },
                    ),
                  ]),
                  
                  const SizedBox(height: 12),

                  // CARD 2: Obra, Tubería y Metros
                  _buildSectionCard([
                    _buildDropdown(
                      label: 'TIPO DE TUBERÍA',
                      currentValue: tipoTuberiaSeleccionada,
                      items: opcionesTipoTuberia, // Tu lista poblada desde la API
                      baseStyle: baseTextStyle,
                      onChanged: (int? nuevoId) async {
                        setState(() {
                          tipoTuberiaSeleccionada = nuevoId;
                          diametroTuberiaSeleccionado = null;
                          objetoCompletoTipoTuberia = null;
                          objetoCompletoDiametroTuberia = null;
                        });
                        
                        // Opcional: Aquí ya tienes acceso al objeto completo que se guardó en segundo plano
                        objetoCompletoTipoTuberia = obtenerObjetoTipoTuberiaSeleccionada();
                        await cargarDiametroTuberia(objetoCompletoTipoTuberia?['idRelacion']);
                        if (diametroTuberiaSeleccionado != null) {
                          objetoCompletoDiametroTuberia = obtenerObjetoDiametroTuberiaSeleccionado();
                          await evaluarYCargarPrecio();
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildDropdown(
                      label: 'DIÁMETRO DE TUBERÍA',
                      currentValue: diametroTuberiaSeleccionado,
                      items: opcionesDiametrosTuberia, // Tu lista poblada desde la API
                      baseStyle: baseTextStyle,
                      onChanged: (int? nuevoId) async {
                        setState(() {
                          diametroTuberiaSeleccionado = nuevoId;
                          objetoCompletoDiametroTuberia = null;
                        });

                        objetoCompletoDiametroTuberia = obtenerObjetoDiametroTuberiaSeleccionado();
                        await evaluarYCargarPrecio();
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildDropdown(
                      label: 'EXCAVACIÓ EN',
                      currentValue: tipoExcavacionSeleccionada,
                      items: opcionesTipoExcavacion, // Tu lista poblada desde la API
                      baseStyle: baseTextStyle,
                      onChanged: (int? nuevoId) async {
                        setState(() {
                          tipoExcavacionSeleccionada = nuevoId;
                          objetoCompletoTipoExcavacion = null;
                        });
                        
                        // Opcional: Aquí ya tienes acceso al objeto completo que se guardó en segundo plano
                        objetoCompletoTipoExcavacion = obtenerObjetoTipoExcavacionSeleccionada();
                        await evaluarYCargarPrecio();
                      },
                    ),
                  ]),

                  const SizedBox(height: 12),

                  // CARD 3: Especificación Técnica (CON IMAGEN LOCAL)
                  _buildSpecCard(baseTextStyle, textoIncluye, textoDescripcion),

                  const SizedBox(height: 12),

                  // CARD 4: Resultados
                  _buildResultCard(primaryBlue, baseTextStyle),

                  const SizedBox(height: 20),

                  // BOTÓN BUSCAR / CALCULAR
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.calculate_outlined),
                      label: Text('Calcular Precios', style: baseTextStyle.copyWith(fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        // 1. Extraemos y limpiamos el texto de los metros (quitando espacios o texto si lo hay)
                        final String metrosTexto = metrosController.text.trim();
                        
                        // 2. Extraemos el texto del precio eliminando el signo '$' y las comas de formato para poder parsearlo
                        final String precioTexto = precioController.text
                            .replaceAll('\$', '')
                            .replaceAll(',', '')
                            .trim();

                        // 3. Intentamos convertir a números reales (double). Si no son válidos, por defecto usamos 0.0
                        final double cantidadMetros = double.tryParse(metrosTexto) ?? 0.0;
                        final double precioPorMetro = double.tryParse(precioTexto) ?? 0.0;

                        // 4. Realizamos la operación matemática
                        final double resultadoTotal = cantidadMetros * precioPorMetro;

                        // 5. Actualizamos el estado y formateamos el resultado con dos decimales y comas
                        setState(() {
                          // Opción A: Si usas un controlador para pintar el total en un TextField:
                          totalController.text = '\$ ${resultadoTotal.toStringAsFixed(2)}';
                          
                          // Opción B: Si usas una variable String simple para pintarla en un Text():
                          // cadenaTotal = '\$ ${resultadoTotal.toStringAsFixed(2)}';
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
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
  Widget _buildSpecCard(
    TextStyle baseStyle,
    String? incluyeTexto, // Puede ser nulo mientras carga la API
    String? descripcionTexto,
  ) {
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
                      child: Image.network(
                        'https://shakeable-unlabeled-na.ngrok-free.dev/imagenes/${objetoCompletoTipoMaterial?['imagen']}', 
                        height: 230,
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
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9), 
                        border: Border.all(color: Colors.grey[300]!), 
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.zoom_in, color: Colors.black87),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              backgroundColor: Colors.transparent, // Fondo del diálogo invisible
                              insetPadding: const EdgeInsets.all(10), // Margen mínimo con los bordes de la pantalla
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  // Contenedor principal de la imagen con zoom integrado
                                  Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height * 0.7, // Ocupa el 70% del alto de la pantalla
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: InteractiveViewer(
                                        panEnabled: true, // Permite arrastrar la imagen cuando tiene zoom
                                        minScale: 0.5,    // Escala mínima (alejar)
                                        maxScale: 4.0,    // Escala máxima (acercar)
                                        child: Image.network(
                                          'https://shakeable-unlabeled-na.ngrok-free.dev/imagenes/${objetoCompletoTipoMaterial?['imagen']}', 
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  // Botón flotante para cerrar el modal cómodamente X
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black54,
                                      child: IconButton(
                                        icon: const Icon(Icons.close, color: Colors.white),
                                        onPressed: () => Navigator.of(context).pop(), // Cierra el modal
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: baseStyle.copyWith(color: Colors.black87, fontSize: 13),
                          children: [
                            const TextSpan(text: 'Incluye: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            // Si es nulo, muestra un mensaje sutil de carga o espacio vacío
                            TextSpan(text: incluyeTexto ?? 'No disponible por el momento.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: baseStyle.copyWith(color: Colors.black87, fontSize: 13),
                          children: [
                            const TextSpan(text: 'Descripción: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            // Si es nulo, muestra un mensaje sutil de carga o espacio vacío
                            TextSpan(text: descripcionTexto ?? 'No disponible por el momento.'),
                          ],
                        ),
                      ),
                    ),
                  ],
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
              Text('METRO A CONSTRUIR', style: baseStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
              SizedBox(
                width: 140, // Ancho ideal para una cifra numérica con su sufijo
                height: 39, // Altura compacta para que encaje perfectamente en la fila
                child: TextField(
                  controller: metrosController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true), // Abre teclado numérico con punto
                  textAlign: TextAlign.end, // Alinea el texto a la derecha junto al sufijo
                  style: baseStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(0, 245, 245, 245), // El mismo fondo gris de tus dropdowns
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    isDense: true, // Reduce el padding interno por defecto de Flutter
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6), 
                      borderSide: BorderSide.none, // Sin bordes negros toscos
                    ),
                    suffixText: ' MTS',
                    suffixStyle: baseStyle.copyWith(
                      fontSize: 14, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.black54,
                    ),
                  ),
                  onChanged: (value) {
                    // Aquí capturas lo que el usuario escriba para tus cálculos en tiempo real
                    print("Metros ingresados: $value");
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('PRECIO POR METRO', style: baseStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
              //Text('\$ 666.65', style: baseStyle.copyWith(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
              Expanded(
                child: Container(
                  height: 39,
                  alignment: Alignment.centerRight,
                  child: TextField(
                    controller: precioController,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.end, 
                    style: baseStyle.copyWith(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold, 
                      color: const Color(0xFF003D71), // Color azul de la marca para el precio
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.transparent, // Fondo transparente para que limpie la UI
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      isDense: true, 
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      print("Precio ingresado: $value");
                    },
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 24, color: Color(0xFF003D71),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('TOTAL SIN IVA', style: baseStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
              Expanded(
                child: Container(
                  height: 39,
                  alignment: Alignment.centerRight,
                  child: TextField(
                    controller: totalController,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.end, 
                    style: baseStyle.copyWith(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold, 
                      color: const Color.fromARGB(255, 0, 0, 0), // Color azul de la marca para el precio
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.transparent, // Fondo transparente para que limpie la UI
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      isDense: true, 
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      print("Total calculado: $value");
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
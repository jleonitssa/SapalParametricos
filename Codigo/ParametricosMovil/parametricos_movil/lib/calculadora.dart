import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'parametricos_api.dart';

class ConstruccionScreen extends StatefulWidget {
  const ConstruccionScreen({super.key});

  @override
  State<ConstruccionScreen> createState() => _ConstruccionScreenState();
}

class _ConstruccionScreenState extends State<ConstruccionScreen> {
  final ParametricosApi apiService = ParametricosApi();

  final Color primaryBlue = const Color(0xFF003D71);

  final TextStyle baseTextStyle = const TextStyle(
    fontFamily: 'sans-serif',
  );

  // ============================================================
  // EJERCICIOS
  // ============================================================

  final List<EjercicioCalculo> listaEjercicios = [
    EjercicioCalculo(
      id: 1,
       nombre: 'Ejercicio #1',
      isExpanded: true,
    ),
  ];

  int _siguienteIdEjercicio = 2;

  // ============================================================
  // CICLO DE VIDA
  // ============================================================

  @override
  void initState() {
    super.initState();

    _cargarDatosInicialesEjercicio(listaEjercicios.first);
  }

  @override
  void dispose() {
    for (final ejercicio in listaEjercicios) {
      ejercicio.dispose();
    }

    super.dispose();
  }

  // ============================================================
  // AGREGAR EJERCICIO
  // ============================================================

  void _agregarNuevoEjercicio() {
    // Guardamos primero el ID para utilizarlo
    // tanto en id como en el nombre predeterminado.
    final int nuevoId = _siguienteIdEjercicio++;

    final nuevoEjercicio = EjercicioCalculo(
      id: nuevoId,
      nombre: 'Ejercicio #$nuevoId',
      isExpanded: true,
    );

    setState(() {
      listaEjercicios.add(nuevoEjercicio);
    });

    _cargarDatosInicialesEjercicio(nuevoEjercicio);
  }

  // ============================================================
  // ELIMINAR EJERCICIO
  // ============================================================

  void _eliminarEjercicio(int index) {
    if (listaEjercicios.length <= 1) {
      return;
    }

    final ejercicio = listaEjercicios[index];

    setState(() {
      listaEjercicios.removeAt(index);
    });

    ejercicio.dispose();
  }

  // ============================================================
  // CARGAR DATOS INICIALES DE CADA EJERCICIO
  // ============================================================

  Future<void> _cargarDatosInicialesEjercicio(
    EjercicioCalculo ejercicio,
  ) async {
    try {
      final resultados = await Future.wait([
        apiService.obtenerLineaTrabajo(),
        apiService.obtenerTipoMaterial(),
        apiService.obtenerExcavacion(),
      ]);

      if (!mounted) {
        return;
      }

      // Verificamos que el ejercicio siga existiendo.
      if (!listaEjercicios.contains(ejercicio)) {
        return;
      }

      setState(() {
        // Línea de trabajo
        ejercicio.lineasTrabajo = resultados[0];

        ejercicio.opcionesLineaTrabajo =
            _crearOpcionesLineaTrabajo(
          ejercicio.lineasTrabajo,
        );

        // Tipo de material
        ejercicio.tiposMaterial = resultados[1];

        ejercicio.opcionesTipoMaterial =
            _crearOpcionesTipoMaterial(
          ejercicio.tiposMaterial,
        );

        // Excavación
        ejercicio.tiposExcavacion = resultados[2];

        ejercicio.opcionesTipoExcavacion =
            _crearOpcionesTipoExcavacion(
          ejercicio.tiposExcavacion,
        );
      });
    } catch (e) {
      debugPrint(
        'Error cargando datos iniciales del ejercicio '
        '${ejercicio.id}: $e',
      );
    }
  }

  // ============================================================
  // OPCIONES - LÍNEA DE TRABAJO
  // ============================================================

  List<DropdownMenuItem<int>> _crearOpcionesLineaTrabajo(
    List<dynamic> datos,
  ) {
    return datos.map<DropdownMenuItem<int>>((linea) {
      return DropdownMenuItem<int>(
        value: linea['idLineaTrabajo'],
        child: Text(
          linea['nombre']?.toString() ?? '',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      );
    }).toList();
  }

  // ============================================================
  // OPCIONES - TIPO DE MATERIAL
  // ============================================================

  List<DropdownMenuItem<int>> _crearOpcionesTipoMaterial(
    List<dynamic> datos,
  ) {
    return datos.map<DropdownMenuItem<int>>((tipo) {
      return DropdownMenuItem<int>(
        value: tipo['idTipoMaterial'],
        child: Text(
          tipo['nombre']?.toString() ?? '',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      );
    }).toList();
  }

  // ============================================================
  // OPCIONES - TIPO DE EXCAVACIÓN
  // ============================================================

  List<DropdownMenuItem<int>> _crearOpcionesTipoExcavacion(
    List<dynamic> datos,
  ) {
    return datos.map<DropdownMenuItem<int>>((tipo) {
      return DropdownMenuItem<int>(
        value: tipo['idExcavacion'],
        child: Text(
          tipo['nombre']?.toString() ?? '',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      );
    }).toList();
  }

  // ============================================================
  // OBTENER OBJETO - LÍNEA DE TRABAJO
  // ============================================================

  Map<String, dynamic>? _obtenerLineaSeleccionada(
    EjercicioCalculo ejercicio,
  ) {
    if (ejercicio.lineaTrabajoSeleccionada == null) {
      return null;
    }

    for (final linea in ejercicio.lineasTrabajo) {
      if (linea['idLineaTrabajo'] ==
          ejercicio.lineaTrabajoSeleccionada) {
        return Map<String, dynamic>.from(linea);
      }
    }

    return null;
  }

  // ============================================================
  // OBTENER OBJETO - MATERIAL
  // ============================================================

  Map<String, dynamic>? _obtenerMaterialSeleccionado(
    EjercicioCalculo ejercicio,
  ) {
    if (ejercicio.tipoMaterialSeleccionado == null) {
      return null;
    }

    for (final tipo in ejercicio.tiposMaterial) {
      if (tipo['idTipoMaterial'] ==
          ejercicio.tipoMaterialSeleccionado) {
        return Map<String, dynamic>.from(tipo);
      }
    }

    return null;
  }

  // ============================================================
  // OBTENER OBJETO - TIPO DE OBRA
  // ============================================================

  Map<String, dynamic>? _obtenerTipoObraSeleccionado(
    EjercicioCalculo ejercicio,
  ) {
    if (ejercicio.tipoObraSeleccionada == null) {
      return null;
    }

    for (final tipo in ejercicio.tiposObra) {
      if (tipo['idTipoObra'] ==
          ejercicio.tipoObraSeleccionada) {
        return Map<String, dynamic>.from(tipo);
      }
    }

    return null;
  }

  // ============================================================
  // OBTENER OBJETO - TUBERÍA
  // ============================================================

  Map<String, dynamic>? _obtenerTipoTuberiaSeleccionado(
    EjercicioCalculo ejercicio,
  ) {
    if (ejercicio.tipoTuberiaSeleccionada == null) {
      return null;
    }

    for (final tipo in ejercicio.tiposTuberia) {
      if (tipo['idTuberia'] ==
          ejercicio.tipoTuberiaSeleccionada) {
        return Map<String, dynamic>.from(tipo);
      }
    }

    return null;
  }

  // ============================================================
  // OBTENER OBJETO - DIÁMETRO
  // ============================================================

  Map<String, dynamic>? _obtenerDiametroSeleccionado(
    EjercicioCalculo ejercicio,
  ) {
    if (ejercicio.diametroTuberiaSeleccionado == null) {
      return null;
    }

    for (final diametro in ejercicio.diametrosTuberia) {
      if (diametro['idDiametro'] ==
          ejercicio.diametroTuberiaSeleccionado) {
        return Map<String, dynamic>.from(diametro);
      }
    }

    return null;
  }

  // ============================================================
  // OBTENER OBJETO - EXCAVACIÓN
  // ============================================================

  Map<String, dynamic>? _obtenerExcavacionSeleccionada(
    EjercicioCalculo ejercicio,
  ) {
    if (ejercicio.tipoExcavacionSeleccionada == null) {
      return null;
    }

    for (final tipo in ejercicio.tiposExcavacion) {
      if (tipo['idExcavacion'] ==
          ejercicio.tipoExcavacionSeleccionada) {
        return Map<String, dynamic>.from(tipo);
      }
    }

    return null;
  }

  // ============================================================
  // CARGAR TIPO DE OBRA
  // ============================================================

  Future<void> _cargarTipoObra(
    EjercicioCalculo ejercicio,
    int idClaveTrabajo,
  ) async {
    try {
      final datos = await apiService.obtenerTipoObra(
        idClaveTrabajo: idClaveTrabajo,
      );

      if (!mounted) {
        return;
      }

      if (!listaEjercicios.contains(ejercicio)) {
        return;
      }

      setState(() {
        ejercicio.tiposObra = datos;

        ejercicio.opcionesTipoObra =
            datos.map<DropdownMenuItem<int>>((tipo) {
          return DropdownMenuItem<int>(
            value: tipo['idTipoObra'],
            child: Text(
              tipo['nombre']?.toString() ?? '',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          );
        }).toList();
      });
    } catch (e) {
      debugPrint(
        'Error cargando tipo de obra '
        'del ejercicio ${ejercicio.id}: $e',
      );
    }
  }

  // ============================================================
  // CARGAR TIPO DE TUBERÍA
  // ============================================================

  Future<void> _cargarTipoTuberia(
    EjercicioCalculo ejercicio,
    int idLineaTrabajo,
    int idTipoObra,
  ) async {
    try {
      final datos =
          await apiService.obtenerRelacionLineaObraTuberia(
        idLineaTrabajo: idLineaTrabajo,
        idTipoObra: idTipoObra,
      );

      if (!mounted) {
        return;
      }

      if (!listaEjercicios.contains(ejercicio)) {
        return;
      }

      setState(() {
        ejercicio.tiposTuberia = datos;

        ejercicio.opcionesTipoTuberia =
            datos.map<DropdownMenuItem<int>>((tipo) {
          return DropdownMenuItem<int>(
            value: tipo['idTuberia'],
            child: Text(
              tipo['tuberia']?.toString() ?? '',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          );
        }).toList();

        // Conservamos el comportamiento original:
        // seleccionar automáticamente la primera tubería.
        if (ejercicio.opcionesTipoTuberia.isNotEmpty) {
          ejercicio.tipoTuberiaSeleccionada =
              ejercicio.opcionesTipoTuberia.first.value;
        }
      });
    } catch (e) {
      debugPrint(
        'Error cargando tipo de tubería '
        'del ejercicio ${ejercicio.id}: $e',
      );
    }
  }

  // ============================================================
  // CARGAR DIÁMETROS
  // ============================================================

  Future<void> _cargarDiametros(
    EjercicioCalculo ejercicio,
    int idRelacionObra,
  ) async {
    try {
      final datos =
          await apiService.obtenerRelacionObraDiametro(
        idRelacionObra: idRelacionObra,
      );

      if (!mounted) {
        return;
      }

      if (!listaEjercicios.contains(ejercicio)) {
        return;
      }

      setState(() {
        ejercicio.diametrosTuberia = datos;

        ejercicio.opcionesDiametrosTuberia =
            datos.map<DropdownMenuItem<int>>((tipo) {
          return DropdownMenuItem<int>(
            value: tipo['idDiametro'],
            child: Text(
              tipo['diametro']?.toString() ?? '',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          );
        }).toList();

        // Conservamos el comportamiento original:
        // seleccionar automáticamente el primer diámetro.
        if (ejercicio.opcionesDiametrosTuberia.isNotEmpty) {
          ejercicio.diametroTuberiaSeleccionado =
              ejercicio.opcionesDiametrosTuberia.first.value;
        }
      });
    } catch (e) {
      debugPrint(
        'Error cargando diámetros '
        'del ejercicio ${ejercicio.id}: $e',
      );
    }
  }

  // ============================================================
  // OBTENER PRECIO FINAL
  // ============================================================

  Future<void> _evaluarYCargarPrecio(
    EjercicioCalculo ejercicio,
  ) async {
    final diametro =
        ejercicio.objetoCompletoDiametroTuberia;

    final material =
        ejercicio.objetoCompletoTipoMaterial;

    final excavacion =
        ejercicio.objetoCompletoTipoExcavacion;

    // Todavía no tenemos todos los parámetros.
    if (diametro == null ||
        material == null ||
        excavacion == null) {
      if (!mounted) {
        return;
      }

      if (!listaEjercicios.contains(ejercicio)) {
        return;
      }

      setState(() {
        ejercicio.precioController.text = '\$ 0.00';
        ejercicio.textoDescripcion = null;
      });

      return;
    }

    try {
      final resultado =
          await apiService.obtenerRelacionFinalPrecio(
        idRelacionDiametro:
            diametro['idRelacion'],
        idTipoMaterial:
            material['idTipoMaterial'],
        idExcavacion:
            excavacion['idExcavacion'],
      );

      if (!mounted) {
        return;
      }

      if (!listaEjercicios.contains(ejercicio)) {
        return;
      }

      if (resultado.isNotEmpty) {
        final precio = resultado[0]['precio'];

        setState(() {
          ejercicio.precioController.text =
              '\$ ${precio ?? 0}';

          ejercicio.textoDescripcion =
              resultado[0]['descripcion'];
        });
      } else {
        setState(() {
          ejercicio.precioController.text =
              '\$ 0.00';

          ejercicio.textoDescripcion = null;
        });
      }
    } catch (e) {
      debugPrint(
        'Error obteniendo precio del ejercicio '
        '${ejercicio.id}: $e',
      );

      if (!mounted) {
        return;
      }

      if (!listaEjercicios.contains(ejercicio)) {
        return;
      }

      setState(() {
        ejercicio.precioController.text =
            '\$ 0.00';
      });
    }
  }

  // ============================================================
  // CALCULAR TOTAL DEL EJERCICIO
  // ============================================================

  void _calcularEjercicio(
    EjercicioCalculo ejercicio,
  ) {
    // ==========================================================
    // METROS
    // ==========================================================

    final metrosTexto =
        ejercicio.metrosController.text
            .replaceAll(',', '')
            .trim();

    // ==========================================================
    // PRECIO POR METRO
    // ==========================================================

    final precioTexto =
        ejercicio.precioController.text
            .replaceAll('\$', '')
            .replaceAll(',', '')
            .trim();

    // ==========================================================
    // PENDIENTE
    // ==========================================================

    final pendienteTexto =
        ejercicio.pendienteController.text
            .replaceAll('%', '')
            .replaceAll(',', '')
            .trim();

    final double cantidadMetros =
        double.tryParse(metrosTexto) ?? 0.0;

    final double precioPorMetro =
        double.tryParse(precioTexto) ?? 0.0;

    final double porcentajePendiente =
        double.tryParse(pendienteTexto) ?? 0.0;

    // ==========================================================
    // SUBTOTAL
    // ==========================================================

    final double subtotal =
        cantidadMetros * precioPorMetro;

    // ==========================================================
    // IMPORTE DE PENDIENTE
    // ==========================================================

    double importePendiente = 0.0;

    if (
        ejercicio.lineaTrabajoSeleccionada == 4 &&
        porcentajePendiente > 0) {

      importePendiente =
          subtotal *
          (porcentajePendiente / 100);
    }

    // ==========================================================
    // TOTAL SIN IVA
    // ==========================================================

    final double resultadoTotal =
        subtotal + importePendiente;

    setState(() {
      ejercicio.totalController.text =
          '\$ ${resultadoTotal.toStringAsFixed(2)}';
    });
  }

  // ============================================================
  // CALCULAR GRAN TOTAL
  // ============================================================

  double _obtenerGranTotal() {
    double granTotal = 0.0;

    for (final ejercicio in listaEjercicios) {
      final totalTexto = ejercicio.totalController.text
          .replaceAll('\$', '')
          .replaceAll(',', '')
          .trim();

      final total = double.tryParse(totalTexto) ?? 0.0;

      granTotal += total;
    }

    return granTotal;
  }
  
  // ============================================================
  // DESCARGAR PRESUPUESTO HTML
  // ============================================================

  Future<void> _descargarPresupuesto() async {
    try {
      // ========================================================
      // RECALCULAR TODOS LOS EJERCICIOS
      // ========================================================

      for (final ejercicio in listaEjercicios) {
        _calcularEjercicio(ejercicio);
      }

      // ========================================================
      // GENERAR HTML
      // ========================================================

      final String contenidoHtml =
          _generarHtmlPresupuesto();

      // ========================================================
      // OBTENER DIRECTORIO TEMPORAL
      // ========================================================

      final Directory directorio =
          await getTemporaryDirectory();

      final DateTime ahora = DateTime.now();

      final String fechaArchivo =
          '${ahora.year}'
          '${ahora.month.toString().padLeft(2, '0')}'
          '${ahora.day.toString().padLeft(2, '0')}_'
          '${ahora.hour.toString().padLeft(2, '0')}'
          '${ahora.minute.toString().padLeft(2, '0')}';

      final String nombreArchivo =
          'Presupuesto_$fechaArchivo.html';

      final File archivo = File(
        '${directorio.path}/$nombreArchivo',
      );

      // ========================================================
      // GUARDAR HTML
      // ========================================================

      await archivo.writeAsString(
        contenidoHtml,
        encoding: utf8,
        flush: true,
      );

      // ========================================================
      // COMPARTIR / GUARDAR
      // ========================================================

      if (!mounted) return;

      await SharePlus.instance.share(
        ShareParams(
          files: [
            XFile(
              archivo.path,
              mimeType: 'text/html',
            ),
          ],
          subject: 'Presupuesto',
          text: 'Presupuesto generado desde Costos Paramétricos.',
        ),
      );
    } catch (e) {
      debugPrint(
        'Error generando presupuesto: $e',
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No fue posible generar el presupuesto.\n$e',
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }


  // ============================================================
  // GENERAR HTML DEL PRESUPUESTO
  // ============================================================

  String _generarHtmlPresupuesto() {
    final double subtotal = _obtenerGranTotal();
    final double iva = subtotal * 0.16;
    final double total = subtotal + iva;

    final DateTime ahora = DateTime.now();

    final String fecha =
        '${ahora.day.toString().padLeft(2, '0')}/'
        '${ahora.month.toString().padLeft(2, '0')}/'
        '${ahora.year}';

    final String ejerciciosHtml = _generarFilasEjercicios();

    return '''
  <!DOCTYPE html>
  <html>
  <head>
    <meta charset="UTF-8">

    <style>
      body {
        font-family: Arial, Helvetica, sans-serif;
        margin: 25px;
        color: #000000;
      }

      table {
        border-collapse: collapse;
      }

      .tabla-presupuesto td {
        padding: 5px 6px;
      }

      .fila-ejercicio td {
        border-bottom: 0.5px solid #999999;
      }
    </style>
  </head>

  <body>

    <table border="0" style="width: 100%;">
      <tr>

        <td style="width: 50px;" rowspan="4">
          <img
            src="http://187.188.214.154/ParametricosApi/plantillas/favicon.png"
            style="width:50px"
          >
        </td>

        <td style="text-align: center; font-size: 15pt;">
          Sistema de Agua Potable y Alcantarillado de Le&oacute;n
          <br />&nbsp;
        </td>

        <td
          style="vertical-align: top; text-align: right;"
          rowspan="4"
        >
          $fecha
        </td>

      </tr>

      <tr>
        <td
          style="
            text-align: center;
            font-size: 11pt;
            font-weight: bold;
          "
        >
          Costos y Evaluaci&oacute;n
        </td>
      </tr>

      <tr>
        <td
          style="
            text-align: center;
            font-size: 11pt;
            font-weight: bold;
          "
        >
          COSTOS PARAM&Eacute;TRICOS
          <br />&nbsp;
        </td>
      </tr>

      <tr>
        <td
          style="
            text-align: center;
            font-size: 11pt;
          "
        >
          Elabor&oacute;: Usuario
        </td>
      </tr>

    </table>


    <table
      style="
        width: 100%;
        border-top-width: 0.5px;
        border-bottom-width: 0.5px;
        border-top-style: solid;
        border-bottom-style: solid;
        margin-top: 10px;
      "
    >
      <tr>
        <td
          style="
            text-align: center;
            font-size: 12pt;
            font-weight: bold;
            padding: 5px;
          "
        >
          PRESUPUESTO
        </td>
      </tr>
    </table>


    <table
      border="0"
      class="tabla-presupuesto"
      style="width: 100%;"
    >

      <tr>

        <td
          style="
            font-size: 9.5pt;
            border-top: 0.5px solid;
            border-bottom: 0.5px solid;
            text-align: center;
          "
        >
          Clv. Usuario
        </td>

        <td
          style="
            font-size: 9.5pt;
            border-top: 0.5px solid;
            border-bottom: 0.5px solid;
            text-align: center;
          "
        >
          Descripci&oacute;n
        </td>

        <td
          style="
            font-size: 9.5pt;
            border-top: 0.5px solid;
            border-bottom: 0.5px solid;
            text-align: center;
          "
        >
          Unidad
        </td>

        <td
          style="
            font-size: 9.5pt;
            border-top: 0.5px solid;
            border-bottom: 0.5px solid;
            text-align: center;
          "
        >
          Cantidad
        </td>

        <td
          style="
            font-size: 9.5pt;
            border-top: 0.5px solid;
            border-bottom: 0.5px solid;
            text-align: center;
          "
        >
          Precio Unitario
        </td>

        <td
          style="
            font-size: 9.5pt;
            border-top: 0.5px solid;
            border-bottom: 0.5px solid;
            text-align: center;
          "
        >
          Total
        </td>

      </tr>


      $ejerciciosHtml


      <tr>

        <td
          style="font-size: 9.5pt;"
          colspan="5"
        >
          <b>Subtotal de Presupuesto</b>
        </td>

        <td
          style="
            font-size: 9.5pt;
            text-align: right;
          "
        >
          <b>${_formatearMoneda(subtotal)}</b>
        </td>

      </tr>


      <tr>
        <td
          style="font-size: 9.5pt;"
          colspan="6"
        >
          <b>
            ** ${_numeroALetraPlaceholder(subtotal)} **
          </b>
        </td>
      </tr>


      <tr>
        <td
          style="font-size: 9.5pt;"
          colspan="6"
        >
          &nbsp;
        </td>
      </tr>


      <tr>

        <td
          style="
            font-size: 9.5pt;
            text-align: right;
          "
          colspan="5"
        >
          <b>I.V.A. 16%&nbsp;&nbsp;&nbsp;</b>
        </td>

        <td
          style="
            font-size: 9.5pt;
            text-align: right;
          "
        >
          <b>${_formatearMoneda(iva)}</b>
        </td>

      </tr>


      <tr>

        <td
          style="
            font-size: 9.5pt;
            text-align: right;
          "
          colspan="5"
        >
          <b>TOTAL&nbsp;&nbsp;&nbsp;</b>
        </td>

        <td
          style="
            font-size: 9.5pt;
            text-align: right;
          "
        >
          <b>${_formatearMoneda(total)}</b>
        </td>

      </tr>


      <tr>
        <td
          style="font-size: 9.5pt;"
          colspan="6"
        >
          <b>
            ** ${_numeroALetraPlaceholder(total)} **
          </b>
        </td>
      </tr>

    </table>

  </body>
  </html>
  ''';
  }


  // ============================================================
  // GENERAR FILAS DE EJERCICIOS
  // ============================================================

  String _generarFilasEjercicios() {
    final StringBuffer filas = StringBuffer();

    for (int i = 0; i < listaEjercicios.length; i++) {
      final ejercicio = listaEjercicios[i];

      final double cantidad =
          _obtenerNumeroController(
        ejercicio.metrosController,
      );

      final double precio =
          _obtenerNumeroController(
        ejercicio.precioController,
      );

      final double total =
          _obtenerNumeroController(
        ejercicio.totalController,
      );

      final String descripcion =
          ejercicio.textoDescripcion ??
          'Ejercicio ${i + 1}';

      // Por el momento usamos el consecutivo.
      // Aquí podemos colocar posteriormente la clave real
      // proveniente de la API.
      final String clave =
          (i + 1).toString().padLeft(3, '0');

      filas.write('''
        <tr class="fila-ejercicio">

          <td
            style="
              font-size: 9.5pt;
              text-align: center;
            "
          >
            ${_escapeHtml(clave)}
          </td>

          <td
            style="
              font-size: 9.5pt;
              text-align: left;
            "
          >
            ${_escapeHtml(descripcion)}
          </td>

          <td
            style="
              font-size: 9.5pt;
              text-align: center;
            "
          >
            ML
          </td>

          <td
            style="
              font-size: 9.5pt;
              text-align: right;
            "
          >
            ${cantidad.toStringAsFixed(2)}
          </td>

          <td
            style="
              font-size: 9.5pt;
              text-align: right;
            "
          >
            ${_formatearMoneda(precio)}
          </td>

          <td
            style="
              font-size: 9.5pt;
              text-align: right;
            "
          >
            ${_formatearMoneda(total)}
          </td>

        </tr>
      ''');
    }

    return filas.toString();
  }


  // ============================================================
  // OBTENER NÚMERO DESDE CONTROLLER
  // ============================================================

  double _obtenerNumeroController(
    TextEditingController controller,
  ) {
    final String valor = controller.text
        .replaceAll('\$', '')
        .replaceAll(',', '')
        .replaceAll('%', '')
        .trim();

    return double.tryParse(valor) ?? 0.0;
  }


  // ============================================================
  // FORMATEAR MONEDA
  // ============================================================

  String _formatearMoneda(double valor) {
    final String numero = valor.toStringAsFixed(2);

    final partes = numero.split('.');

    final String entero = partes[0];
    final String decimal = partes[1];

    final buffer = StringBuffer();

    for (int i = 0; i < entero.length; i++) {
      final posicionRestante =
          entero.length - i;

      buffer.write(entero[i]);

      if (posicionRestante > 1 &&
          posicionRestante % 3 == 1) {
        buffer.write(',');
      }
    }

    return '\$${buffer.toString()}.$decimal';
  }


  // ============================================================
  // ESCAPAR HTML
  // ============================================================

  String _escapeHtml(String texto) {
    return const HtmlEscape().convert(texto);
  }


  // ============================================================
  // NÚMERO A LETRA
  // ============================================================

  String _numeroALetraPlaceholder(double valor) {
    // Posteriormente podemos reemplazar esta función
    // por la conversión completa de cantidad a letras.

    return '${_formatearMoneda(valor)} M.N.';
  }

  // ============================================================
  // DESCRIPCIÓN EJERCICIO
  // ============================================================

  String _obtenerDescripcionEjercicio(
    EjercicioCalculo ejercicio,
  ) {
    final List<String> partes = [];

    // Línea de Trabajo
    final String? lineaTrabajo =
        ejercicio.objetoCompletoLineaTrabajo?['nombre']
            ?.toString()
            .trim();

    // Tipo de Tubería
    final String? tipoTuberia =
        ejercicio.objetoCompletoTipoTuberia?['tuberia']
            ?.toString()
            .trim();

    // Diámetro de Tubería
    final String? diametro =
        ejercicio.objetoCompletoDiametroTuberia?['diametro']
            ?.toString()
            .trim();

    if (lineaTrabajo != null && lineaTrabajo.isNotEmpty) {
      partes.add(lineaTrabajo);
    }

    if (tipoTuberia != null && tipoTuberia.isNotEmpty) {
      partes.add(tipoTuberia);
    }

    if (diametro != null && diametro.isNotEmpty) {
      partes.add(diametro);
    }

    if (partes.isEmpty) {
      return 'Configure los parámetros del ejercicio';
    }

    return partes.join('  •  ');
  }

  // ============================================================
  // CAMBIAR NOMBRE EJERCICIO
  // ============================================================

  Future<void> _editarNombreEjercicio(
    EjercicioCalculo ejercicio,
  ) async {
    String nombreTemporal = ejercicio.nombre;

    final String? nuevoNombre = await showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          title: Text(
            'Cambiar nombre',
            style: baseTextStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryBlue,
            ),
          ),

          content: TextFormField(
            initialValue: ejercicio.nombre,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            maxLength: 60,

            decoration: InputDecoration(
              labelText: 'Nombre del ejercicio',
              hintText: 'Ej. Línea principal',
              prefixIcon: const Icon(
                Icons.edit_outlined,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            onChanged: (value) {
              nombreTemporal = value;
            },

            onFieldSubmitted: (value) {
              final String nombre = value.trim();

              if (nombre.isNotEmpty) {
                Navigator.of(dialogContext).pop(nombre);
              }
            },
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'Cancelar',
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                final String nombre =
                    nombreTemporal.trim();

                if (nombre.isEmpty) {
                  return;
                }

                Navigator.of(dialogContext).pop(
                  nombre,
                );
              },
              child: const Text(
                'Guardar',
              ),
            ),
          ],
        );
      },
    );

    if (nuevoNombre == null ||
        nuevoNombre.trim().isEmpty) {
      return;
    }

    if (!mounted) return;

    setState(() {
      ejercicio.nombre =
          nuevoNombre.trim();
    });
  }

  // ============================================================
  // CONFIRMAR ELIMINAR EJERCICIO
  // ============================================================

  Future<void> _confirmarEliminarEjercicio(
    int index,
    EjercicioCalculo ejercicio,
  ) async {
    final bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  'Eliminar ejercicio',
                  style: baseTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
              ),
            ],
          ),

          content: Text(
            '¿Estás seguro de que deseas eliminar '
            '"${ejercicio.nombre}"?\n\n'
            'Esta acción no se puede deshacer.',
            style: baseTextStyle.copyWith(
              fontSize: 14,
              color: const Color(0xFF667085),
              height: 1.4,
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text(
                'Cancelar',
              ),
            ),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              icon: const Icon(
                Icons.delete_outline,
                size: 18,
              ),
              label: const Text(
                'Eliminar',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );

    if (confirmar != true) {
      return;
    }

    if (!mounted) return;

    _eliminarEjercicio(index);
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9),

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,

        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 30,
            ),
            child: Container(
              color: primaryBlue,
            ),
          ),
        ),

        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(100),

            child: Image.asset(
              'assets/favicon.png',
              fit: BoxFit.cover,
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

      // ========================================================
      // BODY
      // ========================================================

      body: SingleChildScrollView(
        child: Column(
          children: [

            // ==================================================
            // HEADER
            // ==================================================

            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 20,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  // ==================================================
                  // TÍTULO
                  // ==================================================

                  Text(
                    'Cálculo de Construcción',
                    textAlign: TextAlign.left,
                    style: baseTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryBlue,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // ==================================================
                  // DESCRIPCIÓN
                  // ==================================================

                  Text(
                    'Determinación de costos por metro '
                    'lineal mediante parámetros técnicos.',
                    textAlign: TextAlign.left,
                    style: baseTextStyle.copyWith(
                      color: Colors.black54,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ==================================================
                  // BOTÓN AGREGAR EJERCICIO
                  // ==================================================

                  Center(
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [

                        // ======================================================
                        // AGREGAR EJERCICIO
                        // ======================================================

                        ElevatedButton.icon(
                          onPressed: _agregarNuevoEjercicio,

                          icon: const Icon(
                            Icons.add,
                            size: 18,
                          ),

                          label: const Text(
                            'Agregar Ejercicio',
                          ),

                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryBlue,
                            foregroundColor: Colors.white,

                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),


                        // ======================================================
                        // DESCARGAR PRESUPUESTO
                        // ======================================================

                        OutlinedButton.icon(
                          onPressed: _descargarPresupuesto,

                          icon: const Icon(
                            Icons.download_outlined,
                            size: 18,
                          ),

                          label: const Text(
                            'Descargar Presupuesto',
                          ),

                          style: OutlinedButton.styleFrom(
                            foregroundColor: primaryBlue,

                            side: BorderSide(
                              color: primaryBlue,
                            ),

                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ==================================================
            // LISTA DE EJERCICIOS
            // ==================================================

            Padding(
              padding:
                  const EdgeInsets.all(16.0),

              child: ListView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount:
                    listaEjercicios.length,

                itemBuilder:
                    (context, index) {
                  final ejercicio =
                      listaEjercicios[index];

                  return _buildEjercicioCard(
                    ejercicio,
                    index,
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // ==================================================
            // GRAN TOTAL
            // ==================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              child: _buildGranTotalCard(
                color: primaryBlue,
                baseStyle: baseTextStyle,
              ),
            ),

            const SizedBox(height: 120),

          ],
        ),
      ),
    );
  }

  // ============================================================
  // CARD DE EJERCICIO
  // ============================================================

  Widget _buildEjercicioCard(
    EjercicioCalculo ejercicio,
    int index,
  ) {
    return Card(
      margin:
          const EdgeInsets.only(bottom: 16),

      elevation: 2,

      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),

      clipBehavior:
          Clip.antiAlias,

      child: ExpansionTile(
        key: ValueKey(
          'ejercicio_${ejercicio.id}',
        ),

        initiallyExpanded:
            ejercicio.isExpanded,

        shape: const Border(), 
        collapsedShape: const Border(),

        onExpansionChanged:
            (expanded) {
          ejercicio.isExpanded =
              expanded;
        },

        collapsedBackgroundColor:
            Colors.white,

        backgroundColor:
            Colors.grey[50],

        title: Text(
          ejercicio.nombre,
          style: baseTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: primaryBlue,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            _obtenerDescripcionEjercicio(ejercicio),
            style: baseTextStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade500,
              height: 1.25,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            // EDITAR NOMBRE
            IconButton(
              icon: Icon(
                Icons.edit_outlined,
                size: 20,
                color: primaryBlue.withOpacity(0.75),
              ),
              tooltip: 'Editar nombre',
              onPressed: () {
                _editarNombreEjercicio(ejercicio);
              },
            ),

            // ELIMINAR EJERCICIO
            if (listaEjercicios.length > 1)
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                ),
                tooltip: 'Eliminar ejercicio',
                onPressed: () {
                  _confirmarEliminarEjercicio(
                    index,
                    ejercicio,
                  );
                },
              ),

            // EXPANDIR / CONTRAER
            const Icon(
              Icons.expand_more,
            ),
          ],
        ),

        children: [

          Padding(
            padding:
                const EdgeInsets.all(
              16.0,
            ),

            child: Column(
              children: [

                // ============================================
                // CARD 1
                // LÍNEA Y MATERIAL
                // ============================================

                _buildSectionCard(
                  [

                    // LÍNEA DE TRABAJO
                    _buildDropdown(
                      label:
                          'LÍNEA DE TRABAJO',

                      currentValue:
                          ejercicio
                              .lineaTrabajoSeleccionada,

                      items:
                          ejercicio
                              .opcionesLineaTrabajo,

                      baseStyle:
                          baseTextStyle,

                      onChanged:
                          (int? nuevoId) async {
                        if (nuevoId == null) {
                          return;
                        }

                        setState(() {
                          ejercicio
                                  .lineaTrabajoSeleccionada =
                              nuevoId;

                          ejercicio
                                  .objetoCompletoLineaTrabajo =
                              _obtenerLineaSeleccionada(
                            ejercicio,
                          );

                          ejercicio.textoIncluye =
                              ejercicio
                                  .objetoCompletoLineaTrabajo?[
                                      'incluye'];

                          // Limpiar dependencias
                          ejercicio
                                  .tipoObraSeleccionada =
                              null;

                          ejercicio
                                  .tipoTuberiaSeleccionada =
                              null;

                          ejercicio
                                  .diametroTuberiaSeleccionado =
                              null;

                          ejercicio
                                  .objetoCompletoTipoObra =
                              null;

                          ejercicio
                                  .objetoCompletoTipoTuberia =
                              null;

                          ejercicio
                                  .objetoCompletoDiametroTuberia =
                              null;

                          ejercicio
                              .opcionesTipoObra = [];

                          ejercicio
                              .opcionesTipoTuberia = [];

                          ejercicio
                              .opcionesDiametrosTuberia =
                              [];

                          ejercicio.pendienteController.text = '0';
                        });

                        final idClaveTrabajo =
                            ejercicio
                                .objetoCompletoLineaTrabajo?[
                                'idClaveTrabajo'];

                        if (idClaveTrabajo ==
                            null) {
                          return;
                        }

                        await _cargarTipoObra(
                          ejercicio,
                          idClaveTrabajo,
                        );
                      },
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    // TIPO DE MATERIAL
                    _buildDropdown(
                      label:
                          'TIPO DE MATERIAL',

                      currentValue:
                          ejercicio
                              .tipoMaterialSeleccionado,

                      items:
                          ejercicio
                              .opcionesTipoMaterial,

                      baseStyle:
                          baseTextStyle,

                      onChanged:
                          (int? nuevoId) async {
                        if (nuevoId == null) {
                          return;
                        }

                        setState(() {
                          ejercicio
                                  .tipoMaterialSeleccionado =
                              nuevoId;

                          ejercicio
                                  .objetoCompletoTipoMaterial =
                              _obtenerMaterialSeleccionado(
                            ejercicio,
                          );
                        });

                        await _evaluarYCargarPrecio(
                          ejercicio,
                        );
                      },
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    // TIPO DE OBRA
                    _buildDropdown(
                      label:
                          'TIPO DE OBRA',

                      currentValue:
                          ejercicio
                              .tipoObraSeleccionada,

                      items:
                          ejercicio
                              .opcionesTipoObra,

                      baseStyle:
                          baseTextStyle,

                      onChanged:
                          (int? nuevoId) async {
                        if (nuevoId == null) {
                          return;
                        }

                        setState(() {
                          ejercicio
                                  .tipoObraSeleccionada =
                              nuevoId;

                          ejercicio
                                  .objetoCompletoTipoObra =
                              _obtenerTipoObraSeleccionado(
                            ejercicio,
                          );

                          ejercicio
                                  .tipoTuberiaSeleccionada =
                              null;

                          ejercicio
                                  .diametroTuberiaSeleccionado =
                              null;

                          ejercicio
                                  .objetoCompletoTipoTuberia =
                              null;

                          ejercicio
                                  .objetoCompletoDiametroTuberia =
                              null;

                          ejercicio
                              .opcionesTipoTuberia = [];

                          ejercicio
                              .opcionesDiametrosTuberia =
                              [];
                        });

                        final idLineaTrabajo =
                            ejercicio
                                .objetoCompletoLineaTrabajo?[
                                'idLineaTrabajo'];

                        final idTipoObra =
                            ejercicio
                                .objetoCompletoTipoObra?[
                                'idTipoObra'];

                        if (idLineaTrabajo ==
                                null ||
                            idTipoObra == null) {
                          return;
                        }

                        await _cargarTipoTuberia(
                          ejercicio,
                          idLineaTrabajo,
                          idTipoObra,
                        );

                        if (ejercicio
                                .tipoTuberiaSeleccionada !=
                            null) {
                          ejercicio
                                  .objetoCompletoTipoTuberia =
                              _obtenerTipoTuberiaSeleccionado(
                            ejercicio,
                          );

                          final idRelacion =
                              ejercicio
                                  .objetoCompletoTipoTuberia?[
                                  'idRelacion'];

                          if (idRelacion ==
                              null) {
                            return;
                          }

                          await _cargarDiametros(
                            ejercicio,
                            idRelacion,
                          );

                          if (ejercicio
                                  .diametroTuberiaSeleccionado !=
                              null) {
                            ejercicio
                                    .objetoCompletoDiametroTuberia =
                                _obtenerDiametroSeleccionado(
                              ejercicio,
                            );

                            await _evaluarYCargarPrecio(
                              ejercicio,
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),

                const SizedBox(
                  height: 12,
                ),

                // ============================================
                // CARD 2
                // TUBERÍA, DIÁMETRO Y EXCAVACIÓN
                // ============================================

                _buildSectionCard(
                  [

                    // TIPO DE TUBERÍA
                    _buildDropdown(
                      label:
                          'TIPO DE TUBERÍA',

                      currentValue:
                          ejercicio
                              .tipoTuberiaSeleccionada,

                      items:
                          ejercicio
                              .opcionesTipoTuberia,

                      baseStyle:
                          baseTextStyle,

                      onChanged:
                          (int? nuevoId) async {
                        if (nuevoId == null) {
                          return;
                        }

                        setState(() {
                          ejercicio
                                  .tipoTuberiaSeleccionada =
                              nuevoId;

                          ejercicio
                                  .diametroTuberiaSeleccionado =
                              null;

                          ejercicio
                                  .objetoCompletoTipoTuberia =
                              _obtenerTipoTuberiaSeleccionado(
                            ejercicio,
                          );

                          ejercicio
                                  .objetoCompletoDiametroTuberia =
                              null;

                          ejercicio
                              .opcionesDiametrosTuberia =
                              [];
                        });

                        final idRelacion =
                            ejercicio
                                .objetoCompletoTipoTuberia?[
                                'idRelacion'];

                        if (idRelacion == null) {
                          return;
                        }

                        await _cargarDiametros(
                          ejercicio,
                          idRelacion,
                        );

                        if (ejercicio
                                .diametroTuberiaSeleccionado !=
                            null) {
                          ejercicio
                                  .objetoCompletoDiametroTuberia =
                              _obtenerDiametroSeleccionado(
                            ejercicio,
                          );

                          await _evaluarYCargarPrecio(
                            ejercicio,
                          );
                        }
                      },
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    // DIÁMETRO
                    _buildDropdown(
                      label:
                          'DIÁMETRO DE TUBERÍA',

                      currentValue:
                          ejercicio
                              .diametroTuberiaSeleccionado,

                      items:
                          ejercicio
                              .opcionesDiametrosTuberia,

                      baseStyle:
                          baseTextStyle,

                      onChanged:
                          (int? nuevoId) async {
                        if (nuevoId == null) {
                          return;
                        }

                        setState(() {
                          ejercicio
                                  .diametroTuberiaSeleccionado =
                              nuevoId;

                          ejercicio
                                  .objetoCompletoDiametroTuberia =
                              _obtenerDiametroSeleccionado(
                            ejercicio,
                          );
                        });

                        await _evaluarYCargarPrecio(
                          ejercicio,
                        );
                      },
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    // EXCAVACIÓN
                    _buildDropdown(
                      label:
                          'EXCAVACIÓN EN',

                      currentValue:
                          ejercicio
                              .tipoExcavacionSeleccionada,

                      items:
                          ejercicio
                              .opcionesTipoExcavacion,

                      baseStyle:
                          baseTextStyle,

                      onChanged:
                          (int? nuevoId) async {
                        if (nuevoId == null) {
                          return;
                        }

                        setState(() {
                          ejercicio
                                  .tipoExcavacionSeleccionada =
                              nuevoId;

                          ejercicio
                                  .objetoCompletoTipoExcavacion =
                              _obtenerExcavacionSeleccionada(
                            ejercicio,
                          );
                        });

                        await _evaluarYCargarPrecio(
                          ejercicio,
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(
                  height: 12,
                ),

                // ============================================
                // CARD 3
                // ESPECIFICACIÓN TÉCNICA
                // ============================================

                _buildSpecCard(
                  baseStyle: baseTextStyle,
                  incluyeTexto:
                      ejercicio.textoIncluye,
                  descripcionTexto:
                      ejercicio.textoDescripcion,
                  descripcion1: 
                    ejercicio. 
                      objetoCompletoTipoMaterial?['descripcion1'].toString(), 
                  descripcion2: 
                    ejercicio. 
                      objetoCompletoTipoMaterial?['descripcion2'].toString(), 
                  descripcion3:
                    ejercicio. 
                      objetoCompletoTipoMaterial?['descripcion3'].toString(),
                  imagen:
                      ejercicio
                          .objetoCompletoTipoMaterial?[
                          'imagen'],
                ),

                const SizedBox(
                  height: 12,
                ),

                // ============================================
                // CARD 4
                // RESULTADOS
                // ============================================

                _buildResultCard(
                  color: primaryBlue,
                  baseStyle:
                      baseTextStyle,

                  metrosController:
                      ejercicio
                          .metrosController,

                  precioController:
                      ejercicio
                          .precioController,

                  pendienteController: 
                      ejercicio
                        .pendienteController,

                  totalController:
                      ejercicio
                          .totalController,

                  mostrarPendiente:
                      ejercicio.lineaTrabajoSeleccionada == 3 ||
                      ejercicio.lineaTrabajoSeleccionada == 4,
                ),

                const SizedBox(
                  height: 20,
                ),

                // ============================================
                // BOTÓN CALCULAR
                // ============================================

                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child:
                      ElevatedButton.icon(
                    icon: const Icon(
                      Icons.calculate_outlined,
                    ),

                    label: Text(
                      'Calcular Precios',
                      style:
                          baseTextStyle.copyWith(
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          primaryBlue,
                      foregroundColor:
                          Colors.white,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          12,
                        ),
                      ),
                    ),

                    onPressed: () =>
                        _calcularEjercicio(
                      ejercicio,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DROPDOWN
  // ============================================================

  Widget _buildDropdown({
    required String label,
    required int? currentValue,
    required List<DropdownMenuItem<int>> items,
    required ValueChanged<int?> onChanged,
    required TextStyle baseStyle,
  }) {
    // Si el valor seleccionado ya no existe
    // dentro de las opciones, evitamos que Flutter
    // lance el error de DropdownButton.
    final bool valorValido =
        currentValue == null ||
        items.any(
          (item) => item.value == currentValue,
        );

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Text(
          label,
          style:
              baseStyle.copyWith(
            fontSize: 11,
            fontWeight:
                FontWeight.w600,
            color: Colors.black87,
          ),
        ),

        const SizedBox(
          height: 8,
        ),

        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 12,
          ),

          decoration:
              BoxDecoration(
            color:
                const Color(0xFFF5F5F5),

            borderRadius:
                BorderRadius.circular(
              8,
            ),
          ),

          child:
              DropdownButtonHideUnderline(
            child:
                DropdownButton<int>(
              value:
                  valorValido
                      ? currentValue
                      : null,

              items: items,

              onChanged:
                  onChanged,

              isExpanded:
                  true,

              icon:
                  const Icon(
                Icons.unfold_more,
                color:
                    Colors.blueGrey,
                size: 20,
              ),

              style:
                  baseStyle.copyWith(
                fontSize: 14,
                color:
                    Colors.black87,
              ),

              hint:
                  Text(
                'Seleccione una opción',
                style:
                    baseStyle.copyWith(
                  color:
                      Colors.black38,
                ),
              ),

              dropdownColor:
                  Colors.white,

              borderRadius:
                  BorderRadius.circular(
                8,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SECTION CARD
  // ============================================================

  Widget _buildSectionCard(
    List<Widget> children,
  ) {
    return Card(
      elevation: 0.5,

      color:
          Colors.white,

      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(
          12,
        ),
      ),

      child:
          Padding(
        padding:
            const EdgeInsets.all(
          16.0,
        ),

        child:
            Column(
          children:
              children,
        ),
      ),
    );
  }

  // ============================================================
  // ESPECIFICACIÓN TÉCNICA
  // ============================================================

  Widget _buildSpecCard({
    required TextStyle baseStyle,
    required String? incluyeTexto,
    required String? descripcionTexto,
    required String? descripcion1, 
    required String? descripcion2, 
    required String? descripcion3,
    required dynamic imagen,
  }) {
    final String? nombreImagen =
        imagen?.toString();

    final bool tieneImagen =
        nombreImagen != null &&
        nombreImagen.trim().isNotEmpty;

    final String urlImagen =
        tieneImagen
            ? 'http://187.188.214.154/'
              'ParametricosApi/imagenes/'
              '$nombreImagen'
            : '';

    return Card(
      color:
          Colors.white,

      clipBehavior:
          Clip.antiAlias,

      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(
          12,
        ),
      ),

      child:
          Column(
        children: [

          Container(
            width:
                double.infinity,

            padding:
                const EdgeInsets.all(
              10,
            ),

            color:
                const Color(0xFFEEEEEE),

            child:
                Text(
              'ESPECIFICACIÓN TÉCNICA',

              textAlign:
                  TextAlign.center,

              style:
                  baseStyle.copyWith(
                fontSize: 12,
                fontWeight:
                    FontWeight.bold,
                color:
                    Colors.blue[900],
              ),
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.all(
              16.0,
            ),

            child:
                Column(
              children: [

                // ==========================================
                // IMAGEN
                // ==========================================

                Stack(
                  alignment:
                      Alignment.bottomRight,

                  children: [

                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(
                        8,
                      ),

                      child:
                          tieneImagen
                              ? Image.network(
                                  urlImagen,

                                  height:
                                      230,

                                  width:
                                      double.infinity,

                                  fit:
                                      BoxFit.contain,

                                  errorBuilder:
                                      (
                                    context,
                                    error,
                                    stackTrace,
                                  ) {
                                    return _buildImageError();
                                  },
                                )
                              : _buildImageError(),
                    ),

                    if (tieneImagen)
                      Container(
                        margin:
                            const EdgeInsets.all(
                          8,
                        ),

                        decoration:
                            BoxDecoration(
                          color:
                              Colors.white.withOpacity(
                            0.9,
                          ),

                          border:
                              Border.all(
                            color:
                                Colors.grey[300]!,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            8,
                          ),
                        ),

                        child:
                            IconButton(
                          icon:
                              const Icon(
                            Icons.zoom_in,
                            color:
                                Colors.black87,
                          ),

                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => VisorImagenScreen(
                                  imageUrl: urlImagen,
                                  descripcion1: descripcion1,
                                  descripcion2: descripcion2,
                                  descripcion3: descripcion3,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),

                const SizedBox(
                  height: 12,
                ),

                // ==========================================
                // INCLUYE
                // ==========================================

                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Expanded(
                      child:
                          RichText(
                        text:
                            TextSpan(
                          style:
                              baseStyle.copyWith(
                            color:
                                Colors.black87,
                            fontSize:
                                13,
                          ),

                          children: [

                            const TextSpan(
                              text:
                                  'Incluye: ',
                              style:
                                  TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            TextSpan(
                              text:
                                  incluyeTexto ??
                                      'No disponible por el momento.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 12,
                ),

                // ==========================================
                // DESCRIPCIÓN
                // ==========================================

                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Expanded(
                      child:
                          RichText(
                        text:
                            TextSpan(
                          style:
                              baseStyle.copyWith(
                            color:
                                Colors.black87,
                            fontSize:
                                13,
                          ),

                          children: [

                            const TextSpan(
                              text:
                                  'Descripción: ',
                              style:
                                  TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            TextSpan(
                              text:
                                  descripcionTexto ??
                                      'No disponible por el momento.',
                            ),
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

  // ============================================================
  // IMAGEN NO DISPONIBLE
  // ============================================================

  Widget _buildImageError() {
    return Container(
      height: 150,
      width: double.infinity,
      color: Colors.grey[200],
      alignment: Alignment.center,

      child: const Icon(
        Icons.broken_image,
        color: Colors.grey,
        size: 40,
      ),
    );
  }

  // ============================================================
  // CARD DE RESULTADOS
  // ============================================================

  Widget _buildResultCard({
    required Color color,
    required TextStyle baseStyle,
    required TextEditingController metrosController,
    required TextEditingController precioController,
    required TextEditingController pendienteController,
    required TextEditingController totalController,
    required bool mostrarPendiente,
  }) {
    return Container(
      decoration:
          BoxDecoration(
        color:
            const Color(0xFF003D71)
                .withOpacity(
          0.03,
        ),

        borderRadius:
            BorderRadius.circular(
          12,
        ),

        border:
            Border(
          left:
              BorderSide(
            color:
                color,
            width:
                6,
          ),
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(
              0.05,
            ),

            blurRadius:
                4,
          ),
        ],
      ),

      padding:
          const EdgeInsets.all(
        16,
      ),

      child:
          Column(
        children: [

          // ==================================================
          // METROS
          // ==================================================

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              Text(
                'METROS A CONSTRUIR',

                style:
                    baseStyle.copyWith(
                  fontSize: 12,
                  fontWeight:
                      FontWeight.w500,
                ),
              ),

              SizedBox(
                width: 140,
                height: 40,

                child:
                    TextField(
                  controller:
                      metrosController,

                  keyboardType:
                      const TextInputType.numberWithOptions(
                    decimal:
                        true,
                  ),

                  textAlign:
                      TextAlign.end,

                  style:
                      baseStyle.copyWith(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Colors.black87,
                  ),

                  decoration:
                      InputDecoration(
                    fillColor:
                        const Color(
                      0xFFF5F5F5,
                    ),

                    filled:
                        true,

                    isDense:
                        false,

                    contentPadding:
                        const EdgeInsets
                            .symmetric(
                      horizontal:
                          10,
                      vertical:
                          8,
                    ),

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        6,
                      ),

                      borderSide:
                          BorderSide.none,
                    ),

                    suffixText:
                        ' MTS',

                    suffixStyle:
                        baseStyle.copyWith(
                      fontSize:
                          13,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 8,
          ),

          // ==================================================
          // PRECIO
          // ==================================================

          Row(
            children: [
              Text(
                'PRECIO POR METRO',
                style: baseStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    precioController.text,
                    textAlign: TextAlign.end,
                    style: baseStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryBlue,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ==================================================
          // PENDIENTE
          // ==================================================

          if (mostrarPendiente) ...[
            const SizedBox(
              height: 8,
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                Text(
                  'PENDIENTE',

                  style:
                      baseStyle.copyWith(
                    fontSize: 12,
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),

                SizedBox(
                  width: 140,
                  height: 40,

                  child:
                      TextField(
                    controller:
                        pendienteController,

                    keyboardType:
                        const TextInputType.numberWithOptions(
                      decimal: true,
                    ),

                    textAlign:
                        TextAlign.end,

                    style:
                        baseStyle.copyWith(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          primaryBlue,
                    ),

                    decoration:
                        InputDecoration(
                      fillColor:
                          const Color(0xFFF5F5F5),

                      filled:
                          true,

                      contentPadding:
                          const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),

                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          6,
                        ),

                        borderSide:
                            BorderSide.none,
                      ),

                      suffixText:
                          ' %',

                      suffixStyle:
                          baseStyle.copyWith(
                        fontSize: 13,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            Colors.black54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],

          const Divider(
            height: 24,
            color:
                Color(0xFF003D71),
          ),

          // ==================================================
          // TOTAL
          // ==================================================

          Row(
            children: [
              Text(
                'TOTAL SIN IVA',
                style: baseStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    totalController.text,
                    textAlign: TextAlign.end,
                    style: baseStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CARD DE GRAN TOTAL
  // ============================================================

  Widget _buildGranTotalCard({
    required Color color,
    required TextStyle baseStyle,
  }) {
    final double granTotal = _obtenerGranTotal();

    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

        border: Border(
          left: BorderSide(
            color: color,
            width: 6,
          ),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      padding: const EdgeInsets.all(18),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            'RESUMEN GENERAL',
            style: baseStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              Text(
                'EJERCICIOS',
                style: baseStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),

              Text(
                '${listaEjercicios.length}',
                style: baseStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              Text(
                'GRAN TOTAL SIN IVA',
                style: baseStyle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              Text(
                '\$ ${granTotal.toStringAsFixed(2)}',
                style: baseStyle.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}

// ============================================================================
// MODELO DE EJERCICIO
// ============================================================================

class EjercicioCalculo {
  final int id;

  bool isExpanded;

  String nombre;

  // ========================================================================
  // ESPECIFICACIÓN
  // ========================================================================

  String? textoIncluye;

  String? textoDescripcion;

  // ========================================================================
  // LÍNEA DE TRABAJO
  // ========================================================================

  List<dynamic> lineasTrabajo = [];

  List<DropdownMenuItem<int>>
      opcionesLineaTrabajo = [];

  int? lineaTrabajoSeleccionada;

  Map<String, dynamic>?
      objetoCompletoLineaTrabajo;

  // ========================================================================
  // TIPO DE MATERIAL
  // ========================================================================

  List<dynamic> tiposMaterial = [];

  List<DropdownMenuItem<int>>
      opcionesTipoMaterial = [];

  int? tipoMaterialSeleccionado;

  Map<String, dynamic>?
      objetoCompletoTipoMaterial;

  // ========================================================================
  // TIPO DE OBRA
  // ========================================================================

  List<dynamic> tiposObra = [];

  List<DropdownMenuItem<int>>
      opcionesTipoObra = [];

  int? tipoObraSeleccionada;

  Map<String, dynamic>?
      objetoCompletoTipoObra;

  // ========================================================================
  // TIPO DE TUBERÍA
  // ========================================================================

  List<dynamic> tiposTuberia = [];

  List<DropdownMenuItem<int>>
      opcionesTipoTuberia = [];

  int? tipoTuberiaSeleccionada;

  Map<String, dynamic>?
      objetoCompletoTipoTuberia;

  // ========================================================================
  // DIÁMETRO
  // ========================================================================

  List<dynamic> diametrosTuberia = [];

  List<DropdownMenuItem<int>>
      opcionesDiametrosTuberia = [];

  int? diametroTuberiaSeleccionado;

  Map<String, dynamic>?
      objetoCompletoDiametroTuberia;

  // ========================================================================
  // EXCAVACIÓN
  // ========================================================================

  List<dynamic> tiposExcavacion = [];

  List<DropdownMenuItem<int>>
      opcionesTipoExcavacion = [];

  int? tipoExcavacionSeleccionada;

  Map<String, dynamic>?
      objetoCompletoTipoExcavacion;

  // ========================================================================
  // RELACIÓN DE PRECIO
  // ========================================================================

  List<dynamic> relacionPrecio = [];

  // ========================================================================
  // CONTROLADORES
  // ========================================================================

  final TextEditingController metrosController =
      TextEditingController(
    text: '0',
  );

  final TextEditingController precioController =
      TextEditingController(
    text: '\$ 0.00',
  );

  // PORCENTAJE DE PENDIENTE 
  final TextEditingController pendienteController = 
      TextEditingController( 
    text: '0', 
  );

  final TextEditingController totalController =
      TextEditingController(
    text: '\$ 0.00',
  );

  // ========================================================================
  // CONSTRUCTOR
  // ========================================================================

  EjercicioCalculo({
    required this.id,
    required this.nombre,
    this.isExpanded = true,
  });

  // ========================================================================
  // DISPOSE
  // ========================================================================

  void dispose() {
    metrosController.dispose();
    precioController.dispose();
    pendienteController.dispose();
    totalController.dispose();
  }
}


// ============================================================================
// MODELO DE EJERCICIO
// ============================================================================

class VisorImagenScreen extends StatefulWidget {
  final String imageUrl;
  final String? descripcion1;
  final String? descripcion2;
  final String? descripcion3;

  const VisorImagenScreen({
    super.key,
    required this.imageUrl,
    this.descripcion1,
    this.descripcion2,
    this.descripcion3,
  });

  @override
  State<VisorImagenScreen> createState() =>
      _VisorImagenScreenState();
}

class _VisorImagenScreenState extends State<VisorImagenScreen> {
  final TransformationController _transformationController =
      TransformationController();

  TapDownDetails? _doubleTapDetails;

  // ============================================================================
  // OBTENER DESCRIPCIONES
  // ============================================================================

  List<Map<String, String>> _obtenerDescripciones() {
    final List<Map<String, String>> descripciones = [];

    void agregarDescripcion(
      int numero,
      String? descripcion,
    ) {
      if (descripcion == null) return;

      final texto = descripcion.trim();

      if (texto.isEmpty ||
          texto.toLowerCase() == 'null') {
        return;
      }

      descripciones.add({
        'titulo': 'Descripción $numero',
        'texto': texto,
      });
    }

    agregarDescripcion(
      1,
      widget.descripcion1,
    );

    agregarDescripcion(
      2,
      widget.descripcion2,
    );

    agregarDescripcion(
      3,
      widget.descripcion3,
    );

    return descripciones;
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    final Matrix4 currentMatrix =
        _transformationController.value;

    // Si ya existe zoom, regresar al tamaño original
    if (currentMatrix != Matrix4.identity()) {
      _transformationController.value =
          Matrix4.identity();
      return;
    }

    final Offset position =
        _doubleTapDetails?.localPosition ??
        Offset.zero;

    const double zoom = 2.5;

    _transformationController.value =
        Matrix4.identity()
          ..translate(
            -position.dx * (zoom - 1),
            -position.dy * (zoom - 1),
          )
          ..scale(zoom);
  }

  @override
  Widget build(BuildContext context) {

    final descripciones = _obtenerDescripciones();

    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [

          // ====================================================
          // IMAGEN
          // ====================================================
          Positioned.fill(
            child: GestureDetector(
              onDoubleTapDown: _handleDoubleTapDown,
              onDoubleTap: _handleDoubleTap,

              child: InteractiveViewer(
                transformationController:
                    _transformationController,

                minScale: 1.0,
                maxScale: 5.0,

                panEnabled: true,
                scaleEnabled: true,

                boundaryMargin:
                    const EdgeInsets.all(80),

                child: Center(
                  child: Image.network(
                    widget.imageUrl,

                    fit: BoxFit.contain,

                    loadingBuilder: (
                      context,
                      child,
                      loadingProgress,
                    ) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    },

                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.broken_image_outlined,
                              color: Colors.white70,
                              size: 48,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'No fue posible cargar la imagen',
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          // ====================================================
          // BOTÓN CERRAR
          // ====================================================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },

                  style: IconButton.styleFrom(
                    backgroundColor:
                        Colors.black.withOpacity(0.45),
                    foregroundColor: Colors.white,
                  ),

                  icon: const Icon(
                    Icons.close,
                    size: 26,
                  ),
                ),
              ),
            ),
          ),

          // ====================================================
          // PIE DE FOTO
          // ====================================================
          if (descripciones.isNotEmpty)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,

            child: SafeArea(
              top: false,

              child: Container(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  30,
                  20,
                  18,
                ),

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.85),
                    ],
                  ),
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    for (
                      int i = 0;
                      i < descripciones.length;
                      i++
                    ) ...[
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.4,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  '${descripciones[i]['titulo']}: ',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            TextSpan(
                              text:
                                  descripciones[i]['texto'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (i < descripciones.length - 1)
                        const SizedBox(height: 8),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
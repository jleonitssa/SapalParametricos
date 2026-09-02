import 'package:dio/dio.dart';

class ParametricosApi {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl:
        //'https://localhost:7081/',
        //'https://shakeable-unlabeled-na.ngrok-free.dev/',
        'http://187.188.214.154/ParametricosApi/',
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    ),
  );

  Future<Map<String, dynamic>> inicioDeSesion({
    String? login,
    String? pass,
  }) async {
    try {
      final response = await _dio.post(
        "/usuario/UsuarioValidarSesion",
        data: {
          "login": login, 
          "pass": pass
        },
      );

      return response.data;
      
    } catch (e) {
      return {"error": "Error: $e"};
    }
  }

  Future<List<dynamic>> obtenerExcavacion() async {
    try {
      final response = await _dio.post(
        "/excavacion/ExcavacionSelect",
        data: {
          "idExcavacion": 0,
          "nombre": "",
          "initRow": 1,
          "endRow": 1000,
          "sortColumn": "idExcavacion",
          "sortDir": "ASC"
        }
      );

      final data = response.data;

      if (data["codigo"] == 1) {
        return data["excavaciones"];
      } else {
        return [];
      }
      
    } catch (e) {
      return [];
    }
  }

  Future<List<dynamic>> obtenerLineaTrabajo() async {
    try {
      final response = await _dio.post(
        "/lineatrabajo/LineaTrabajoSelect",
        data: {
          "idLineaTrabajo": 0,
          "nombre": "",
          "idClaveTrabajo": 0,
          "initRow": 1,
          "endRow": 1000,
          "sortColumn": "idLineaTrabajo",
          "sortDir": "ASC"
        }
      );

      final data = response.data;

      if (data["codigo"] == 1) {
        return data["lineasTrabajo"];
      } else {
        return [];
      }
      
    } catch (e) {
      return [];
    }
  }

  Future<List<dynamic>> obtenerRelacionFinalPrecio({
    int? idRelacionDiametro,
    int? idTipoMaterial,
    int? idExcavacion,
  }) async {
    try {
      final response = await _dio.post(
        "/relacionfinalprecio/RelacionFinalPrecioSelect",
        data: {
          "idRelacion": 0,
          "idRelacionDiametro": idRelacionDiametro,
          "idTipoMaterial": idTipoMaterial,
          "idExcavacion": idExcavacion,
          "initRow": 1,
          "endRow": 1000,
          "sortColumn": "idRelacion",
          "sortDir": "ASC"
        },
      );

      final data = response.data;

      if (data["codigo"] == 1) {
        return data["relacionesFinalPrecio"];
      } else {
        return [];
      }
      
    } catch (e) {
      return [];
    }
  }

  Future<List<dynamic>> obtenerRelacionLineaObraTuberia({
    int? idLineaTrabajo,
    int? idTipoObra,
  }) async {
    try {
      final response = await _dio.post(
        "/relacionlineaobratuberia/RelacionLineaObraTuberiaSelect",
        data: {
          "idRelacion": 0,
          "idLineaTrabajo": idLineaTrabajo,
          "idTipoObra": idTipoObra,
          "idTuberia": 0,
          "initRow": 1,
          "endRow": 1000,
          "sortColumn": "idRelacion",
          "sortDir": "ASC"
        },
      );

      final data = response.data;

      if (data["codigo"] == 1) {
        return data["relacionesLineaObraTuberia"];
      } else {
        return [];
      }
      
    } catch (e) {
      return [];
    }
  }

  Future<List<dynamic>> obtenerRelacionObraDiametro({
    int? idRelacionObra,
  }) async {
    try {
      final response = await _dio.post(
        "/relacionobradiametro/RelacionObraDiametroSelect",
        data: {
          "idRelacion": 0,
          "idRelacionObra": idRelacionObra,
          "idDiametro": 0,
          "initRow": 1,
          "endRow": 1000,
          "sortColumn": "idRelacion",
          "sortDir": "ASC"
        },
      );

      final data = response.data;

      if (data["codigo"] == 1) {
        return data["relacionesObraDiametro"];
      } else {
        return [];
      }
      
    } catch (e) {
      return [];
    }
  }

  Future<List<dynamic>> obtenerTipoMaterial() async {
    try {
      final response = await _dio.post(
        "/tipomaterial/TipoMaterialSelect",
        data: {
          "idTipoMaterial": 0,
          "nombre": "",
          "initRow": 1,
          "endRow": 1000,
          "sortColumn": "idTipoMaterial",
          "sortDir": "ASC"
        }
      );

      final data = response.data;

      if (data["codigo"] == 1) {
        return data["tiposMaterial"];
      } else {
        return [];
      }
      
    } catch (e) {
      return [];
    }
  }

  Future<List<dynamic>> obtenerTipoObra({
    int? idClaveTrabajo,
  }) async {
    try {
      final response = await _dio.post(
        "/tipoobra/TipoObraSelect",
        data: {
          "idTipoObra": 0,
          "idClaveTrabajo": idClaveTrabajo,
          "nombre": "",
          "initRow": 1,
          "endRow": 1000,
          "sortColumn": "idTipoObra",
          "sortDir": "ASC"
        },
      );

      final data = response.data;

      if (data["codigo"] == 1) {
        return data["tiposObra"];
      } else {
        return [];
      }
      
    } catch (e) {
      return [];
    }
  }
}


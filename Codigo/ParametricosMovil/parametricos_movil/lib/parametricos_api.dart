import 'package:dio/dio.dart';

class ParametricosApi {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl:
          'https://localhost:7081/',
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    ),
  );

  Future<List<dynamic>> obtenerExcavacion() async {
    try {
      final response = await _dio.post(
        "/parametricos/ExcavacionSelect",
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
        "/parametricos/LineaTrabajoSelect",
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
        "/parametricos/RelacionFinalPrecioSelect",
        data: {
          "idRelacionDiametro": idRelacionDiametro,
          "idTipoMaterial": idTipoMaterial,
          "idExcavacion": idExcavacion,
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
        "/parametricos/RelacionLineaObraTuberiaSelect",
        data: {
          "idLineaTrabajo": idLineaTrabajo,
          "idTipoObra": idTipoObra,
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
        "/parametricos/RelacionObraDiametroSelect",
        data: {
          "idRelacionObra": idRelacionObra,
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
        "/parametricos/TipoMaterialSelect",
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
        "/parametricos/TipoObraSelect",
        data: {
          "idClaveTrabajo": idClaveTrabajo,
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


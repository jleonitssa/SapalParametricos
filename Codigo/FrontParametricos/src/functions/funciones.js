import { Dialog } from "quasar";
import { api } from "boot/axios";
import * as XLSX from "xlsx";

export function mostrarMensaje(titulo, mensaje, tipo) {
  var icono =
    '<span class="material-symbols-outlined">' +
    (tipo == "ok"
      ? "done_outline"
      : tipo == "err"
      ? "cancel"
      : tipo == "adv"
      ? "warning"
      : "") +
    "</span>";

  var iconocompleto =
    tipo == ""
      ? ""
      : '<span style="background-color: #' +
        (tipo == "ok" ? "97ff9e" : tipo == "err" ? "ff8888" : "f3f338") +
        ';">' +
        icono +
        "</span>&nbsp&nbsp;";

  Dialog.create({
    title: titulo,
    message: iconocompleto + mensaje,
    html: true,
    ok: "Aceptar",
    cancel: false,
    persistent: false,
  });
}

export function guardarLogSistema(
  idUsuario,
  pantalla,
  accion,
  descripcion,
  tipo
) {
  const req = {
    idUsuario: idUsuario,
    pantalla: pantalla,
    accion: accion,
    descripcion: descripcion,
    tipo: tipo,
  };

  api
    .post("/logSistema/LogSistemaInsert", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        //console.log(req);
        //console.log("Log: ok");
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    })
    .finally(() => {});
}

export function formatoFechaBD(Fecha) {
  if (Fecha.getFullYear() == 1969) return "";
  else {
    return darFormatoFechaBD(Fecha, 0);
  }
}

export function formatoFechaBDMasDias(Fecha, Dias) {
  if (Fecha.getFullYear() == 1969) return "";
  else {
    return darFormatoFechaBD(Fecha, Dias);
  }
}

function darFormatoFechaBD(Fecha, Dias) {
  Fecha.setDate(Fecha.getDate() + Dias);

  var dia = Fecha.getDate();
  var mes = Fecha.getMonth() + 1;
  var anio = Fecha.getFullYear();

  return (
    anio.toString() +
    "-" +
    (mes < 10 ? "0" : "") +
    mes.toString() +
    "-" +
    (dia < 10 ? "0" : "") +
    dia.toString()
  );
}

export function formatoFecha(Fecha) {
  //console.log(Fecha);
  if (Fecha.getFullYear() == 1969) return "";
  else {
    return darFormatoFecha(Fecha, 0);
  }
}

export function formatoFechaMasDias(Fecha, Dias) {
  if (Fecha.getFullYear() == 1969) return "";
  else {
    //console.log(Fecha);
    return darFormatoFecha(Fecha, Dias);
  }
}

function darFormatoFecha(Fecha, Dias) {
  Fecha.setDate(Fecha.getDate() + Dias);

  var dia = Fecha.getDate();
  var mes = Fecha.getMonth() + 1;
  var anio = Fecha.getFullYear();

  return (
    (dia < 10 ? "0" : "") +
    dia.toString() +
    "/" +
    (mes < 10 ? "0" : "") +
    mes.toString() +
    "/" +
    anio.toString()
  );
}

export function formatoHora(Fecha, ConSegundos) {
  if (Fecha.getFullYear() == 1969) return "";
  else {
    return darFormatoHora(Fecha, ConSegundos);
  }
}

function darFormatoHora(Fecha, ConSegundos) {
  var hora = Fecha.getHours();
  var min = Fecha.getMinutes();
  var sec = Fecha.getSeconds();

  var ret =
    (hora < 10 ? "0" : "") +
    hora.toString() +
    ":" +
    (min < 10 ? "0" : "") +
    min.toString() +
    (ConSegundos ? ":" + (sec < 10 ? "0" : "") + sec.toString() : "");

  //console.log(ret);

  return ret;
}

export function formatoFechaHora(Fecha, ConSegundos) {
  //console.log(Fecha);
  if (Fecha == null) return "";
  else {
    if (Fecha.getFullYear() == 1969) return "";
    else {
      return (
        darFormatoFecha(Fecha, 0) + " " + darFormatoHora(Fecha, ConSegundos)
      );
    }
  }
}

export function formatoFechaHoraFirma(Fecha) {
  //console.log(Fecha);
  if (Fecha == null) return "";
  else {
    if (Fecha.getFullYear() == 1969) return "";
    else {
      var dia = Fecha.getDate();
      var mes = Fecha.getMonth() + 1;
      var anio = Fecha.getFullYear();

      var cadena =
        anio.toString() +
        (mes < 10 ? "0" : "") +
        mes.toString() +
        (dia < 10 ? "0" : "") +
        dia.toString();

      var hora = Fecha.getHours();
      var min = Fecha.getMinutes();
      var sec = Fecha.getSeconds();

      cadena +=
        (hora < 10 ? "0" : "") +
        hora.toString() +
        (min < 10 ? "0" : "") +
        min.toString() +
        (sec < 10 ? "0" : "") +
        sec.toString();

      return cadena;
    }
  }
}

export function formatoNumeroEntero(Numero) {
  return new Intl.NumberFormat("es-MX").format(Numero);
}

export function formatoMoneda(Numero) {
  return new Intl.NumberFormat("es-MX", {
    style: "currency",
    currency: "MXN",
  }).format(Numero);
}

export function revisarPermisos(idGrupo, pantalla, ...ObjyAccs) {
  const req = {
    idGrupo: idGrupo,
    pantalla: pantalla,
    accion: null,
  };

  api
    .post("/accion/AccionXPantallaXGrupoSelect", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        //console.log(req);
        //console.log(resp);
        for (let i = 0; i < ObjyAccs.length; i += 2) {
          ObjyAccs[i].value =
            resp.acciones.filter((obj) => {
              return obj.accion == ObjyAccs[i + 1];
            }).length > 0;
        }
        //console.log(ObjyAccs);
      } else {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    })
    .finally(() => {});
}

export function obtenerParametroURL(Parametro, Default) {
  var params = new URLSearchParams(window.location.href.split("?")[1]);
  return params.get(Parametro) ?? Default;
}

export function rellenaCadena(Cadena, Tamano, Relleno, Derecha) {
  while (Cadena.length < Tamano) {
    if (Derecha) Cadena += Relleno;
    else Cadena = Relleno + Cadena;
  }
  return Cadena;
}

export function isValidEmail(email) {
  const regex = /^[A-Za-z0-9+_.-]+@(.+)$/;
  if (email.length > 0) return regex.test(email);
  else return true;
}

export async function obtenerKilometrajeGPS(noEconomico) {
  var respuesta = { kilometraje: 0, mensaje: "" };

  var nameNumber =
    noEconomico.indexOf("-") >= 0
      ? noEconomico.substring(noEconomico.indexOf("-") + 1, 100)
      : noEconomico;

  const req = {
    imei: "",
    type: "s",
    nameNumber: nameNumber,
  };

  //console.log(req);

  await api
    .post("/util/ConsultarGPS", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo == 1) {
        respuesta.kilometraje = resp.unidadesGps[0].odometro;
        respuesta.mensaje = "ok";
      } else {
        respuesta.kilometraje = 0;
        respuesta.mensaje = resp.mensaje;
      }
    })
    .catch((error) => {
      respuesta.kilometraje = 0;
      respuesta.mensaje = error;
    });

  return respuesta;
}

export function enviarNotificacion(idCita, tipo) {
  enviarNotificacionComentario(idCita, tipo, "");
}

export function enviarNotificacionComentario(idCita, tipo, comentario) {
  const req = {
    idCita: idCita,
    tipo: tipo,
    comentario: comentario,
  };
  //console.log(req);
  api
    .post("/util/EnviarNotificacion", req, {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    })
    .then((response) => {
      var resp = response.data;

      if (resp.codigo != 1) {
        console.log(resp.mensaje);
      }
    })
    .catch((error) => {
      console.log(error);
    })
    .finally(() => {});
}

export function obtenerIds(Arreglo, CampoId) {
  var res = "";
  Arreglo.forEach((element) => {
    res += "," + element[CampoId];
  });
  return res.length > 1 ? res.substring(1) : "-1";
}

export async function exportarAExcel(
  Registros,
  Columnas,
  NombreHoja,
  NombreArchivo
) {
  // Transformar los datos filtrados para que coincidan con los nombres de columnas definidos en `columns`
  const transformedData = Registros.map((row) => {
    const transformedRow = {};

    Columnas.forEach((column) => {
      const fieldValue = row[column.field];
      // Si hay una función de formato, aplícalo, de lo contrario, asigna el valor directamente
      transformedRow[column.label] = column.format
        ? column.format(fieldValue)
        : fieldValue;
    });

    return transformedRow;
  });

  // Crear una hoja de trabajo (worksheet) con los datos transformados
  const worksheet = XLSX.utils.json_to_sheet(transformedData);

  // Crear un libro de trabajo (workbook) y agregar la hoja de trabajo
  const workbook = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(workbook, worksheet, NombreHoja);

  // Generar el archivo Excel
  XLSX.writeFile(workbook, NombreArchivo);
}

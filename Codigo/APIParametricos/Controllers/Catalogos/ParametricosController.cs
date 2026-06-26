using APIParametricos.Code;
using APIParametricos.Dtos.Respuesta;
using APIParametricos.Dtos.Solicitud.Catalogos;
using DatosParametricos.Operaciones;
using Microsoft.AspNetCore.Mvc;

namespace APIParametricos.Controllers.Catalogos
{
    [ApiController]
    [Route("parametricos")]
    public class ParametricosController : ControllerBase
    {
        private readonly DatosParametricos.ApplicationDbContext context;

        public ParametricosController(DatosParametricos.ApplicationDbContext context)
        {
            this.context = context;
        }

        [HttpPost]
        [Route("ExcavacionSelect")]
        public RespuestaExcavacion ExcavacionSelect()
        {
            RespuestaExcavacion Resp;

            try
            {
                List<DatosParametricos.Entidades.Excavacion> res = DatosParametricos.Operaciones.OperacionesParametricos.ExcavacionSelect(0, "", 1, 100, "IDExcavacion", "ASC", context);

                Resp = new RespuestaExcavacion
                {
                    Codigo = 1,
                    Resultado = 1,
                    Mensaje = "",
                    Descripcion = "",
                    Excavaciones = res
                };
            }
            catch (Exception ex)
            {
                Resp = new RespuestaExcavacion
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace,
                    Excavaciones = new List<DatosParametricos.Entidades.Excavacion>()
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("LineaTrabajoSelect")]
        public RespuestaLineaTrabajo LineaTrabajoSelect()
        {
            RespuestaLineaTrabajo Resp;

            try
            {
                List<DatosParametricos.Entidades.LineaTrabajo> res = DatosParametricos.Operaciones.OperacionesParametricos.LineaTrabajoSelect(0, "", 0, 1, 100, "IDLineaTrabajo", "ASC", context);

                Resp = new RespuestaLineaTrabajo
                {
                    Codigo = 1,
                    Resultado = 1,
                    Mensaje = "",
                    Descripcion = "",
                    LineasTrabajo = res
                };
            }
            catch (Exception ex)
            {
                Resp = new RespuestaLineaTrabajo
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace,
                    LineasTrabajo = new List<DatosParametricos.Entidades.LineaTrabajo>()
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("RelacionFinalPrecioSelect")]
        public RespuestaRelacionFinalPrecio RelacionFinalPrecioSelect(reqRelacionFinalPrecioSelect sol)
        {
            RespuestaRelacionFinalPrecio Resp;

            try
            {
                List<DatosParametricos.Entidades.RelacionFinalPrecio> res = DatosParametricos.Operaciones.OperacionesParametricos.RelacionFinalPrecioSelect(0, sol.IDRelacionDiametro, sol.IDTipoMaterial, sol.IDExcavacion, 1, 100, "IDRelacion", "ASC", context);

                Resp = new RespuestaRelacionFinalPrecio
                {
                    Codigo = 1,
                    Resultado = 1,
                    Mensaje = "",
                    Descripcion = "",
                    RelacionesFinalPrecio = res
                };
            }
            catch (Exception ex)
            {
                Resp = new RespuestaRelacionFinalPrecio
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace,
                    RelacionesFinalPrecio = new List<DatosParametricos.Entidades.RelacionFinalPrecio>()
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("RelacionLineaObraTuberiaSelect")]
        public RespuestaRelacionLineaObraTuberia RelacionLineaObraTuberiaSelect(reqRelacionLineaObraTuberiaSelect sol)
        {
            RespuestaRelacionLineaObraTuberia Resp;

            try
            {
                List<DatosParametricos.Entidades.RelacionLineaObraTuberia> res = DatosParametricos.Operaciones.OperacionesParametricos.RelacionLineaObraTuberiaSelect(0, sol.IDLineaTrabajo, sol.IDTipoObra, 0, 1, 100, "IDRelacion", "ASC", context);

                Resp = new RespuestaRelacionLineaObraTuberia
                {
                    Codigo = 1,
                    Resultado = 1,
                    Mensaje = "",
                    Descripcion = "",
                    RelacionesLineaObraTuberia = res
                };
            }
            catch (Exception ex)
            {
                Resp = new RespuestaRelacionLineaObraTuberia
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace,
                    RelacionesLineaObraTuberia = new List<DatosParametricos.Entidades.RelacionLineaObraTuberia>()
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("RelacionObraDiametroSelect")]
        public RespuestaRelacionObraDiametro RelacionObraDiametroSelect(reqRelacionObraDiametroSelect sol)
        {
            RespuestaRelacionObraDiametro Resp;

            try
            {
                List<DatosParametricos.Entidades.RelacionObraDiametro> res = DatosParametricos.Operaciones.OperacionesParametricos.RelacionObraDiametroSelect(0, sol.IDRelacionObra, 0, 1, 100, "IDRelacion", "ASC", context);

                Resp = new RespuestaRelacionObraDiametro
                {
                    Codigo = 1,
                    Resultado = 1,
                    Mensaje = "",
                    Descripcion = "",
                    RelacionesObraDiametro = res
                };
            }
            catch (Exception ex)
            {
                Resp = new RespuestaRelacionObraDiametro
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace,
                    RelacionesObraDiametro = new List<DatosParametricos.Entidades.RelacionObraDiametro>()
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("TipoMaterialSelect")]
        public RespuestaTipoMaterial TipoMaterialSelect()
        {
            RespuestaTipoMaterial Resp;

            try
            {
                List<DatosParametricos.Entidades.TipoMaterial> res = DatosParametricos.Operaciones.OperacionesParametricos.TipoMaterialSelect(0, "", 1, 100, "IDTipoMaterial", "ASC", context);

                Resp = new RespuestaTipoMaterial
                {
                    Codigo = 1,
                    Resultado = 1,
                    Mensaje = "",
                    Descripcion = "",
                    TiposMaterial = res
                };
            }
            catch (Exception ex)
            {
                Resp = new RespuestaTipoMaterial
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace,
                    TiposMaterial = new List<DatosParametricos.Entidades.TipoMaterial>()
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("TipoObraSelect")]
        public RespuestaTipoObra TipoObraSelect(reqTipoObraSelect sol)
        {
            RespuestaTipoObra Resp;

            try
            {
                List<DatosParametricos.Entidades.TipoObra> res = DatosParametricos.Operaciones.OperacionesParametricos.TipoObraSelect(0, sol.IDClaveTrabajo, "", 1, 100, "IDTipoObra", "ASC", context);

                Resp = new RespuestaTipoObra
                {
                    Codigo = 1,
                    Resultado = 1,
                    Mensaje = "",
                    Descripcion = "",
                    TiposObra = res
                };
            }
            catch (Exception ex)
            {
                Resp = new RespuestaTipoObra
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace,
                    TiposObra = new List<DatosParametricos.Entidades.TipoObra>()
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("ActualizarParametricos")]
        public IActionResult ActualizarParametricos(IFormFile file)
        {
            string archivoSubido = new UploadHandler().Upload(file);

            RespuestaActualizacion Res = new RespuestaActualizacion() { errores = new List<MensajeError>() };

            var resXls = Funciones.LeerExcel(Path.Combine(Directory.GetCurrentDirectory(), "Archivos", archivoSubido));

            if (resXls.Count == 0)
            {
                Res.resultado = "ERROR";
                Res.errores.Add(new MensajeError { error = "El archivo no contiene datos" });
            }
            else
            {
                int Fila = 1;

                foreach (var linea in resXls)
                {
                    try
                    {
                        bool hayError = false;

                        string Linea = linea.Count > 1 ? (linea[1] ?? "") : "";
                        string Obra = linea.Count > 2 ? (linea[2] ?? "") : "";
                        string Material = linea.Count > 3 ? (linea[3] ?? "") : "";
                        string Tuberia = linea.Count > 4 ? (linea[4] ?? "") : "";
                        string Diametro = linea.Count > 5 ? (linea[5] ?? "") : "";
                        string Excavacion = linea.Count > 6 ? (linea[6] ?? "") : "";
                        string Precio = linea.Count > 7 ? (linea[7] ?? "") : "";

                        decimal precio;

                        if (Linea == "")
                        {
                            Res.errores.Add(new MensajeError { error = $"La línea de trabajo de la fila {Fila} está vacía" });
                            hayError = true;
                        }
                        if (Obra == "")
                        {
                            Res.errores.Add(new MensajeError { error = $"El tipo de obra de la fila {Fila} está vacío" });
                            hayError = true;
                        }
                        if (Material == "")
                        {
                            Res.errores.Add(new MensajeError { error = $"El tipo de material de la fila {Fila} está vacío" });
                            hayError = true;
                        }
                        if (Tuberia == "")
                        {
                            Res.errores.Add(new MensajeError { error = $"El tipo de tubería de la fila {Fila} está vacío" });
                            hayError = true;
                        }
                        if (Diametro == "")
                        {
                            Res.errores.Add(new MensajeError { error = $"El diámetro de tubería de la fila {Fila} está vacío" });
                            hayError = true;
                        }
                        if (Excavacion == "")
                        {
                            Res.errores.Add(new MensajeError { error = $"El tipo de excavación de la fila {Fila} está vacío" });
                            hayError = true;
                        }
                        if (!decimal.TryParse(Precio, out precio))
                        {
                            Res.errores.Add(new MensajeError { error = $"El precio de la fila {Fila} no es válido" });
                            hayError = true;
                        }

                        if (!hayError)
                            OperacionesParametricos.RelacionFinalPrecioImportar(Linea, Obra, Material, Tuberia, Diametro, Excavacion, precio, context);
                    }
                    catch (Exception ex)
                    {
                        Res.errores.Add(new MensajeError { error = $"Error en la fila {Fila}: {ex.Message}" });
                    }

                    Fila++;
                }

                if (Res.errores.Count == 0)
                    Res.resultado = "OK";
                else
                    Res.resultado = "ERROR";
            }

            return Ok(Res);
        }
    }
}
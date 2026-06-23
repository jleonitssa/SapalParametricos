using APIParametricos.Dtos.Respuesta;
using APIParametricos.Dtos.Solicitud.Catalogos;
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
    }
}
using APIParametricos.Code;
using APIParametricos.Dtos.Respuesta;
using APIParametricos.Dtos.Solicitud.Catalogos;
using DatosParametricos.Operaciones;
using Microsoft.AspNetCore.Mvc;

namespace APIParametricos.Controllers.Catalogos
{
    [ApiController]
    [Route("relacionlineaobratuberia")]
    public class RelacionLineaObraTuberiaController : ControllerBase
    {
        private readonly DatosParametricos.ApplicationDbContext context;

        public RelacionLineaObraTuberiaController(DatosParametricos.ApplicationDbContext context)
        {
            this.context = context;
        }

        [HttpPost]
        [Route("RelacionLineaObraTuberiaCount")]
        public Respuesta RelacionLineaObraTuberiaCount(reqRelacionLineaObraTuberiaCount sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesRelacionLineaObraTuberia.RelacionLineaObraTuberiaCount(sol.IDRelacion, sol.IDLineaTrabajo, sol.IDTipoObra, sol.IDTuberia, context);

                Resp = new Respuesta
                {
                    Codigo = 1,
                    Resultado = res,
                    Mensaje = "",
                    Descripcion = ""
                };
            }
            catch (Exception ex)
            {
                Resp = new Respuesta
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("RelacionLineaObraTuberiaDelete")]
        public Respuesta RelacionLineaObraTuberiaDelete(reqRelacionLineaObraTuberiaDelete sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesRelacionLineaObraTuberia.RelacionLineaObraTuberiaDelete(sol.IDRelacion, context);

                Resp = new Respuesta
                {
                    Codigo = 1,
                    Resultado = res,
                    Mensaje = "",
                    Descripcion = ""
                };
            }
            catch (Exception ex)
            {
                Resp = new Respuesta
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("RelacionLineaObraTuberiaInsert")]
        public Respuesta RelacionLineaObraTuberiaInsert(reqRelacionLineaObraTuberiaInsert sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesRelacionLineaObraTuberia.RelacionLineaObraTuberiaInsert(sol.IDLineaTrabajo, sol.IDTipoObra, sol.IDTuberia, context);

                Resp = new Respuesta
                {
                    Codigo = 1,
                    Resultado = res,
                    Mensaje = "",
                    Descripcion = ""
                };
            }
            catch (Exception ex)
            {
                Resp = new Respuesta
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace
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
                List<DatosParametricos.Entidades.RelacionLineaObraTuberia> res = DatosParametricos.Operaciones.OperacionesRelacionLineaObraTuberia.RelacionLineaObraTuberiaSelect(sol.IDRelacion, sol.IDLineaTrabajo, sol.IDTipoObra, sol.IDTuberia, sol.InitRow, sol.EndRow, sol.SortColumn, sol.SortDir, context);

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
        [Route("RelacionLineaObraTuberiaUpdate")]
        public Respuesta RelacionLineaObraTuberiaUpdate(reqRelacionLineaObraTuberiaUpdate sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesRelacionLineaObraTuberia.RelacionLineaObraTuberiaUpdate(sol.IDRelacion, sol.IDLineaTrabajo, sol.IDTipoObra, sol.IDTuberia, context);

                Resp = new Respuesta
                {
                    Codigo = 1,
                    Resultado = res,
                    Mensaje = "",
                    Descripcion = ""
                };
            }
            catch (Exception ex)
            {
                Resp = new Respuesta
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace
                };
            }

            return Resp;
        }
    }
}
using APIParametricos.Code;
using APIParametricos.Dtos.Respuesta;
using APIParametricos.Dtos.Solicitud.Catalogos;
using DatosParametricos.Operaciones;
using Microsoft.AspNetCore.Mvc;

namespace APIParametricos.Controllers.Catalogos
{
    [ApiController]
    [Route("lineatrabajo")]
    public class LineaTrabajoController : ControllerBase
    {
        private readonly DatosParametricos.ApplicationDbContext context;

        public LineaTrabajoController(DatosParametricos.ApplicationDbContext context)
        {
            this.context = context;
        }

        [HttpPost]
        [Route("LineaTrabajoCount")]
        public Respuesta LineaTrabajoCount(reqLineaTrabajoCount sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesLineaTrabajo.LineaTrabajoCount(sol.IDLineaTrabajo, sol.Nombre, sol.IDClaveTrabajo, context);

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
        [Route("LineaTrabajoDelete")]
        public Respuesta LineaTrabajoDelete(reqLineaTrabajoDelete sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesLineaTrabajo.LineaTrabajoDelete(sol.IDLineaTrabajo, context);

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
        [Route("LineaTrabajoInsert")]
        public Respuesta LineaTrabajoInsert(reqLineaTrabajoInsert sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesLineaTrabajo.LineaTrabajoInsert(sol.Nombre, sol.IDClaveTrabajo, context);

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
        [Route("LineaTrabajoSelect")]
        public RespuestaLineaTrabajo LineaTrabajoSelect(reqLineaTrabajoSelect sol)
        {
            RespuestaLineaTrabajo Resp;

            try
            {
                List<DatosParametricos.Entidades.LineaTrabajo> res = DatosParametricos.Operaciones.OperacionesLineaTrabajo.LineaTrabajoSelect(sol.IDLineaTrabajo, sol.Nombre, sol.IDClaveTrabajo, sol.InitRow, sol.EndRow, sol.SortColumn, sol.SortDir, context);

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
        [Route("LineaTrabajoUpdate")]
        public Respuesta LineaTrabajoUpdate(reqLineaTrabajoUpdate sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesLineaTrabajo.LineaTrabajoUpdate(sol.IDLineaTrabajo, sol.Nombre, sol.IDClaveTrabajo, context);

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
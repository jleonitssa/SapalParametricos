using APIParametricos.Dtos.Respuesta;
using APIParametricos.Dtos.Solicitud.Configuracion;
using Microsoft.AspNetCore.Mvc;

namespace APIParametricos.Controllers.Configuracion
{
    [ApiController]
    [Route("logSistema")]
    public class LogSistemaController : Controller
    {
        private readonly DatosParametricos.ApplicationDbContext context;

        public LogSistemaController(DatosParametricos.ApplicationDbContext context)
        {
            this.context = context;
        }

        [HttpPost]
        [Route("LogSistemaCount")]
        public Respuesta LogSistemaCount(reqLogSistemaCount sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesLogSistema.LogSistemaCount(sol.IDLogSistema, sol.Tipo, sol.IDPantalla, sol.FechaInicial, sol.FechaFinal, sol.Descripcion, sol.Usuario, sol.IP, sol.Accion, sol.IDUsuario, sol.IDGrupo, context);

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
        [Route("LogSistemaInsert")]
        public Respuesta LogSistemaInsert(reqLogSistemaInsert sol)
        {
            Respuesta Resp;

            try
            {
                string IP = Request.HttpContext.Connection.RemoteIpAddress?.ToString();

                int res = DatosParametricos.Operaciones.OperacionesLogSistema.LogSistemaInsert(sol.IDUsuario, sol.Pantalla, sol.Accion, sol.Descripcion, sol.Tipo, IP, context);

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
        [Route("LogSistemaSelect")]
        public RespuestaLogSistema LogSistemaSelect(reqLogSistemaSelect sol)
        {
            RespuestaLogSistema Resp;

            try
            {
                List<DatosParametricos.Entidades.LogSistema> res = DatosParametricos.Operaciones.OperacionesLogSistema.LogSistemaSelect(sol.IDLogSistema, sol.Tipo, sol.IDPantalla, sol.FechaInicial, sol.FechaFinal, sol.Descripcion, sol.Usuario, sol.IP, sol.Accion, sol.IDUsuario, sol.IDGrupo, sol.InitRow, sol.EndRow, sol.SortColumn, sol.SortDir, context);

                Resp = new RespuestaLogSistema
                {
                    Codigo = 1,
                    Resultado = 1,
                    Mensaje = "",
                    Descripcion = "",
                    Logs = res
                };
            }
            catch (Exception ex)
            {
                Resp = new RespuestaLogSistema
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace,
                    Logs = new List<DatosParametricos.Entidades.LogSistema>()
                };
            }

            return Resp;
        }
    }
}

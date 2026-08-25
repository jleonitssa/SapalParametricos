using APIParametricos.Code;
using APIParametricos.Dtos.Respuesta;
using APIParametricos.Dtos.Solicitud.Catalogos;
using DatosParametricos.Operaciones;
using Microsoft.AspNetCore.Mvc;

namespace APIParametricos.Controllers.Catalogos
{
    [ApiController]
    [Route("tuberia")]
    public class TuberiaController : ControllerBase
    {
        private readonly DatosParametricos.ApplicationDbContext context;

        public TuberiaController(DatosParametricos.ApplicationDbContext context)
        {
            this.context = context;
        }

        [HttpPost]
        [Route("TuberiaCount")]
        public Respuesta TuberiaCount(reqTuberiaCount sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesTuberia.TuberiaCount(sol.IDTuberia, sol.Nombre, context);

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
        [Route("TuberiaDelete")]
        public Respuesta TuberiaDelete(reqTuberiaDelete sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesTuberia.TuberiaDelete(sol.IDTuberia, context);

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
        [Route("TuberiaInsert")]
        public Respuesta TuberiaInsert(reqTuberiaInsert sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesTuberia.TuberiaInsert(sol.Nombre, context);

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
        [Route("TuberiaSelect")]
        public RespuestaTuberia TuberiaSelect(reqTuberiaSelect sol)
        {
            RespuestaTuberia Resp;

            try
            {
                List<DatosParametricos.Entidades.Tuberia> res = DatosParametricos.Operaciones.OperacionesTuberia.TuberiaSelect(sol.IDTuberia, sol.Nombre, sol.InitRow, sol.EndRow, sol.SortColumn, sol.SortDir, context);

                Resp = new RespuestaTuberia
                {
                    Codigo = 1,
                    Resultado = 1,
                    Mensaje = "",
                    Descripcion = "",
                    Tuberias = res
                };
            }
            catch (Exception ex)
            {
                Resp = new RespuestaTuberia
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace,
                    Tuberias = new List<DatosParametricos.Entidades.Tuberia>()
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("TuberiaUpdate")]
        public Respuesta TuberiaUpdate(reqTuberiaUpdate sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesTuberia.TuberiaUpdate(sol.IDTuberia, sol.Nombre, context);

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
using APIParametricos.Code;
using APIParametricos.Dtos.Respuesta;
using APIParametricos.Dtos.Solicitud.Catalogos;
using DatosParametricos.Operaciones;
using Microsoft.AspNetCore.Mvc;

namespace APIParametricos.Controllers.Catalogos
{
    [ApiController]
    [Route("clavetrabajo")]
    public class ClaveTrabajoController : ControllerBase
    {
        private readonly DatosParametricos.ApplicationDbContext context;

        public ClaveTrabajoController(DatosParametricos.ApplicationDbContext context)
        {
            this.context = context;
        }

        [HttpPost]
        [Route("ClaveTrabajoCount")]
        public Respuesta ClaveTrabajoCount(reqClaveTrabajoCount sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesClaveTrabajo.ClaveTrabajoCount(sol.IDClaveTrabajo, sol.Clave, sol.Incluye, context);

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
        [Route("ClaveTrabajoDelete")]
        public Respuesta ClaveTrabajoDelete(reqClaveTrabajoDelete sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesClaveTrabajo.ClaveTrabajoDelete(sol.IDClaveTrabajo, context);

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
        [Route("ClaveTrabajoInsert")]
        public Respuesta ClaveTrabajoInsert(reqClaveTrabajoInsert sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesClaveTrabajo.ClaveTrabajoInsert(sol.Clave, sol.Incluye, context);

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
        [Route("ClaveTrabajoSelect")]
        public RespuestaClaveTrabajo ClaveTrabajoSelect(reqClaveTrabajoSelect sol)
        {
            RespuestaClaveTrabajo Resp;

            try
            {
                List<DatosParametricos.Entidades.ClaveTrabajo> res = DatosParametricos.Operaciones.OperacionesClaveTrabajo.ClaveTrabajoSelect(sol.IDClaveTrabajo, sol.Clave, sol.Incluye, sol.InitRow, sol.EndRow, sol.SortColumn, sol.SortDir, context);

                Resp = new RespuestaClaveTrabajo
                {
                    Codigo = 1,
                    Resultado = 1,
                    Mensaje = "",
                    Descripcion = "",
                    ClavesTrabajo = res
                };
            }
            catch (Exception ex)
            {
                Resp = new RespuestaClaveTrabajo
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace,
                    ClavesTrabajo = new List<DatosParametricos.Entidades.ClaveTrabajo>()
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("ClaveTrabajoUpdate")]
        public Respuesta ClaveTrabajoUpdate(reqClaveTrabajoUpdate sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesClaveTrabajo.ClaveTrabajoUpdate(sol.IDClaveTrabajo, sol.Clave, sol.Incluye, context);

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
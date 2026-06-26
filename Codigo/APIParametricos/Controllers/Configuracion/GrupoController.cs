using APIParametricos.Dtos.Respuesta;
using APIParametricos.Dtos.Solicitud.Configuracion;
using Microsoft.AspNetCore.Mvc;

namespace APIParametricos.Controllers.Configuracion
{
    [ApiController]
    [Route("grupo")]
    public class GrupoController : Controller
    {
        private readonly DatosParametricos.ApplicationDbContext context;

        public GrupoController(DatosParametricos.ApplicationDbContext context)
        {
            this.context = context;
        }

        [HttpPost]
        [Route("GrupoCount")]
        public Respuesta GrupoCount(reqGrupoCount sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesGrupo.GrupoCount(sol.IDGrupo, sol.Nombre, context);

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
        [Route("GrupoDelete")]
        public Respuesta GrupoDelete(reqGrupoDelete sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesGrupo.GrupoDelete(sol.IDGrupo, context);

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
        [Route("GrupoInsert")]
        public Respuesta GrupoInsert(reqGrupoInsert sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesGrupo.GrupoInsert(sol.Nombre, sol.Descripcion, context);

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
        [Route("GrupoSelect")]
        public RespuestaGrupo GrupoSelect(reqGrupoSelect sol)
        {
            RespuestaGrupo Resp;

            try
            {
                List<DatosParametricos.Entidades.Grupo> res = DatosParametricos.Operaciones.OperacionesGrupo.GrupoSelect(sol.IDGrupo, sol.Nombre, sol.InitRow, sol.EndRow, sol.SortColumn, sol.SortDir, context);

                Resp = new RespuestaGrupo
                {
                    Codigo = 1,
                    Resultado = 1,
                    Mensaje = "",
                    Descripcion = "",
                    Grupos = res
                };
            }
            catch (Exception ex)
            {
                Resp = new RespuestaGrupo
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace,
                    Grupos = new List<DatosParametricos.Entidades.Grupo>()
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("GrupoUpdate")]
        public Respuesta GrupoUpdate(reqGrupoUpdate sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesGrupo.GrupoUpdate(sol.IDGrupo, sol.Nombre, sol.Descripcion, context);

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

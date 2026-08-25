using APIParametricos.Code;
using APIParametricos.Dtos.Respuesta;
using APIParametricos.Dtos.Solicitud.Catalogos;
using DatosParametricos.Operaciones;
using Microsoft.AspNetCore.Mvc;

namespace APIParametricos.Controllers.Catalogos
{
    [ApiController]
    [Route("excavacion")]
    public class ExcavacionController : ControllerBase
    {
        private readonly DatosParametricos.ApplicationDbContext context;

        public ExcavacionController(DatosParametricos.ApplicationDbContext context)
        {
            this.context = context;
        }

        [HttpPost]
        [Route("ExcavacionSelect")]
        public RespuestaExcavacion ExcavacionSelect(reqExcavacionSelect sol)
        {
            RespuestaExcavacion Resp;

            try
            {
                List<DatosParametricos.Entidades.Excavacion> res = DatosParametricos.Operaciones.OperacionesExcavacion.ExcavacionSelect(sol.IDExcavacion, sol.Nombre, sol.InitRow, sol.EndRow, sol.SortColumn, sol.SortDir, context);

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
        [Route("ExcavacionCount")]
        public Respuesta ExcavacionCount(reqExcavacionCount sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesExcavacion.ExcavacionCount(sol.IDExcavacion, sol.Nombre, context);

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
        [Route("ExcavacionDelete")]
        public Respuesta ExcavacionDelete(reqExcavacionDelete sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesExcavacion.ExcavacionDelete(sol.IDExcavacion, context);

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
        [Route("ExcavacionInsert")]
        public Respuesta ExcavacionInsert(reqExcavacionInsert sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesExcavacion.ExcavacionInsert(sol.Nombre, context);

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
        [Route("ExcavacionUpdate")]
        public Respuesta ExcavacionUpdate(reqExcavacionUpdate sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesExcavacion.ExcavacionUpdate(sol.IDExcavacion, sol.Nombre, context);

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
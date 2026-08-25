using APIParametricos.Code;
using APIParametricos.Dtos.Respuesta;
using APIParametricos.Dtos.Solicitud.Catalogos;
using DatosParametricos.Operaciones;
using Microsoft.AspNetCore.Mvc;

namespace APIParametricos.Controllers.Catalogos
{
    [ApiController]
    [Route("relacionfinalprecio")]
    public class RelacionFinalPrecioController :  ControllerBase
    {
        private readonly DatosParametricos.ApplicationDbContext context;

        public RelacionFinalPrecioController(DatosParametricos.ApplicationDbContext context)
        {
            this.context = context;
        }

        [HttpPost]
        [Route("RelacionFinalPrecioCount")]
        public Respuesta RelacionFinalPrecioCount(reqRelacionFinalPrecioCount sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesRelacionFinalPrecio.RelacionFinalPrecioCount(sol.IDRelacion, sol.IDRelacionDiametro, sol.IDTipoMaterial, sol.IDExcavacion, sol.Precio, context);

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
        [Route("RelacionFinalPrecioDelete")]
        public Respuesta RelacionFinalPrecioDelete(reqRelacionFinalPrecioDelete sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesRelacionFinalPrecio.RelacionFinalPrecioDelete(sol.IDRelacion, context);

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
        [Route("RelacionFinalPrecioImportar")]
        public Respuesta RelacionFinalPrecioImportar(reqRelacionFinalPrecioImportar sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesRelacionFinalPrecio.RelacionFinalPrecioImportar(sol.LineaTrabajo, sol.TipoObra, sol.TipoMaterial, sol.Tuberia, sol.Diametro, sol.Excavacion, sol.Precio, context);

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
        [Route("RelacionFinalPrecioInsert")]
        public Respuesta RelacionFinalPrecioInsert(reqRelacionFinalPrecioInsert sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesRelacionFinalPrecio.RelacionFinalPrecioInsert(sol.IDRelacionDiametro, sol.IDTipoMaterial, sol.IDExcavacion, sol.Precio, context);

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
        [Route("RelacionFinalPrecioSelect")]
        public RespuestaRelacionFinalPrecio RelacionFinalPrecioSelect(reqRelacionFinalPrecioSelect sol)
        {
            RespuestaRelacionFinalPrecio Resp;

            try
            {
                List<DatosParametricos.Entidades.RelacionFinalPrecio> res = DatosParametricos.Operaciones.OperacionesRelacionFinalPrecio.RelacionFinalPrecioSelect(sol.IDRelacion, sol.IDRelacionDiametro, sol.IDTipoMaterial, sol.IDExcavacion, sol.InitRow, sol.EndRow, sol.SortColumn, sol.SortDir, context);

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
        [Route("RelacionFinalPrecioUpdate")]
        public Respuesta RelacionFinalPrecioUpdate(reqRelacionFinalPrecioUpdate sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesRelacionFinalPrecio.RelacionFinalPrecioUpdate(sol.IDRelacion, sol.IDRelacionDiametro, sol.IDTipoMaterial, sol.IDExcavacion, sol.Precio, context);

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
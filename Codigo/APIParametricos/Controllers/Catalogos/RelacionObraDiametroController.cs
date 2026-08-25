using APIParametricos.Code;
using APIParametricos.Dtos.Respuesta;
using APIParametricos.Dtos.Solicitud.Catalogos;
using DatosParametricos.Operaciones;
using Microsoft.AspNetCore.Mvc;

namespace APIParametricos.Controllers.Catalogos
{
    [ApiController]
    [Route("relacionobradiametro")]
    public class RelacionObraDiametroController : ControllerBase
    {
        private readonly DatosParametricos.ApplicationDbContext context;

        public RelacionObraDiametroController(DatosParametricos.ApplicationDbContext context)
        {
            this.context = context;
        }

        [HttpPost]
        [Route("RelacionObraDiametroCount")]
        public Respuesta RelacionObraDiametroCount(reqRelacionObraDiametroCount sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesRelacionObraDiametro.RelacionObraDiametroCount(sol.IDRelacion, sol.IDRelacionObra, sol.IDDiametro, context);

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
        [Route("RelacionObraDiametroDelete")]
        public Respuesta RelacionObraDiametroDelete(reqRelacionObraDiametroDelete sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesRelacionObraDiametro.RelacionObraDiametroDelete(sol.IDRelacion, context);

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
        [Route("RelacionObraDiametroInsert")]
        public Respuesta RelacionObraDiametroInsert(reqRelacionObraDiametroInsert sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesRelacionObraDiametro.RelacionObraDiametroInsert(sol.IDRelacionObra, sol.IDDiametro, context);

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
        [Route("RelacionObraDiametroSelect")]
        public RespuestaRelacionObraDiametro RelacionObraDiametroSelect(reqRelacionObraDiametroSelect sol)
        {
            RespuestaRelacionObraDiametro Resp;

            try
            {
                List<DatosParametricos.Entidades.RelacionObraDiametro> res = DatosParametricos.Operaciones.OperacionesRelacionObraDiametro.RelacionObraDiametroSelect(sol.IDRelacion, sol.IDRelacionObra, sol.IDDiametro, sol.InitRow, sol.EndRow, sol.SortColumn, sol.SortDir, context);

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
        [Route("RelacionObraDiametroUpdate")]
        public Respuesta RelacionObraDiametroUpdate(reqRelacionObraDiametroUpdate sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesRelacionObraDiametro.RelacionObraDiametroUpdate(sol.IDRelacion, sol.IDRelacionObra, sol.IDDiametro, context);

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
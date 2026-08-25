using APIParametricos.Code;
using APIParametricos.Dtos.Respuesta;
using APIParametricos.Dtos.Solicitud.Catalogos;
using DatosParametricos.Operaciones;
using Microsoft.AspNetCore.Mvc;

namespace APIParametricos.Controllers.Catalogos
{
    [ApiController]
    [Route("tipoobra")]
    public class TipoObraController : ControllerBase
    {
        private readonly DatosParametricos.ApplicationDbContext context;

        public TipoObraController(DatosParametricos.ApplicationDbContext context)
        {
            this.context = context;
        }

        [HttpPost]
        [Route("TipoObraCount")]
        public Respuesta TipoObraCount(reqTipoObraCount sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesTipoObra.TipoObraCount(sol.IDTipoObra, sol.IDClaveTrabajo, sol.Nombre, context);

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
        [Route("TipoObraDelete")]
        public Respuesta TipoObraDelete(reqTipoObraDelete sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesTipoObra.TipoObraDelete(sol.IDTipoObra, context);

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
        [Route("TipoObraInsert")]
        public Respuesta TipoObraInsert(reqTipoObraInsert sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesTipoObra.TipoObraInsert(sol.IDClaveTrabajo, sol.Nombre, context);

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
        [Route("TipoObraSelect")]
        public RespuestaTipoObra TipoObraSelect(reqTipoObraSelect sol)
        {
            RespuestaTipoObra Resp;

            try
            {
                List<DatosParametricos.Entidades.TipoObra> res = DatosParametricos.Operaciones.OperacionesTipoObra.TipoObraSelect(sol.IDTipoObra, sol.IDClaveTrabajo, sol.Nombre, sol.InitRow, sol.EndRow, sol.SortColumn, sol.SortDir, context);

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

        [HttpPost]
        [Route("TipoObraUpdate")]
        public Respuesta TipoObraUpdate(reqTipoObraUpdate sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesTipoObra.TipoObraUpdate(sol.IDTipoObra, sol.IDClaveTrabajo, sol.Nombre, context);

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
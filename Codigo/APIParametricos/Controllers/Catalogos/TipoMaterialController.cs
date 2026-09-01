using APIParametricos.Code;
using APIParametricos.Dtos.Respuesta;
using APIParametricos.Dtos.Solicitud.Catalogos;
using DatosParametricos.Operaciones;
using Microsoft.AspNetCore.Mvc;

namespace APIParametricos.Controllers.Catalogos
{
    [ApiController]
    [Route("tipomaterial")]
    public class TipoMaterialController : ControllerBase
    {
        private readonly DatosParametricos.ApplicationDbContext context;

        public TipoMaterialController(DatosParametricos.ApplicationDbContext context)
        {
            this.context = context;
        }

        [HttpPost]
        [Route("TipoMaterialCount")]
        public Respuesta TipoMaterialCount(reqTipoMaterialCount sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesTipoMaterial.TipoMaterialCount(sol.IDTipoMaterial, sol.Nombre, context);

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
        [Route("TipoMaterialDelete")]
        public Respuesta TipoMaterialDelete(reqTipoMaterialDelete sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesTipoMaterial.TipoMaterialDelete(sol.IDTipoMaterial, context);

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
        [Route("TipoMaterialInsert")]
        public Respuesta TipoMaterialInsert(reqTipoMaterialInsert sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesTipoMaterial.TipoMaterialInsert(sol.Nombre, sol.Descripcion1, sol.Descripcion2, sol.Descripcion3, context);

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
        [Route("TipoMaterialSelect")]
        public RespuestaTipoMaterial TipoMaterialSelect(reqTipoMaterialSelect sol)
        {
            RespuestaTipoMaterial Resp;

            try
            {
                List<DatosParametricos.Entidades.TipoMaterial> res = DatosParametricos.Operaciones.OperacionesTipoMaterial.TipoMaterialSelect(sol.IDTipoMaterial, sol.Nombre, sol.InitRow, sol.EndRow, sol.SortColumn, sol.SortDir, context);

                Resp = new RespuestaTipoMaterial
                {
                    Codigo = 1,
                    Resultado = 1,
                    Mensaje = "",
                    Descripcion = "",
                    TiposMaterial = res
                };
            }
            catch (Exception ex)
            {
                Resp = new RespuestaTipoMaterial
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace,
                    TiposMaterial = new List<DatosParametricos.Entidades.TipoMaterial>()
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("TipoMaterialUpdate")]
        public Respuesta TipoMaterialUpdate(reqTipoMaterialUpdate sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesTipoMaterial.TipoMaterialUpdate(sol.IDTipoMaterial, sol.Nombre, sol.Descripcion1, sol.Descripcion2, sol.Descripcion3, context);

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
        [Route("TipoMaterialUpdateImagen")]
        public Respuesta TipoMaterialUpdateImagen(reqTipoMaterialUpdateImagen sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesTipoMaterial.TipoMaterialUpdateImagen(sol.IDTipoMaterial, sol.Imagen, context);

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
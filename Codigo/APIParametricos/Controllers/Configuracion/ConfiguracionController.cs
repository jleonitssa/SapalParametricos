using APIParametricos.Dtos.Respuesta;
using APIParametricos.Dtos.Solicitud.Configuracion;
using Microsoft.AspNetCore.Mvc;

namespace APIParametricos.Controllers.Configuracion
{
    [ApiController]
    [Route("configuracion")]
    public class ConfiguracionController : Controller
    {
        private readonly DatosParametricos.ApplicationDbContext context;

        public ConfiguracionController(DatosParametricos.ApplicationDbContext context)
        {
            this.context = context;
        }

        [HttpPost]
        [Route("ConfiguracionSelect")]
        public RespuestaConfiguracion ConfiguracionSelect()
        {
            RespuestaConfiguracion Resp;

            try
            {
                List<DatosParametricos.Entidades.Configuracion> res = DatosParametricos.Operaciones.OperacionesConfiguracion.ConfiguracionSelect(context);

                Resp = new RespuestaConfiguracion
                {
                    Codigo = 1,
                    Resultado = 1,
                    Mensaje = "",
                    Descripcion = "",
                    Configs = res
                };
            }
            catch (Exception ex)
            {
                Resp = new RespuestaConfiguracion
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace,
                    Configs = new List<DatosParametricos.Entidades.Configuracion>()
                };
            }

            return Resp;
        }

        //[HttpPost]
        //[Route("ConfiguracionUpdate")]
        //public Respuesta ConfiguracionUpdate(reqConfiguracionUpdate sol)
        //{
        //    Respuesta Resp;

        //    try
        //    {
        //        int res = DatosParametricos.Operaciones.OperacionesConfiguracion.ConfiguracionUpdate(sol.TiempoCierreSesion, sol.Smtp, sol.Puerto, sol.Ssl, sol.Usuario, sol.Contrasena,
        //                                                                                      sol.MinimoCaracteres, sol.MinimoMayusculas, sol.MinimoMinusculas, sol.MinimoNumeros,
        //                                                                                      sol.MinimoCarEspecial, sol.IntentosPassword, sol.CorreoBienvenida, sol.CorreoRegenerar,
        //                                                                                      sol.CorreoNotificacionCita, sol.TallerTrabajaSabado, sol.CorreoCancelacionCita,
        //                                                                                      sol.CorreoRecepcionUnidad, sol.CorreoProrrogaUnidad, sol.CorreoEntregaUnidad,
        //                                                                                      sol.CorreoTerminoUnidad, sol.CorreoRecordatorio, sol.CorreoCancelacionManual,
        //                                                                                      sol.DiasAntesRecordatorio, sol.TipoEnvioCorreo, sol.UsuarioServicioCorreo,
        //                                                                                      sol.ContrasenaServicioCorreo, sol.TokenBotTelegram, sol.ApiKeyGPS, sol.ApiKeyGRP,
        //                                                                                      sol.FromCorreoSistema, sol.CorreoTerminoTaller, sol.CorreoOrdenTrabajo,
        //                                                                                      sol.CorreoOrdenTrabajoAprobado, sol.CorreoOrdenTrabajoRechazado, sol.EmailAlmacen, 
        //                                                                                      context);

        //        Resp = new Respuesta
        //        {
        //            Codigo = 1,
        //            Resultado = res,
        //            Mensaje = "",
        //            Descripcion = ""
        //        };
        //    }
        //    catch (Exception ex)
        //    {
        //        Resp = new Respuesta
        //        {
        //            Codigo = -1,
        //            Resultado = -1,
        //            Mensaje = ex.Message,
        //            Descripcion = ex.StackTrace
        //        };
        //    }

        //    return Resp;
        //}

        //[HttpPost]
        //[Route("ConfiguracionAdicionalUpdate")]
        //public Respuesta ConfiguracionAdicionalUpdate(reqConfiguracionAdicionalUpdate sol)
        //{
        //    Respuesta Resp;

        //    try
        //    {
        //        int res = DatosParametricos.Operaciones.OperacionesConfiguracion.ConfiguracionAdicionalUpdate(sol.CorreosAdicionales, context);

        //        Resp = new Respuesta
        //        {
        //            Codigo = 1,
        //            Resultado = res,
        //            Mensaje = "",
        //            Descripcion = ""
        //        };
        //    }
        //    catch (Exception ex)
        //    {
        //        Resp = new Respuesta
        //        {
        //            Codigo = -1,
        //            Resultado = -1,
        //            Mensaje = ex.Message,
        //            Descripcion = ex.StackTrace
        //        };
        //    }

        //    return Resp;
        //}
    }
}

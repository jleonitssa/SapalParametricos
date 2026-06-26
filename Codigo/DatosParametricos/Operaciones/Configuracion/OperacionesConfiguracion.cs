using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace DatosParametricos.Operaciones
{
    public static class OperacionesConfiguracion
    {
        public static List<Entidades.Configuracion> ConfiguracionSelect(ApplicationDbContext context)
        {
            var respuesta = context.Configs.FromSql<Entidades.Configuracion>($"EXEC dbo.sysConfiguracionSelect").AsEnumerable().ToList();

            return respuesta;
        }

        public static int ConfiguracionUpdate(int TiempoCierreSesion, string Smtp, int Puerto, bool Ssl, string Usuario, string Contrasena, int MinimoCaracteres,
                                              int MinimoMayusculas, int MinimoMinusculas, int MinimoNumeros, int MinimoCarEspecial, int IntentosPassword,
                                              string CorreoBienvenida, string CorreoRegenerar, string CorreoNotificacionCita, bool TallerTrabajaSabado,
                                              string CorreoCancelacionCita, string CorreoRecepcionUnidad, string CorreoProrrogaUnidad, string CorreoEntregaUnidad,
                                              string CorreoTerminoUnidad, string CorreoRecordatorio, string CorreoCancelacionManual, int DiasAntesRecordatorio,
                                              byte TipoEnvioCorreo, string UsuarioServicioCorreo, string ContrasenaServicioCorreo, string TokenBotTelegram,
                                              string ApiKeyGPS, string ApiKeyGRP, string FromCorreoSistema, string CorreoTerminoTaller, string CorreoOrdenTrabajo,
                                              string CorreoOrdenTrabajoAprobado, string CorreoOrdenTrabajoRechazado, string EmailAlmacen, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysConfiguracionUpdate @TiempoCierreSesion={TiempoCierreSesion}, " +
                                                           $"@Smtp='{Smtp.Replace("'", "''").Replace("{", "{{").Replace("}", "}}")}', @Puerto={Puerto}, @Ssl={(Ssl ? 1 : 0)}, " +
                                                           $"@Usuario='{Usuario.Replace("'", "''").Replace("{", "{{").Replace("}", "}}")}', " +
                                                           $"@Contrasena='{Contrasena.Replace("'", "''").Replace("{", "{{").Replace("}", "}}")}', " +
                                                           $"@MinimoCaracteres={MinimoCaracteres}, @MinimoMayusculas={MinimoMayusculas}, " +
                                                           $"@MinimoMinusculas={MinimoMinusculas}, @MinimoNumeros={MinimoNumeros}, " +
                                                           $"@MinimoCarEspecial={MinimoCarEspecial}, @IntentosPassword={IntentosPassword}, " +
                                                           $"@CorreoBienvenida='{CorreoBienvenida.Replace("'", "''").Replace("{", "{{").Replace("}", "}}")}', " +
                                                           $"@CorreoRegenerar='{CorreoRegenerar.Replace("'", "''").Replace("{", "{{").Replace("}", "}}")}', " +
                                                           $"@CorreoNotificacionCita='{CorreoNotificacionCita.Replace("'", "''").Replace("{", "{{").Replace("}", "}}")}', " +
                                                           $"@TallerTrabajaSabado={(TallerTrabajaSabado ? 1 : 0)}, " +
                                                           $"@CorreoCancelacionCita='{CorreoCancelacionCita.Replace("'", "''").Replace("{", "{{").Replace("}", "}}")}', " +
                                                           $"@CorreoRecepcionUnidad='{CorreoRecepcionUnidad.Replace("'", "''").Replace("{", "{{").Replace("}", "}}")}', " +
                                                           $"@CorreoProrrogaUnidad='{CorreoProrrogaUnidad.Replace("'", "''").Replace("{", "{{").Replace("}", "}}")}', " +
                                                           $"@CorreoEntregaUnidad='{CorreoEntregaUnidad.Replace("'", "''").Replace("{", "{{").Replace("}", "}}")}', " +
                                                           $"@CorreoTerminoUnidad='{CorreoTerminoUnidad.Replace("'", "''").Replace("{", "{{").Replace("}", "}}")}', " +
                                                           $"@CorreoRecordatorio='{CorreoRecordatorio.Replace("'", "''").Replace("{", "{{").Replace("}", "}}")}', " +
                                                           $"@CorreoCancelacionManual='{CorreoCancelacionManual.Replace("'", "''").Replace("{", "{{").Replace("}", "}}")}', " +
                                                           $"@DiasAntesRecordatorio={DiasAntesRecordatorio}, @TipoEnvioCorreo={TipoEnvioCorreo}, " +
                                                           $"@UsuarioServicioCorreo='{UsuarioServicioCorreo}', @ContrasenaServicioCorreo='{ContrasenaServicioCorreo}', " +
                                                           $"@TokenBotTelegram='{TokenBotTelegram}', @ApiKeyGPS='{ApiKeyGPS}', " +
                                                           $"@ApiKeyGRP='{ApiKeyGRP}', @FromCorreoSistema='{FromCorreoSistema}', " +
                                                           $"@CorreoTerminoTaller='{CorreoTerminoTaller.Replace("'", "''").Replace("{", "{{").Replace("}", "}}")}'," +
                                                           $"@CorreoOrdenTrabajo='{CorreoOrdenTrabajo.Replace("'", "''").Replace("{", "{{").Replace("}", "}}")}'," +
                                                           $"@CorreoOrdenTrabajoAprobado='{CorreoOrdenTrabajoAprobado.Replace("'", "''").Replace("{", "{{").Replace("}", "}}")}'," +
                                                           $"@CorreoOrdenTrabajoRechazado='{CorreoOrdenTrabajoRechazado.Replace("'", "''").Replace("{", "{{").Replace("}", "}}")}'," +
                                                           $"@EmailAlmacen='{EmailAlmacen}'", ret);

            return (int)ret.Value;
        }

        public static int ConfiguracionAdicionalUpdate(string CorreosAdicionales, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysConfiguracionAdicionalUpdate @CorreosAdicionales='{CorreosAdicionales}'", ret);

            return (int)ret.Value;
        }
    }
}

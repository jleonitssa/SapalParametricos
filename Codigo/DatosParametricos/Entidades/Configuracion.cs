using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DatosParametricos.Entidades
{    
    #region Configuracion
    public class Configuracion
    {
        [Key]
        public int IDConfiguracion { get; set; }
        public int TiempoCierreSesion { get; set; }
        public string Smtp { get; set; }
        public int Puerto { get; set; }
        public bool Ssl { get; set; }
        public string Usuario { get; set; }
        public string Contrasena { get; set; }
        public int MinimoCaracteres { get; set; }
        public int MinimoMayusculas { get; set; }
        public int MinimoMinusculas { get; set; }
        public int MinimoNumeros { get; set; }
        public int MinimoCarEspecial { get; set; }
        public int IntentosPassword { get; set; }
        public string CorreoBienvenida { get; set; }
        public string CorreoRegenerar { get; set; }
        public string CorreoNotificacionCita { get; set; }
        public bool TallerTrabajaSabado { get; set; }
        public string CorreoCancelacionCita { get; set; }
        public string CorreoRecepcionUnidad { get; set; }
        public string CorreoProrrogaUnidad { get; set; }
        public string CorreoEntregaUnidad { get; set; }
        public string CorreoTerminoUnidad { get; set; }
        public string CorreoTerminoTaller { get; set; }
        public string CorreoRecordatorio { get; set; }
        public string CorreoCancelacionManual { get; set; }
        public int DiasAntesRecordatorio { get; set; }
        public byte TipoEnvioCorreo { get; set; }
        public string UsuarioServicioCorreo { get; set; }
        public string ContrasenaServicioCorreo { get; set; }
        public string TokenBotTelegram { get; set; }
        public string ApiKeyGPS { get; set; }
        public string ApiKeyGRP { get; set; }
        public string FromCorreoSistema { get; set; }
        public string CorreoOrdenTrabajo { get; set; }
        public string CorreosAdicionales { get; set; }
        public string CorreoOrdenTrabajoAprobado { get; set; }
        public string CorreoOrdenTrabajoRechazado { get; set; }
        public string EmailAlmacen { get; set; }
    }
    #endregion

    #region Grupo
    public class Grupo
    {
        [Key]
        public int IDGrupo { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
    }
    #endregion

    #region LogSistema
    public class LogSistema
    {
        [Key]
        public int IDLogSistema { get; set; }
        public int? IDUsuario { get; set; }
        public int IDPantalla { get; set; }
        public string Accion { get; set; }
        public string Descripcion { get; set; }
        public string Tipo { get; set; }
        public DateTime Fecha { get; set; }
        public string IP { get; set; }
        public string Login { get; set; }
        public string Pantalla { get; set; }
        public string Grupo { get; set; }
    }
    #endregion

    #region Pantalla
    public class Pantalla
    {
        [Key]
        public int IDPantalla { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public string URL { get; set; }
    }
    #endregion
    
    #region Usuario
    public class Usuario
    {
        [Key]
        public int IDUsuario { get; set; }
        public string Login { get; set; }
        public int IDGrupo { get; set; }
        public string Email { get; set; }
        public string Nombre { get; set; }
        public string Apellidos { get; set; }
        public string NombreCompleto { get; set; }
        public int IDEstatus { get; set; }
        public string Password { get; set; }
        public int IntentosPassword { get; set; }
        public string? Comentario { get; set; }
        public string Grupo { get; set; }
        public string Estatus { get; set; }
        public string LoginNombre { get { return Login + " | " + NombreCompleto; } }
    }
    #endregion
}

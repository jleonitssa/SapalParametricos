namespace APIParametricos.Dtos.Respuesta
{
    public class RespuestaConfiguracion : Respuesta
    {
        public List<DatosParametricos.Entidades.Configuracion>? Configs { get; set; }
    }

    public class RespuestaGrupo : Respuesta
    {
        public List<DatosParametricos.Entidades.Grupo>? Grupos { get; set; }
    }

    public class RespuestaLogSistema : Respuesta
    {
        public List<DatosParametricos.Entidades.LogSistema>? Logs { get; set; }
    }

    public class RespuestaPantalla : Respuesta
    {
        public List<DatosParametricos.Entidades.Pantalla>? Pantallas { get; set; }
    }

    public class RespuestaUsuario : Respuesta
    {
        public List<DatosParametricos.Entidades.Usuario>? Usuarios { get; set; }
    }
}

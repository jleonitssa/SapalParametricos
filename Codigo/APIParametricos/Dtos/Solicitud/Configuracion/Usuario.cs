namespace APIParametricos.Dtos.Solicitud.Configuracion
{
    public class reqUsuarioCount
    {
        public int IDUsuario { get; set; }
        public string Login { get; set; }
        public string LoginExacto { get; set; }
        public string Email { get; set; }
        public string Nombre { get; set; }
        public int IDEstatus { get; set; }
        public int IDGrupo { get; set; }
    }

    public class reqUsuarioDelete
    {
        public int IDUsuario { get; set; }
    }

    public class reqUsuarioInsert
    {
        public string Login { get; set; }
        public int IDGrupo { get; set; }
        public string Email { get; set; }
        public string Nombre { get; set; }
        public string Apellidos { get; set; }
    }

    public class reqUsuarioSelect
    {
        public int IDUsuario { get; set; }
        public string Login { get; set; }
        public string LoginExacto { get; set; }
        public string Email { get; set; }
        public string Nombre { get; set; }
        public int IDEstatus { get; set; }
        public int IDGrupo { get; set; }
        public int InitRow { get; set; }
        public int EndRow { get; set; }
        public string SortColumn { get; set; }
        public string SortDir { get; set; }
    }

    public class reqUsuarioUpdate
    {
        public int IDUsuario { get; set; }
        public string Login { get; set; }
        public int IDGrupo { get; set; }
        public string Email { get; set; }
        public string Nombre { get; set; }
        public string Apellidos { get; set; }
        public int IDEstatus { get; set; }
    }

    public class reqUsuarioValidar
    {
        public byte Operacion { get; set; }
        public int IDUsuario { get; set; }
        public string Valor { get; set; }
    }

    public class reqUsuarioXPermisoSelect
    {
        public string Pantalla { get; set; }
        public string Accion { get; set; }
    }

    public class reqUsuarioValidarSesion
    {
        public string Login { get; set; }
        public string Pass { get; set; }
    }

    public class reqUsuarioCambiarContrasena
    {
        public int IDUsuario { get; set; }
        public string Pass { get; set; }
    }
}

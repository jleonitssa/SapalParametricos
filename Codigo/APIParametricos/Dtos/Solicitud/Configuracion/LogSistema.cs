namespace APIParametricos.Dtos.Solicitud.Configuracion
{
    public class reqLogSistemaCount
    {
        public int IDLogSistema { get; set; }
        public string? Tipo { get; set; }
        public int IDPantalla { get; set; }
        public string? FechaInicial { get; set; }
        public string? FechaFinal { get; set; }
        public string? Descripcion { get; set; }
        public string? Usuario { get; set; }
        public string? IP { get; set; }
        public string? Accion { get; set; }
        public int IDUsuario { get; set; }
        public int IDGrupo { get; set; }
    }

    public class reqLogSistemaInsert
    {
        public int IDUsuario { get; set; }
        public string Pantalla { get; set; }
        public string Accion { get; set; }
        public string Descripcion { get; set; }
        public string Tipo { get; set; }
    }

    public class reqLogSistemaSelect
    {
        public int IDLogSistema { get; set; }
        public string? Tipo { get; set; }
        public int IDPantalla { get; set; }
        public string? FechaInicial { get; set; }
        public string? FechaFinal { get; set; }
        public string? Descripcion { get; set; }
        public string? Usuario { get; set; }
        public string? IP { get; set; }
        public string? Accion { get; set; }
        public int IDUsuario { get; set; }
        public int IDGrupo { get; set; }
        public int InitRow { get; set; }
        public int EndRow { get; set; }
        public string? SortColumn { get; set; }
        public string? SortDir { get; set; }
    }
}

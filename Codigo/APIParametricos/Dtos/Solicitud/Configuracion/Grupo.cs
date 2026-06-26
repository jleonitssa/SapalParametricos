namespace APIParametricos.Dtos.Solicitud.Configuracion
{
    public class reqGrupoCount
    {
        public int IDGrupo { get; set; }
        public string? Nombre { get; set; }
    }

    public class reqGrupoDelete
    {
        public int IDGrupo { get; set; }
    }

    public class reqGrupoInsert
    {
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
    }

    public class reqGrupoSelect
    {
        public int IDGrupo { get; set; }
        public string? Nombre { get; set; }
        public int InitRow { get; set; }
        public int EndRow { get; set; }
        public string? SortColumn { get; set; }
        public string? SortDir { get; set; }
    }

    public class reqGrupoUpdate
    {
        public int IDGrupo { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
    }
}

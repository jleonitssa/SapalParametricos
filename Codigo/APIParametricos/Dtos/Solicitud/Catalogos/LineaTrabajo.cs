namespace APIParametricos.Dtos.Solicitud.Catalogos
{
    public class reqLineaTrabajoCount
    {
        public int IDLineaTrabajo { get; set; }
        public string Nombre { get; set; }
        public int IDClaveTrabajo { get; set; }
    }

    public class reqLineaTrabajoDelete
    {
        public int IDLineaTrabajo { get; set; }
    }

    public class reqLineaTrabajoInsert
    {
        public string Nombre { get; set; }
        public int IDClaveTrabajo { get; set; }
    }

    public class reqLineaTrabajoSelect
    {
        public int IDLineaTrabajo { get; set; }
        public string Nombre { get; set; }
        public int IDClaveTrabajo { get; set; }
        public int InitRow { get; set; }
        public int EndRow { get; set; }
        public string SortColumn { get; set; }
        public string SortDir { get; set; }
    }

    public class reqLineaTrabajoUpdate
    {
        public int IDLineaTrabajo { get; set; }
        public string Nombre { get; set; }
        public int IDClaveTrabajo { get; set; }
    }
}

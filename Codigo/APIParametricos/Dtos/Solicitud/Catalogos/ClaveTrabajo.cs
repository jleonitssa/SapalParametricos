namespace APIParametricos.Dtos.Solicitud.Catalogos
{
    public class reqClaveTrabajoCount
    {
        public int IDClaveTrabajo { get; set; }
        public string Clave { get; set; }
        public string Incluye { get; set; }
    }

    public class reqClaveTrabajoDelete
    {
        public int IDClaveTrabajo { get; set; }
    }

    public class reqClaveTrabajoInsert
    {
        public string Clave { get; set; }
        public string Incluye { get; set; }
    }

    public class reqClaveTrabajoSelect
    {
        public int IDClaveTrabajo { get; set; }
        public string Clave { get; set; }
        public string Incluye { get; set; }
        public int InitRow { get; set; }
        public int EndRow { get; set; }
        public string SortColumn { get; set; }
        public string SortDir { get; set; }
    }

    public class reqClaveTrabajoUpdate
    {
        public int IDClaveTrabajo { get; set; }
        public string Clave { get; set; }
        public string Incluye { get; set; }
    }
}

namespace APIParametricos.Dtos.Solicitud.Catalogos
{
    public class reqTipoObraCount
    {
        public int IDTipoObra { get; set; }
        public int IDClaveTrabajo { get; set; }
        public string Nombre { get; set; }
    }

    public class reqTipoObraDelete
    {
        public int IDTipoObra { get; set; }
    }

    public class reqTipoObraInsert
    {
        public int IDClaveTrabajo { get; set; }
        public string Nombre { get; set; }
    }

    public class reqTipoObraSelect
    {
        public int IDTipoObra { get; set; }
        public int IDClaveTrabajo { get; set; }
        public string Nombre { get; set; }
        public int InitRow { get; set; }
        public int EndRow { get; set; }
        public string SortColumn { get; set; }
        public string SortDir { get; set; }
    }

    public class reqTipoObraUpdate
    {
        public int IDTipoObra { get; set; }
        public int IDClaveTrabajo { get; set; }
        public string Nombre { get; set; }
    }
}

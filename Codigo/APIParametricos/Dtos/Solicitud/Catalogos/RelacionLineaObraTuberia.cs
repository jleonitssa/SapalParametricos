namespace APIParametricos.Dtos.Solicitud.Catalogos
{
    public class reqRelacionLineaObraTuberiaCount
    {
        public int IDRelacion { get; set; }
        public int IDLineaTrabajo { get; set; }
        public int IDTipoObra { get; set; }
        public int IDTuberia { get; set; }
    }

    public class reqRelacionLineaObraTuberiaDelete
    {
        public int IDRelacion { get; set; }
    }

    public class reqRelacionLineaObraTuberiaInsert
    {
        public int IDLineaTrabajo { get; set; }
        public int IDTipoObra { get; set; }
        public int IDTuberia { get; set; }
    }

    public class reqRelacionLineaObraTuberiaSelect
    {
        public int IDRelacion { get; set; }
        public int IDLineaTrabajo { get; set; }
        public int IDTipoObra { get; set; }
        public int IDTuberia { get; set; }
        public int InitRow { get; set; }
        public int EndRow { get; set; }
        public string SortColumn { get; set; }
        public string SortDir { get; set; }
    }

    public class reqRelacionLineaObraTuberiaUpdate
    {
        public int IDRelacion { get; set; }
        public int IDLineaTrabajo { get; set; }
        public int IDTipoObra { get; set; }
        public int IDTuberia { get; set; }
    }
}

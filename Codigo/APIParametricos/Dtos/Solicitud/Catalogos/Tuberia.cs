namespace APIParametricos.Dtos.Solicitud.Catalogos
{
    public class reqTuberiaCount
    {
        public int IDTuberia { get; set; }
        public string Nombre { get; set; }
    }

    public class reqTuberiaDelete
    {
        public int IDTuberia { get; set; }
    }

    public class reqTuberiaInsert
    {
        public string Nombre { get; set; }
    }

    public class reqTuberiaSelect
    {
        public int IDTuberia { get; set; }
        public string Nombre { get; set; }
        public int InitRow { get; set; }
        public int EndRow { get; set; }
        public string SortColumn { get; set; }
        public string SortDir { get; set; }
    }

    public class reqTuberiaUpdate
    {
        public int IDTuberia { get; set; }
        public string Nombre { get; set; }
    }
}

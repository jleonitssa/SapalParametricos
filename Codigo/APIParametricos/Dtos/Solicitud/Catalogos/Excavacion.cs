namespace APIParametricos.Dtos.Solicitud.Catalogos
{
    public class reqExcavacionCount
    {
        public int IDExcavacion { get; set; }
        public string Nombre { get; set; }
    }

    public class reqExcavacionDelete
    {
        public int IDExcavacion { get; set; }
    }

    public class reqExcavacionInsert
    {
        public string Nombre { get; set; }
    }

    public class reqExcavacionSelect
    {
        public int IDExcavacion { get; set; }
        public string Nombre { get; set; }
        public int InitRow { get; set; }
        public int EndRow { get; set; }
        public string SortColumn { get; set; }
        public string SortDir { get; set; }
    }

    public class reqExcavacionUpdate
    {
        public int IDExcavacion { get; set; }
        public string Nombre { get; set; }
    }
}

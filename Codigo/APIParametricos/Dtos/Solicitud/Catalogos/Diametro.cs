namespace APIParametricos.Dtos.Solicitud.Catalogos
{
    public class reqDiametroCount
    {
        public int IDDiametro { get; set; }
        public string Nombre { get; set; }
    }

    public class reqDiametroDelete
    {
        public int IDDiametro { get; set; }
    }

    public class reqDiametroInsert
    {
        public string Nombre { get; set; }
    }

    public class reqDiametroSelect
    {
        public int IDDiametro { get; set; }
        public string Nombre { get; set; }
        public int InitRow { get; set; }
        public int EndRow { get; set; }
        public string SortColumn { get; set; }
        public string SortDir { get; set; }
    }

    public class reqDiametroUpdate
    {
        public int IDDiametro { get; set; }
        public string Nombre { get; set; }
    }
}

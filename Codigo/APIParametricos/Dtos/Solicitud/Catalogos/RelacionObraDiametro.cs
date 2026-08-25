namespace APIParametricos.Dtos.Solicitud.Catalogos
{
    public class reqRelacionObraDiametroCount
    {
        public int IDRelacion { get; set; }
        public int IDRelacionObra { get; set; }
        public int IDDiametro { get; set; }
    }

    public class reqRelacionObraDiametroDelete
    {
        public int IDRelacion { get; set; }
    }

    public class reqRelacionObraDiametroInsert
    {
        public int IDRelacionObra { get; set; }
        public int IDDiametro { get; set; }
    }

    public class reqRelacionObraDiametroSelect
    {
        public int IDRelacion { get; set; }
        public int IDRelacionObra { get; set; }
        public int IDDiametro { get; set; }
        public int InitRow { get; set; }
        public int EndRow { get; set; }
        public string SortColumn { get; set; }
        public string SortDir { get; set; }
    }

    public class reqRelacionObraDiametroUpdate
    {
        public int IDRelacion { get; set; }
        public int IDRelacionObra { get; set; }
        public int IDDiametro { get; set; }
    }
}

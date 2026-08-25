namespace APIParametricos.Dtos.Solicitud.Catalogos
{
    public class reqRelacionFinalPrecioCount
    {
        public int IDRelacion { get; set; }
        public int IDRelacionDiametro { get; set; }
        public int IDTipoMaterial { get; set; }
        public int IDExcavacion { get; set; }
        public decimal Precio { get; set; }
    }

    public class reqRelacionFinalPrecioDelete
    {
        public int IDRelacion { get; set; }
    }

    public class reqRelacionFinalPrecioImportar
    {
        public string LineaTrabajo { get; set; }
        public string TipoObra { get; set; }
        public string TipoMaterial { get; set; }
        public string Tuberia { get; set; }
        public string Diametro { get; set; }
        public string Excavacion { get; set; }
        public decimal Precio { get; set; }
    }

    public class reqRelacionFinalPrecioInsert
    {
        public int IDRelacionDiametro { get; set; }
        public int IDTipoMaterial { get; set; }
        public int IDExcavacion { get; set; }
        public decimal Precio { get; set; }
    }

    public class reqRelacionFinalPrecioSelect
    {
        public int IDRelacion { get; set; }
        public int IDRelacionDiametro { get; set; }
        public int IDTipoMaterial { get; set; }
        public int IDExcavacion { get; set; }
        public int InitRow { get; set; }
        public int EndRow { get; set; }
        public string SortColumn { get; set; }
        public string SortDir { get; set; }
    }

    public class reqRelacionFinalPrecioUpdate
    {
        public int IDRelacion { get; set; }
        public int IDRelacionDiametro { get; set; }
        public int IDTipoMaterial { get; set; }
        public int IDExcavacion { get; set; }
        public decimal Precio { get; set; }
    }
}

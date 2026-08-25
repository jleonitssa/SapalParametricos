namespace APIParametricos.Dtos.Solicitud.Catalogos
{
    public class reqTipoMaterialCount
    {
        public int IDTipoMaterial { get; set; }
        public string Nombre { get; set; }
    }

    public class reqTipoMaterialDelete
    {
        public int IDTipoMaterial { get; set; }
    }

    public class reqTipoMaterialInsert
    {
        public string Nombre { get; set; }
    }

    public class reqTipoMaterialSelect
    {
        public int IDTipoMaterial { get; set; }
        public string Nombre { get; set; }
        public int InitRow { get; set; }
        public int EndRow { get; set; }
        public string SortColumn { get; set; }
        public string SortDir { get; set; }
    }

    public class reqTipoMaterialUpdate
    {
        public int IDTipoMaterial { get; set; }
        public string Nombre { get; set; }
    }
}

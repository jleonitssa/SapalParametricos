namespace APIParametricos.Dtos.Solicitud.Configuracion
{
    public class reqPantallaCount
    {
        public int IDPantalla { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public string URL { get; set; }
    }

    public class reqPantallaDelete
    {
        public int IDPantalla { get; set; }
    }

    public class reqPantallaInsert
    {
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public string URL { get; set; }
    }

    public class reqPantallaMenu
    {
        public int IDPantalla { get; set; }
    }

    public class reqPantallaSelect
    {
        public int IDPantalla { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public string URL { get; set; }
        public int InitRow { get; set; }
        public int EndRow { get; set; }
        public string SortColumn { get; set; }
        public string SortDir { get; set; }
    }

    public class reqPantallaUpdate
    {
        public int IDPantalla { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public string URL { get; set; }
    }
}

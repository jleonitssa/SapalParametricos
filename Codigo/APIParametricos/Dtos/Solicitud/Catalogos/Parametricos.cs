namespace APIParametricos.Dtos.Solicitud.Catalogos
{
    public class reqRelacionFinalPrecioSelect
    {
        public int IDRelacionDiametro { get; set; }
        public int IDTipoMaterial { get; set; }
        public int IDExcavacion { get; set; }
    }

    public class reqRelacionLineaObraTuberiaSelect
    {
        public int IDLineaTrabajo { get; set; }
        public int IDTipoObra { get; set; }
    }

    public class reqRelacionObraDiametroSelect
    {
        public int IDRelacionObra { get; set; }
    }

    public class reqTipoObraSelect
    {
        public int IDClaveTrabajo { get; set; }
    }
}

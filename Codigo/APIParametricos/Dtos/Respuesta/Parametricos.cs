namespace APIParametricos.Dtos.Respuesta
{
    public class RespuestaExcavacion : Respuesta
    {
        public List<DatosParametricos.Entidades.Excavacion>? Excavaciones { get; set; }
    }

    public class RespuestaLineaTrabajo : Respuesta
    {
        public List<DatosParametricos.Entidades.LineaTrabajo>? LineasTrabajo { get; set; }
    }

    public class RespuestaRelacionFinalPrecio : Respuesta
    {
        public List<DatosParametricos.Entidades.RelacionFinalPrecio>? RelacionesFinalPrecio { get; set; }
    }

    public class RespuestaRelacionLineaObraTuberia : Respuesta
    {
        public List<DatosParametricos.Entidades.RelacionLineaObraTuberia>? RelacionesLineaObraTuberia { get; set; }
    }

    public class RespuestaRelacionObraDiametro : Respuesta
    {
        public List<DatosParametricos.Entidades.RelacionObraDiametro>? RelacionesObraDiametro { get; set; }
    }

    public class RespuestaTipoMaterial : Respuesta
    {
        public List<DatosParametricos.Entidades.TipoMaterial>? TiposMaterial { get; set; }
    }

    public class RespuestaTipoObra : Respuesta
    {
        public List<DatosParametricos.Entidades.TipoObra>? TiposObra { get; set; }
    }

    public class RespuestaActualizacion()
    {
        public string resultado {  get; set; }
        public List<MensajeError> errores { get; set; }
    }

    public class MensajeError
    {
        public string error {  get; set; }
    }
}

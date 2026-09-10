using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UtilidadesParametricos
{
    #region ArchivoOrden
    public class ArchivoOrden
    {
        public string NombreArchivo { get; set; }
        public string RutaArchivo { get; set; }
        public byte[] BytesArchivo { get; set; }
    }
    #endregion

    #region UnidadGps
    public class UnidadGps
    {
        [Key]
        public string Imei { get; set; }
        public string Nombre { get; set; }
        public string Modelo { get; set; }
        public DateTime FechaServidor { get; set; }
        public DateTime FechaGps { get; set; }
        public decimal Latitud { get; set; }
        public decimal Longitud { get; set; }
        public Int64 Velocidad { get; set; }
        public Int64 Odometro { get; set; }
    }
    #endregion
}

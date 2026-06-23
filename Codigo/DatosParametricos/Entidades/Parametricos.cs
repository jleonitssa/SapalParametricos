using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace DatosParametricos.Entidades
{
    #region ClaveTrabajo
    public class ClaveTrabajo
    {
        [Key]
        public int IDClaveTrabajo { get; set; }
        public string Clave { get; set; }
        public string Incluye { get; set; }
    }
    #endregion

    #region Diametro
    public class Diametro
    {
        [Key]
        public int IDDiametro { get; set; }
        public string Nombre { get; set; }
    }
    #endregion

    #region Excavacion
    public class Excavacion
    {
        [Key]
        public int IDExcavacion { get; set; }
        public string Nombre { get; set; }
    }
    #endregion

    #region LineaTrabajo
    public class LineaTrabajo
    {
        [Key]
        public int IDLineaTrabajo { get; set; }
        public string Nombre { get; set; }
        public string Incluye { get; set; }
        public int IDClaveTrabajo { get; set; }
    }
    #endregion

    #region RelacionFinalPrecio
    public class RelacionFinalPrecio
    {
        [Key]
        public int IDRelacion { get; set; }
        public int IDRelacionDiametro { get; set; }
        public int IDTipoMaterial { get; set; }
        public int IDExcavacion { get; set; }
        public Decimal Precio { get; set; }
        public string Descripcion { get; set; }
    }
    #endregion

    #region RelacionLineaObraTuberia
    public class RelacionLineaObraTuberia
    {
        [Key]
        public int IDRelacion { get; set; }
        public int IDLineaTrabajo { get; set; }
        public int IDTipoObra { get; set; }
        public int IDTuberia { get; set; }
        public string Tuberia { get; set; }
    }
    #endregion

    #region RelacionObraDiametro
    public class RelacionObraDiametro
    {
        [Key]
        public int IDRelacion { get; set; }
        public int IDRelacionObra { get; set; }
        public int IDDiametro { get; set; }
        public string Diametro { get; set; }
    }
    #endregion

    #region TipoMaterial
    public class TipoMaterial
    {
        [Key]
        public int IDTipoMaterial { get; set; }
        public string Nombre { get; set; }
        public string Imagen { get; set; }
    }
    #endregion

    #region TipoObra
    public class TipoObra
    {
        [Key]
        public int IDTipoObra { get; set; }
        public int IDClaveTrabajo { get; set; }
        public string Nombre { get; set; }
    }
    #endregion

    #region Tuberia
    public class Tuberia
    {
        [Key]
        public int IDTuberia { get; set; }
        public string Nombre { get; set; }
    }
    #endregion
}

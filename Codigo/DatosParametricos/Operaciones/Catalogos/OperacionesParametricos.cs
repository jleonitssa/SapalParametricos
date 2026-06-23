using DatosParametricos.Entidades;
using Microsoft.EntityFrameworkCore;

namespace DatosParametricos.Operaciones
{
    public class OperacionesParametricos
    {
        public static List<Excavacion> ExcavacionSelect(int IDExcavacion, string Nombre, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.Excavaciones.FromSql<Excavacion>($"EXEC dbo.procExcavacionSelect @IDExcavacion={IDExcavacion}, @Nombre={Nombre}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<Excavacion>().ToList();

            return respuesta;
        }

        public static List<LineaTrabajo> LineaTrabajoSelect(int IDLineaTrabajo, string Nombre, int IDClaveTrabajo, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.LineasTrabajo.FromSql<LineaTrabajo>($"EXEC dbo.procLineaTrabajoSelect @IDLineaTrabajo={IDLineaTrabajo}, @Nombre={Nombre}, @IDClaveTrabajo={IDClaveTrabajo}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<LineaTrabajo>().ToList();

            return respuesta;
        }

        public static List<RelacionFinalPrecio> RelacionFinalPrecioSelect(int IDRelacion, int IDRelacionDiametro, int IDTipoMaterial, int IDExcavacion, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.RelacionesFinalPrecio.FromSql<RelacionFinalPrecio>($"EXEC dbo.procRelacionFinalPrecioSelect @IDRelacion={IDRelacion}, @IDRelacionDiametro={IDRelacionDiametro}, @IDTipoMaterial={IDTipoMaterial}, @IDExcavacion={IDExcavacion}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<RelacionFinalPrecio>().ToList();

            return respuesta;
        }

        public static List<RelacionLineaObraTuberia> RelacionLineaObraTuberiaSelect(int IDRelacion, int IDLineaTrabajo, int IDTipoObra, int IDTuberia, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.RelacionesLineaObraTuberia.FromSql<RelacionLineaObraTuberia>($"EXEC dbo.procRelacionLineaObraTuberiaSelect @IDRelacion={IDRelacion}, @IDLineaTrabajo={IDLineaTrabajo}, @IDTipoObra={IDTipoObra}, @IDTuberia={IDTuberia}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<RelacionLineaObraTuberia>().ToList();

            return respuesta;
        }

        public static List<RelacionObraDiametro> RelacionObraDiametroSelect(int IDRelacion, int IDRelacionObra, int IDDiametro, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.RelacionesObraDiametro.FromSql<RelacionObraDiametro>($"EXEC dbo.procRelacionObraDiametroSelect @IDRelacion={IDRelacion}, @IDRelacionObra={IDRelacionObra}, @IDDiametro={IDDiametro}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<RelacionObraDiametro>().ToList();

            return respuesta;
        }

        public static List<TipoMaterial> TipoMaterialSelect(int IDTipoMaterial, string Nombre, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.TiposMaterial.FromSql<TipoMaterial>($"EXEC dbo.procTipoMaterialSelect @IDTipoMaterial={IDTipoMaterial}, @Nombre={Nombre}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<TipoMaterial>().ToList();

            return respuesta;
        }

        public static List<TipoObra> TipoObraSelect(int IDTipoObra, int IDClaveTrabajo, string Nombre, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.TiposObra.FromSql<TipoObra>($"EXEC dbo.procTipoObraSelect @IDTipoObra={IDTipoObra}, @IDClaveTrabajo={IDClaveTrabajo}, @Nombre={Nombre}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<TipoObra>().ToList();

            return respuesta;
        }
    }
}

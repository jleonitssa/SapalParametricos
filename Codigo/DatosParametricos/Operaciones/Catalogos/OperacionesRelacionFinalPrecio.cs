using DatosParametricos.Entidades;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace DatosParametricos.Operaciones
{
    public class OperacionesRelacionFinalPrecio
    {
        public static int RelacionFinalPrecioImportar(string LineaTrabajo, string TipoObra, string TipoMaterial, string Tuberia, string Diametro, string Excavacion, decimal Precio, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procRelacionFinalPrecioImportar @LineaTrabajo='{LineaTrabajo}', @TipoObra='{TipoObra}', @TipoMaterial='{TipoMaterial}', @Tuberia='{Tuberia}', @Diametro='{Diametro}', @Excavacion='{Excavacion}', @Precio={Precio}", ret);

            return (int)ret.Value;
        }

        public static List<RelacionFinalPrecio> RelacionFinalPrecioSelect(int IDRelacion, int IDRelacionDiametro, int IDTipoMaterial, int IDExcavacion, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.RelacionesFinalPrecio.FromSql<RelacionFinalPrecio>($"EXEC dbo.procRelacionFinalPrecioSelect @IDRelacion={IDRelacion}, @IDRelacionDiametro={IDRelacionDiametro}, @IDTipoMaterial={IDTipoMaterial}, @IDExcavacion={IDExcavacion}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<RelacionFinalPrecio>().ToList();

            return respuesta;
        }

        public static int RelacionFinalPrecioCount(int IDRelacion, int IDRelacionDiametro, int IDTipoMaterial, int IDExcavacion, decimal Precio, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procRelacionFinalPrecioCount @IDRelacion={IDRelacion}, @IDRelacionDiametro={IDRelacionDiametro}, @IDTipoMaterial={IDTipoMaterial}, @IDExcavacion={IDExcavacion}, @Precio={Precio}", ret);

            return (int)ret.Value;
        }

        public static int RelacionFinalPrecioDelete(int IDRelacion, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procRelacionFinalPrecioDelete @IDRelacion={IDRelacion}", ret);

            return (int)ret.Value;
        }

        public static int RelacionFinalPrecioInsert(int IDRelacionDiametro, int IDTipoMaterial, int IDExcavacion, decimal Precio, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procRelacionFinalPrecioInsert @IDRelacionDiametro={IDRelacionDiametro}, @IDTipoMaterial={IDTipoMaterial}, @IDExcavacion={IDExcavacion}, @Precio={Precio}", ret);

            return (int)ret.Value;
        }

        public static int RelacionFinalPrecioUpdate(int IDRelacion, int IDRelacionDiametro, int IDTipoMaterial, int IDExcavacion, decimal Precio, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procRelacionFinalPrecioUpdate @IDRelacion={IDRelacion}, @IDRelacionDiametro={IDRelacionDiametro}, @IDTipoMaterial={IDTipoMaterial}, @IDExcavacion={IDExcavacion}, @Precio={Precio}", ret);

            return (int)ret.Value;
        }
    }
}

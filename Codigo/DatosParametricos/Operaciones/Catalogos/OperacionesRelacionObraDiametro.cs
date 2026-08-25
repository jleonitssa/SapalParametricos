using DatosParametricos.Entidades;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace DatosParametricos.Operaciones
{
    public class OperacionesRelacionObraDiametro
    {
        public static int RelacionObraDiametroCount(int IDRelacion, int IDRelacionObra, int IDDiametro, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procRelacionObraDiametroCount @IDRelacion={IDRelacion}, @IDRelacionObra={IDRelacionObra}, @IDDiametro={IDDiametro}", ret);

            return (int)ret.Value;
        }

        public static int RelacionObraDiametroDelete(int IDRelacion, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procRelacionObraDiametroDelete @IDRelacion={IDRelacion}", ret);

            return (int)ret.Value;
        }

        public static int RelacionObraDiametroInsert(int IDRelacionObra, int IDDiametro, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procRelacionObraDiametroInsert @IDRelacionObra={IDRelacionObra}, @IDDiametro={IDDiametro}", ret);

            return (int)ret.Value;
        }

        public static List<RelacionObraDiametro> RelacionObraDiametroSelect(int IDRelacion, int IDRelacionObra, int IDDiametro, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.RelacionesObraDiametro.FromSql<RelacionObraDiametro>($"EXEC dbo.procRelacionObraDiametroSelect @IDRelacion={IDRelacion}, @IDRelacionObra={IDRelacionObra}, @IDDiametro={IDDiametro}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<RelacionObraDiametro>().ToList();

            return respuesta;
        }

        public static int RelacionObraDiametroUpdate(int IDRelacion, int IDRelacionObra, int IDDiametro, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procRelacionObraDiametroUpdate @IDRelacion={IDRelacion}, @IDRelacionObra={IDRelacionObra}, @IDDiametro={IDDiametro}", ret);

            return (int)ret.Value;
        }
    }
}

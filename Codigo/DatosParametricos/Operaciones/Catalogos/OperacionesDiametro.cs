using DatosParametricos.Entidades;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace DatosParametricos.Operaciones
{
    public class OperacionesDiametro
    {
        public static int DiametroCount(int IDDiametro, string Nombre, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procDiametroCount @IDDiametro={IDDiametro}, @Nombre='{Nombre}'", ret);

            return (int)ret.Value;
        }

        public static int DiametroDelete(int IDDiametro, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procDiametroDelete @IDDiametro={IDDiametro}", ret);

            return (int)ret.Value;
        }

        public static int DiametroInsert(string Nombre, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procDiametroInsert @Nombre='{Nombre}'", ret);

            return (int)ret.Value;
        }

        public static List<Diametro> DiametroSelect(int IDDiametro, string Nombre, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.Diametros.FromSql<Diametro>($"EXEC dbo.procDiametroSelect @IDDiametro={IDDiametro}, @Nombre={Nombre}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<Diametro>().ToList();

            return respuesta;
        }

        public static int DiametroUpdate(int IDDiametro, string Nombre, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procDiametroUpdate @IDDiametro={IDDiametro}, @Nombre='{Nombre}'", ret);

            return (int)ret.Value;
        }
    }
}

using DatosParametricos.Entidades;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace DatosParametricos.Operaciones
{
    public class OperacionesExcavacion
    {
        public static List<Excavacion> ExcavacionSelect(int IDExcavacion, string Nombre, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.Excavaciones.FromSql<Excavacion>($"EXEC dbo.procExcavacionSelect @IDExcavacion={IDExcavacion}, @Nombre={Nombre}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<Excavacion>().ToList();

            return respuesta;
        }

        public static int ExcavacionCount(int IDExcavacion, string Nombre, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procExcavacionCount @IDExcavacion={IDExcavacion}, @Nombre='{Nombre}'", ret);

            return (int)ret.Value;
        }

        public static int ExcavacionDelete(int IDExcavacion, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procExcavacionDelete @IDExcavacion={IDExcavacion}", ret);

            return (int)ret.Value;
        }

        public static int ExcavacionInsert(string Nombre, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procExcavacionInsert @Nombre='{Nombre}'", ret);

            return (int)ret.Value;
        }

        public static int ExcavacionUpdate(int IDExcavacion, string Nombre, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procExcavacionUpdate @IDExcavacion={IDExcavacion}, @Nombre='{Nombre}'", ret);

            return (int)ret.Value;
        }
    }
}

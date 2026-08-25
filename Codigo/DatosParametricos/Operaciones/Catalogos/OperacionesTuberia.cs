using DatosParametricos.Entidades;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace DatosParametricos.Operaciones
{
    public class OperacionesTuberia
    {
        public static int TuberiaCount(int IDTuberia, string Nombre, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procTuberiaCount @IDTuberia={IDTuberia}, @Nombre='{Nombre}'", ret);

            return (int)ret.Value;
        }

        public static int TuberiaDelete(int IDTuberia, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procTuberiaDelete @IDTuberia={IDTuberia}", ret);

            return (int)ret.Value;
        }

        public static int TuberiaInsert(string Nombre, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procTuberiaInsert @Nombre='{Nombre}'", ret);

            return (int)ret.Value;
        }

        public static List<Tuberia> TuberiaSelect(int IDTuberia, string Nombre, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.Tuberias.FromSql<Tuberia>($"EXEC dbo.procTuberiaSelect @IDTuberia={IDTuberia}, @Nombre={Nombre}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<Tuberia>().ToList();

            return respuesta;
        }

        public static int TuberiaUpdate(int IDTuberia, string Nombre, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procTuberiaUpdate @IDTuberia={IDTuberia}, @Nombre='{Nombre}'", ret);

            return (int)ret.Value;
        }
    }
}

using DatosParametricos.Entidades;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace DatosParametricos.Operaciones
{
    public class OperacionesLineaTrabajo
    {
        public static List<LineaTrabajo> LineaTrabajoSelect(int IDLineaTrabajo, string Nombre, int IDClaveTrabajo, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.LineasTrabajo.FromSql<LineaTrabajo>($"EXEC dbo.procLineaTrabajoSelect @IDLineaTrabajo={IDLineaTrabajo}, @Nombre={Nombre}, @IDClaveTrabajo={IDClaveTrabajo}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<LineaTrabajo>().ToList();

            return respuesta;
        }

        public static int LineaTrabajoCount(int IDLineaTrabajo, string Nombre, int IDClaveTrabajo, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procLineaTrabajoCount @IDLineaTrabajo={IDLineaTrabajo}, @Nombre='{Nombre}', @IDClaveTrabajo={IDClaveTrabajo}", ret);

            return (int)ret.Value;
        }

        public static int LineaTrabajoDelete(int IDLineaTrabajo, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procLineaTrabajoDelete @IDLineaTrabajo={IDLineaTrabajo}", ret);

            return (int)ret.Value;
        }

        public static int LineaTrabajoInsert(string Nombre, int IDClaveTrabajo, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procLineaTrabajoInsert @Nombre='{Nombre}', @IDClaveTrabajo={IDClaveTrabajo}", ret);

            return (int)ret.Value;
        }

        public static int LineaTrabajoUpdate(int IDLineaTrabajo, string Nombre, int IDClaveTrabajo, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procLineaTrabajoUpdate @IDLineaTrabajo={IDLineaTrabajo}, @Nombre='{Nombre}', @IDClaveTrabajo={IDClaveTrabajo}", ret);

            return (int)ret.Value;
        }
    }
}

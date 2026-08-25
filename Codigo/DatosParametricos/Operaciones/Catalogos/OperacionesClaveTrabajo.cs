using DatosParametricos.Entidades;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace DatosParametricos.Operaciones
{
    public class OperacionesClaveTrabajo
    {
        public static int ClaveTrabajoCount(int IDClaveTrabajo, string Clave, string Incluye, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procClaveTrabajoCount @IDClaveTrabajo={IDClaveTrabajo}, @Clave='{Clave}', @Incluye='{Incluye}'", ret);

            return (int)ret.Value;
        }

        public static int ClaveTrabajoDelete(int IDClaveTrabajo, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procClaveTrabajoDelete @IDClaveTrabajo={IDClaveTrabajo}", ret);

            return (int)ret.Value;
        }

        public static int ClaveTrabajoInsert(string Clave, string Incluye, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procClaveTrabajoInsert @Clave='{Clave}', @Incluye='{Incluye}'", ret);

            return (int)ret.Value;
        }

        public static List<ClaveTrabajo> ClaveTrabajoSelect(int IDClaveTrabajo, string Clave, string Incluye, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.ClavesTrabajo.FromSql<ClaveTrabajo>($"EXEC dbo.procClaveTrabajoSelect @IDClaveTrabajo={IDClaveTrabajo}, @Clave={Clave}, @Incluye={Incluye}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<ClaveTrabajo>().ToList();

            return respuesta;
        }

        public static int ClaveTrabajoUpdate(int IDClaveTrabajo, string Clave, string Incluye, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procClaveTrabajoUpdate @IDClaveTrabajo={IDClaveTrabajo}, @Clave='{Clave}', @Incluye='{Incluye}'", ret);

            return (int)ret.Value;
        }
    }
}

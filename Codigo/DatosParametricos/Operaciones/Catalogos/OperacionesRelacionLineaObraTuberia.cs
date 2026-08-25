using DatosParametricos.Entidades;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace DatosParametricos.Operaciones
{
    public class OperacionesRelacionLineaObraTuberia
    {
        public static int RelacionLineaObraTuberiaCount(int IDRelacion, int IDLineaTrabajo, int IDTipoObra, int IDTuberia, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procRelacionLineaObraTuberiaCount @IDRelacion={IDRelacion}, @IDLineaTrabajo={IDLineaTrabajo}, @IDTipoObra={IDTipoObra}, @IDTuberia={IDTuberia}", ret);

            return (int)ret.Value;
        }

        public static int RelacionLineaObraTuberiaDelete(int IDRelacion, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procRelacionLineaObraTuberiaDelete @IDRelacion={IDRelacion}", ret);

            return (int)ret.Value;
        }

        public static int RelacionLineaObraTuberiaInsert(int IDLineaTrabajo, int IDTipoObra, int IDTuberia, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procRelacionLineaObraTuberiaInsert @IDLineaTrabajo={IDLineaTrabajo}, @IDTipoObra={IDTipoObra}, @IDTuberia={IDTuberia}", ret);

            return (int)ret.Value;
        }

        public static List<RelacionLineaObraTuberia> RelacionLineaObraTuberiaSelect(int IDRelacion, int IDLineaTrabajo, int IDTipoObra, int IDTuberia, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.RelacionesLineaObraTuberia.FromSql<RelacionLineaObraTuberia>($"EXEC dbo.procRelacionLineaObraTuberiaSelect @IDRelacion={IDRelacion}, @IDLineaTrabajo={IDLineaTrabajo}, @IDTipoObra={IDTipoObra}, @IDTuberia={IDTuberia}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<RelacionLineaObraTuberia>().ToList();

            return respuesta;
        }

        public static int RelacionLineaObraTuberiaUpdate(int IDRelacion, int IDLineaTrabajo, int IDTipoObra, int IDTuberia, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procRelacionLineaObraTuberiaUpdate @IDRelacion={IDRelacion}, @IDLineaTrabajo={IDLineaTrabajo}, @IDTipoObra={IDTipoObra}, @IDTuberia={IDTuberia}", ret);

            return (int)ret.Value;
        }
    }
}

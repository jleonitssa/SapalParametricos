using DatosParametricos.Entidades;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace DatosParametricos.Operaciones
{
    public class OperacionesTipoObra
    {
        public static int TipoObraCount(int IDTipoObra, int IDClaveTrabajo, string Nombre, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procTipoObraCount @IDTipoObra={IDTipoObra}, @IDClaveTrabajo={IDClaveTrabajo}, @Nombre='{Nombre}'", ret);

            return (int)ret.Value;
        }

        public static int TipoObraDelete(int IDTipoObra, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procTipoObraDelete @IDTipoObra={IDTipoObra}", ret);

            return (int)ret.Value;
        }

        public static int TipoObraInsert(int IDClaveTrabajo, string Nombre, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procTipoObraInsert @IDClaveTrabajo={IDClaveTrabajo}, @Nombre='{Nombre}'", ret);

            return (int)ret.Value;
        }

        public static List<TipoObra> TipoObraSelect(int IDTipoObra, int IDClaveTrabajo, string Nombre, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.TiposObra.FromSql<TipoObra>($"EXEC dbo.procTipoObraSelect @IDTipoObra={IDTipoObra}, @IDClaveTrabajo={IDClaveTrabajo}, @Nombre={Nombre}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<TipoObra>().ToList();

            return respuesta;
        }

        public static int TipoObraUpdate(int IDTipoObra, int IDClaveTrabajo, string Nombre, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procTipoObraUpdate @IDTipoObra={IDTipoObra}, @IDClaveTrabajo={IDClaveTrabajo}, @Nombre='{Nombre}'", ret);

            return (int)ret.Value;
        }
    }
}

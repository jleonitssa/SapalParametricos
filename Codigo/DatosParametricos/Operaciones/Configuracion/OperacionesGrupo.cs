using DatosParametricos.Entidades;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace DatosParametricos.Operaciones
{
    public static class OperacionesGrupo
    {
        public static int GrupoCount(int IDGrupo, string Nombre, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysGrupoCount @IDGrupo={IDGrupo}, @Nombre='{Nombre}'", ret);

            return (int)ret.Value;
        }

        public static int GrupoDelete(int IDGrupo, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysGrupoDelete @IDGrupo={IDGrupo}", ret);

            return (int)ret.Value;
        }

        public static int GrupoInsert(string Nombre, string Descripcion, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysGrupoInsert @Nombre='{Nombre}', @Descripcion='{Descripcion}'", ret);

            return (int)ret.Value;
        }

        public static List<Grupo> GrupoSelect(int IDGrupo, string Nombre, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.Grupos.FromSql<Grupo>($"EXEC dbo.sysGrupoSelect @IDGrupo={IDGrupo}, @Nombre={Nombre}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<Grupo>().ToList();

            return respuesta;
        }

        public static int GrupoUpdate(int IDGrupo, string Nombre, string Descripcion, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysGrupoUpdate @IDGrupo={IDGrupo}, @Nombre='{Nombre}', @Descripcion='{Descripcion}'", ret);

            return (int)ret.Value;
        }
    }
}

using DatosParametricos.Entidades;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace DatosParametricos.Operaciones
{
    public class OperacionesPantalla
    {
        public static int PantallaCount(int IDPantalla, string Nombre, string Descripcion, string URL, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysPantallaCount @IDPantalla={IDPantalla}, @Nombre='{Nombre}', @Descripcion='{Descripcion}', @URL='{URL}'", ret);

            return (int)ret.Value;
        }

        public static int PantallaDelete(int IDPantalla, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysPantallaDelete @IDPantalla={IDPantalla}", ret);

            return (int)ret.Value;
        }

        public static int PantallaInsert(string Nombre, string Descripcion, string URL, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysPantallaInsert @Nombre='{Nombre}', @Descripcion='{Descripcion}', @URL='{URL}'", ret);

            return (int)ret.Value;
        }

        public static int PantallaMenu(int IDPantalla, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysPantallaMenu @IDPantalla={IDPantalla}", ret);

            return (int)ret.Value;
        }

        public static List<Pantalla> PantallaSelect(int IDPantalla, string Nombre, string Descripcion, string URL, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.Pantallas.FromSql<Pantalla>($"EXEC dbo.sysPantallaSelect @IDPantalla={IDPantalla}, @Nombre={Nombre}, @Descripcion={Descripcion}, @URL={URL}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<Pantalla>().ToList();

            return respuesta;
        }

        public static int PantallaUpdate(int IDPantalla, string Nombre, string Descripcion, string URL, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysPantallaUpdate @IDPantalla={IDPantalla}, @Nombre='{Nombre}', @Descripcion='{Descripcion}', @URL='{URL}'", ret);

            return (int)ret.Value;
        }
    }
}

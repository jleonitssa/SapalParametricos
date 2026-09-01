using DatosParametricos.Entidades;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace DatosParametricos.Operaciones
{
    public class OperacionesTipoMaterial
    {
        public static int TipoMaterialCount(int IDTipoMaterial, string Nombre, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procTipoMaterialCount @IDTipoMaterial={IDTipoMaterial}, @Nombre='{Nombre}'", ret);

            return (int)ret.Value;
        }

        public static int TipoMaterialDelete(int IDTipoMaterial, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procTipoMaterialDelete @IDTipoMaterial={IDTipoMaterial}", ret);

            return (int)ret.Value;
        }

        public static int TipoMaterialInsert(string Nombre, string Descripcion1, string Descripcion2, string Descripcion3, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procTipoMaterialInsert @Nombre='{Nombre}', @Descripcion1='{Descripcion1}', @Descripcion2='{Descripcion2}', @Descripcion3='{Descripcion3}'", ret);

            return (int)ret.Value;
        }

        public static List<TipoMaterial> TipoMaterialSelect(int IDTipoMaterial, string Nombre, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.TiposMaterial.FromSql<TipoMaterial>($"EXEC dbo.procTipoMaterialSelect @IDTipoMaterial={IDTipoMaterial}, @Nombre={Nombre}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<TipoMaterial>().ToList();

            return respuesta;
        }

        public static int TipoMaterialUpdate(int IDTipoMaterial, string Nombre, string Descripcion1, string Descripcion2, string Descripcion3, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procTipoMaterialUpdate @IDTipoMaterial={IDTipoMaterial}, @Nombre='{Nombre}', @Descripcion1='{Descripcion1}', @Descripcion2='{Descripcion2}', @Descripcion3='{Descripcion3}'", ret);

            return (int)ret.Value;
        }

        public static int TipoMaterialUpdateImagen(int IDTipoMaterial, string Imagen, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.procTipoMaterialUpdateImagen @IDTipoMaterial={IDTipoMaterial}, @Imagen='{Imagen}'", ret);

            return (int)ret.Value;
        }
    }
}

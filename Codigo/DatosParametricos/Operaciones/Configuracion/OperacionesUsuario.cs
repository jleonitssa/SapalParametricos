using DatosParametricos.Entidades;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace DatosParametricos.Operaciones
{
    public static class OperacionesUsuario
    {
        public static int UsuarioCount(int IDUsuario, string Login, string LoginExacto, string Email, string Nombre, int IDEstatus, int IDGrupo, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysUsuarioCount @IDUsuario={IDUsuario}, @Login='{Login}', @LoginExacto='{LoginExacto}', @Email='{Email}', @Nombre='{Nombre}', @IDEstatus={IDEstatus}, @IDGrupo={IDGrupo}", ret);

            return (int)ret.Value;
        }

        public static int UsuarioDelete(int IDUsuario, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysUsuarioDelete @IDUsuario={IDUsuario}", ret);

            return (int)ret.Value;
        }

        public static int UsuarioInsert(string Login, int IDGrupo, string Email, string Nombre, string Apellidos, string Password, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysUsuarioInsert @Login='{Login}', @IDGrupo={IDGrupo}, @Email='{Email}', @Nombre='{Nombre}', @Apellidos='{Apellidos}', @Password='{Password}'", ret);

            return (int)ret.Value;
        }

        public static List<Usuario> UsuarioSelect(int IDUsuario, string Login, string LoginExacto, string Email, string Nombre, int IDEstatus, int IDGrupo, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            var respuesta = context.Usuarios.FromSql<Usuario>($"EXEC dbo.sysUsuarioSelect @IDUsuario={IDUsuario}, @Login={Login}, @LoginExacto={LoginExacto}, @Email={Email}, @Nombre={Nombre}, @IDEstatus={IDEstatus}, @IDGrupo={IDGrupo}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<Usuario>().ToList();

            return respuesta;
        }

        public static int UsuarioUpdate(int IDUsuario, string Login, int IDGrupo, string Email, string Nombre, string Apellidos, int IDEstatus, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysUsuarioUpdate @IDUsuario={IDUsuario}, @Login='{Login}', @IDGrupo={IDGrupo}, @Email='{Email}', @Nombre='{Nombre}', @Apellidos='{Apellidos}', @IDEstatus={IDEstatus}", ret);

            return (int)ret.Value;
        }

        public static int UsuarioValidar(byte Operacion, int IDUsuario, string Valor, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysUsuarioValidar @Operacion={Operacion}, @IDUsuario={IDUsuario}, @Valor='{Valor}'", ret);

            return (int)ret.Value;
        }

        public static int UsuarioValidarSesion(string Login, string Pass, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysUsuarioValidarSesion @Login='{Login}', @Pass='{Pass}'", ret);

            return (int)ret.Value;
        }

        public static List<Usuario> UsuarioXPermisoSelect(string Pantalla, string Accion, ApplicationDbContext context)
        {
            var respuesta = context.Usuarios.FromSql<Usuario>($"EXEC dbo.sysUsuarioXPermisoSelect @Pantalla={Pantalla}, @Accion={Accion}").AsEnumerable<Usuario>().ToList();

            return respuesta;
        }
    }
}

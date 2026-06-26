using DatosParametricos.Entidades;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Linq;

namespace DatosParametricos.Operaciones
{
    public static class OperacionesLogSistema
    {
        public static int LogSistemaCount(int IDLogSistema, string Tipo, int IDPantalla, string FechaInicial, string FechaFinal, string Descripcion, string Usuario, string IP, string Accion, int IDUsuario, int IDGrupo, ApplicationDbContext context)
        {
            FechaFinal = Funciones.AgregarDiaFechaString(FechaFinal); 
            
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysLogSistemaCount @IDLogSistema={IDLogSistema}, @Tipo='{Tipo}', @IDPantalla={IDPantalla}, @FechaInicial='{FechaInicial}', @FechaFinal='{FechaFinal}', @Descripcion='{Descripcion}', @Usuario='{Usuario}', @IP='{IP}', @Accion='{Accion}', @IDUsuario={IDUsuario}, @IDGrupo={IDGrupo}", ret);

            return (int)ret.Value;
        }

        public static int LogSistemaInsert(int IDUsuario, string Pantalla, string Accion, string Descripcion, string Tipo, string IP, ApplicationDbContext context)
        {
            var ret = new SqlParameter { ParameterName = "Ret", SqlDbType = System.Data.SqlDbType.Int, Direction = System.Data.ParameterDirection.Output };
            var respuesta = context.Database.ExecuteSqlRaw($"EXEC @Ret = dbo.sysLogSistemaInsert @IDUsuario={IDUsuario}, @Pantalla='{Pantalla}', @Accion='{Accion}', @Descripcion='{Descripcion}', @Tipo='{Tipo}', @IP='{IP}'", ret);

            return (int)ret.Value;
        }

        public static List<LogSistema> LogSistemaSelect(int IDLogSistema, string Tipo, int IDPantalla, string FechaInicial, string FechaFinal, string Descripcion, string Usuario, string IP, string Accion, int IDUsuario, int IDGrupo, int InitRow, int EndRow, string SortColumn, string SortDir, ApplicationDbContext context)
        {
            FechaFinal = Funciones.AgregarDiaFechaString(FechaFinal);

            var respuesta = context.Logs.FromSql<LogSistema>($"EXEC dbo.sysLogSistemaSelect @IDLogSistema={IDLogSistema}, @Tipo={Tipo}, @IDPantalla={IDPantalla}, @FechaInicial={FechaInicial}, @FechaFinal={FechaFinal}, @Descripcion={Descripcion}, @Usuario={Usuario}, @IP={IP}, @Accion={Accion}, @IDUsuario={IDUsuario}, @IDGrupo={IDGrupo}, @InitRow={InitRow}, @EndRow={EndRow}, @SortColumn={SortColumn}, @SortDir={SortDir}").AsEnumerable<LogSistema>().ToList();

            return respuesta;
        }
    }
}

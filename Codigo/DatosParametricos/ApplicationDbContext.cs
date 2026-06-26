using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Microsoft.Extensions.Configuration;
using System.Text.RegularExpressions;
using System;
using DatosParametricos.Entidades;

namespace DatosParametricos
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions options) : base(options)
        {

        }

        public ApplicationDbContext(string CadenaConexion) : base(GetOptions(CadenaConexion))
        {

        }

        private static DbContextOptions GetOptions(string connectionString)
        {
            return SqlServerDbContextOptionsExtensions.UseSqlServer(new DbContextOptionsBuilder(), connectionString).Options;
        }

        public DbSet<Excavacion> Excavaciones { get; set; }
        public DbSet<Configuracion> Configs { get; set; }
        public DbSet<Grupo> Grupos { get; set; }
        public DbSet<LogSistema> Logs { get; set; }
        public DbSet<LineaTrabajo> LineasTrabajo { get; set; }
        public DbSet<Pantalla> Pantallas { get; set; }
        public DbSet<RelacionFinalPrecio> RelacionesFinalPrecio { get; set; }
        public DbSet<RelacionLineaObraTuberia> RelacionesLineaObraTuberia { get; set; }
        public DbSet<RelacionObraDiametro> RelacionesObraDiametro { get; set; }
        public DbSet<TipoMaterial> TiposMaterial { get; set; }
        public DbSet<TipoObra> TiposObra { get; set; }
        public DbSet<Usuario> Usuarios { get; set; }
    }
}

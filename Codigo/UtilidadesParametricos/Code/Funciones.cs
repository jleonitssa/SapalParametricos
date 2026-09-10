using DatosParametricos;
using DatosParametricos.Entidades;
using SeguridadCore.Code;

namespace UtilidadesParametricos
{
    public static class Funciones
    {
        public static string GenerarContrasena(int MinimoCaracteres, int MinimoCarEspecial, int MinimoMinusculas, int MinimoNumeros, int MinimoMayusculas)
        {
            return Functions.GenerarContrasena(MinimoCaracteres, MinimoCarEspecial, MinimoMinusculas, MinimoNumeros, MinimoMayusculas);
        }

        public static string ValidarContrasena(string Pass, int MinimoCaracteres, int MinimoCarEspecial, int MinimoMinusculas, int MinimoNumeros, int MinimoMayusculas)
        {
            return Functions.ValidarContrasena(Pass,
                                               MinimoCaracteres,
                                               MinimoCarEspecial,
                                               MinimoMinusculas,
                                               MinimoNumeros,
                                               MinimoMayusculas);
        }

        public static ArchivoOrden ObtenerArchivoPdf(int IDUsuario, string Titulo, string Parametros, ApplicationDbContext context, string rutaLocal)
        {
            var ruta = Path.Combine(
                Directory.GetCurrentDirectory(),
                "Archivos"
            );

            StreamReader sr = new StreamReader(Directory.GetCurrentDirectory() + "\\" + "Src\\PlantillaPresupuesto.html");

            var plantilla = sr.ReadToEnd();

            sr.Close();
            sr.Dispose();

            var usuario = DatosParametricos.Operaciones.OperacionesUsuario.UsuarioSelect(IDUsuario, "", "", "", "", 0, 0, 0, 2, "IDUsuario", "ASC", context)[0];

            List<RelacionFinalPrecio> Refs = new List<RelacionFinalPrecio>();

            foreach (string relacion in Parametros.Split("|", StringSplitOptions.RemoveEmptyEntries))
            {
                string[] Params = relacion.Split(",");

                var rel = DatosParametricos.Operaciones.OperacionesRelacionFinalPrecio.RelacionFinalPrecioSelect(int.Parse(Params[0]), 0, 0, 0, 1, 1, "", "", context)[0];

                rel.Pendiente = decimal.Parse(Params[1]);
                rel.Cantidad = decimal.Parse(Params[2]);

                Refs.Add(rel);
            }

            var res = HtmlToPdf.OrdenDeTrabajoPdf.GenerarPresupuestoPdf(plantilla, usuario, Titulo, Refs, ruta, rutaLocal);

            if (res == "OK")
            {
                byte[] fileBytes = File.ReadAllBytes(ruta + "\\" + Titulo + ".pdf");

                return new ArchivoOrden
                {
                    NombreArchivo = Titulo + ".pdf",
                    RutaArchivo = ruta + "\\" + Titulo + ".pdf",
                    BytesArchivo = fileBytes
                };
            }
            else
                throw new Exception { Source = res };
        }
    }
}

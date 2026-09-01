using APIParametricos.Code;
using APIParametricos.Dtos.Respuesta;
using APIParametricos.Dtos.Solicitud.Catalogos;
using DatosParametricos.Operaciones;
using Microsoft.AspNetCore.Mvc;

namespace APIParametricos.Controllers.Catalogos
{
    [ApiController]
    [Route("parametricos")]
    public class ParametricosController : ControllerBase
    {
        private readonly DatosParametricos.ApplicationDbContext context;

        public ParametricosController(DatosParametricos.ApplicationDbContext context)
        {
            this.context = context;
        }        

        [HttpPost]
        [Route("ActualizarParametricos")]
        public IActionResult ActualizarParametricos(IFormFile file)
        {
            string archivoSubido = new UploadHandler().Upload(file, TipoArchivo.Documento);

            RespuestaActualizacion Res = new RespuestaActualizacion() { errores = new List<MensajeError>() };

            var resXls = Funciones.LeerExcel(Path.Combine(Directory.GetCurrentDirectory(), "Archivos", archivoSubido));

            if (resXls.Count == 0)
            {
                Res.resultado = "ERROR";
                Res.errores.Add(new MensajeError { error = "El archivo no contiene datos" });
            }
            else
            {
                int Fila = 1;

                foreach (var linea in resXls)
                {
                    try
                    {
                        bool hayError = false;

                        string Linea = linea.Count > 1 ? (linea[1] ?? "") : "";
                        string Obra = linea.Count > 2 ? (linea[2] ?? "") : "";
                        string Material = linea.Count > 3 ? (linea[3] ?? "") : "";
                        string Tuberia = linea.Count > 4 ? (linea[4] ?? "") : "";
                        string Diametro = linea.Count > 5 ? (linea[5] ?? "") : "";
                        string Excavacion = linea.Count > 6 ? (linea[6] ?? "") : "";
                        string Precio = linea.Count > 7 ? (linea[7] ?? "") : "";

                        decimal precio;

                        if (Linea == "")
                        {
                            Res.errores.Add(new MensajeError { error = $"La línea de trabajo de la fila {Fila} está vacía" });
                            hayError = true;
                        }
                        if (Obra == "")
                        {
                            Res.errores.Add(new MensajeError { error = $"El tipo de obra de la fila {Fila} está vacío" });
                            hayError = true;
                        }
                        if (Material == "")
                        {
                            Res.errores.Add(new MensajeError { error = $"El tipo de material de la fila {Fila} está vacío" });
                            hayError = true;
                        }
                        if (Tuberia == "")
                        {
                            Res.errores.Add(new MensajeError { error = $"El tipo de tubería de la fila {Fila} está vacío" });
                            hayError = true;
                        }
                        if (Diametro == "")
                        {
                            Res.errores.Add(new MensajeError { error = $"El diámetro de tubería de la fila {Fila} está vacío" });
                            hayError = true;
                        }
                        if (Excavacion == "")
                        {
                            Res.errores.Add(new MensajeError { error = $"El tipo de excavación de la fila {Fila} está vacío" });
                            hayError = true;
                        }
                        if (!decimal.TryParse(Precio, out precio))
                        {
                            Res.errores.Add(new MensajeError { error = $"El precio de la fila {Fila} no es válido" });
                            hayError = true;
                        }

                        if (!hayError)
                            OperacionesRelacionFinalPrecio.RelacionFinalPrecioImportar(Linea, Obra, Material, Tuberia, Diametro, Excavacion, precio, context);
                    }
                    catch (Exception ex)
                    {
                        Res.errores.Add(new MensajeError { error = $"Error en la fila {Fila}: {ex.Message}" });
                    }

                    Fila++;
                }

                if (Res.errores.Count == 0)
                    Res.resultado = "OK";
                else
                    Res.resultado = "ERROR";
            }

            return Ok(Res);
        }
    }
}
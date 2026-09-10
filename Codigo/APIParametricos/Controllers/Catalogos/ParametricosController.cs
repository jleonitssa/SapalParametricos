using APIParametricos.Code;
using APIParametricos.Dtos.Respuesta;
using ClosedXML.Excel;
using DatosParametricos.Operaciones;
using DocumentFormat.OpenXml.Spreadsheet;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.StaticFiles;

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

                        string Linea = linea.Count > 0 ? (linea[0] ?? "") : "";
                        string Material = linea.Count > 1 ? (linea[1] ?? "") : "";
                        string Obra = linea.Count > 2 ? (linea[2] ?? "") : "";
                        string Tuberia = linea.Count > 3 ? (linea[3] ?? "") : "";
                        string Diametro = linea.Count > 4 ? (linea[4] ?? "") : "";
                        string Excavacion = linea.Count > 5 ? (linea[5] ?? "") : "";
                        string Precio = linea.Count > 5 ? (linea[6] ?? "") : "";

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

        [HttpGet("DescargarParametricos")]
        public IActionResult Get()
        {
            var ruta = Path.Combine(
                Directory.GetCurrentDirectory(),
                "Archivos",
                "ParametricosActuales.xlsx"
            );

            List<DatosParametricos.Entidades.RelacionFinalPrecio> res = OperacionesRelacionFinalPrecio.RelacionFinalPrecioSelect(0, 0, 0, 0, 1, 100000, "", "", context);

            if(System.IO.File.Exists(ruta))
                System.IO.File.Delete(ruta);

            using (var workbook = new XLWorkbook())
            {
                var ws = workbook.Worksheets.Add("Datos Parametros");
                var fila = 2;

                var rowData = new List<object[]> { new object[] { "Línea de Trabajo", "Tipo de Material", "Tipo de Obra", "Tipo de Tubería", "Diámetro de Tubería", "Excavación", "Precio por m" } };

                ws.Cell("A1").InsertData(rowData);

                foreach (var reg in res)
                {
                    rowData = new List<object[]> { new object[] { reg.LineaTrabajo, reg.TipoMaterial, reg.TipoObra, reg.Tuberia, reg.Diametro, reg.Excavacion, reg.Precio } };

                    ws.Cell("A" + fila.ToString()).InsertData(rowData);

                    fila++;
                }

                workbook.SaveAs(ruta);
            }

            byte[] fileBytes = System.IO.File.ReadAllBytes(ruta);

            var provider = new FileExtensionContentTypeProvider();

            if (!provider.TryGetContentType("ParametricosActuales.xlsx", out string mimeType))
            {
                mimeType = "application/octet-stream";
            }

            return File(fileBytes, mimeType);
        }
    }
}
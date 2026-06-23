using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.StaticFiles;

namespace APIParametricos.Controllers.Utilidades
{
    [ApiController]
    [Route("files")]
    public class FileController : ControllerBase
    {
        private readonly DatosParametricos.ApplicationDbContext context;
        private readonly IConfiguration configuration;

        public FileController(DatosParametricos.ApplicationDbContext context, IConfiguration configuration)
        {
            this.context = context;
            this.configuration = configuration;
        }

        [HttpPost]
        [Route("UploadFile")]
        public IActionResult UploadFile(IFormFile file)
        {
            return Ok(new UploadHandler().Upload(file));
        }

        [HttpGet("DownloadFile/{Archivo}")]
        public IActionResult Get(string Archivo)
        {
            var ruta = Path.Combine(
                Directory.GetCurrentDirectory(),
                "Imagenes",
                Archivo
            );

            if (!System.IO.File.Exists(ruta))
                return NotFound();

            byte[] fileBytes = System.IO.File.ReadAllBytes(ruta);

            var provider = new FileExtensionContentTypeProvider();

            if (!provider.TryGetContentType(Archivo, out string mimeType))
            {
                mimeType = "application/octet-stream";
            }

            return File(fileBytes, mimeType);
        }
    }
}
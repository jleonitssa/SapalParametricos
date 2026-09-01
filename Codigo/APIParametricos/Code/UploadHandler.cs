namespace APIParametricos
{
    public class UploadHandler
    {
        public string Upload(IFormFile file, TipoArchivo tipoArchivo)
        {
            string archivo = Guid.NewGuid().ToString() + file.FileName;

            string path = "";

            if (tipoArchivo == TipoArchivo.Imagen)
                path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "imagenes");
            else
                path = Path.Combine(Directory.GetCurrentDirectory(), "Archivos");

            FileStream stream = new FileStream(Path.Combine(path, archivo), FileMode.Create);
            file.CopyTo(stream);
            stream.Dispose();
            stream.Close();

            return archivo;
        }
    }
}

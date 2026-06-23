namespace APIParametricos
{
    public class UploadHandler
    {
        public string Upload(IFormFile file)
        {
            string archivo = Guid.NewGuid().ToString() + file.FileName;
            string path = Path.Combine(Directory.GetCurrentDirectory(), "Imagenes");
            FileStream stream = new FileStream(Path.Combine(path, archivo), FileMode.Create);
            file.CopyTo(stream);
            stream.Dispose();
            stream.Close();

            return archivo;
        }
    }
}

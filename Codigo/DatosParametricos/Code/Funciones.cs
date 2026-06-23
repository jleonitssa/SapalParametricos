namespace DatosParametricos
{
    public static class Funciones
    {
        public static string? AgregarDiaFechaString(string? Fecha)
        {
            return AgregarDiaFechaString(Fecha, 1);
        }

        public static string? AgregarDiaFechaString(string? Fecha, int Dias)
        {
            if (string.IsNullOrWhiteSpace(Fecha))
                return Fecha;
            else
                return DateTime.Parse(Fecha).AddDays(Dias).ToString("yyyy-MM-dd");
        }
    }
}

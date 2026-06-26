using ExcelDataReader;
using System.Data;

namespace APIParametricos.Code
{
    public static class Funciones
    {
        public static List<List<string>> LeerExcel(string Archivo)
        {
            List<List<string>> list = new List<List<string>>();

            System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);

            string filePath = Archivo;

            using (var stream = File.Open(filePath, FileMode.Open, FileAccess.Read))
            {
                using (var reader = ExcelReaderFactory.CreateReader(stream))
                {
                    // Configuration to automatically use the first row as column headers
                    var config = new ExcelDataSetConfiguration()
                    {
                        ConfigureDataTable = (_) => new ExcelDataTableConfiguration()
                        {
                            UseHeaderRow = true
                        }
                    };

                    // Load the entire file into a DataSet
                    DataSet result = reader.AsDataSet(config);

                    // Grab the first worksheet
                    DataTable table = result.Tables[0];

                    // Loop through rows and columns
                    foreach (DataRow row in table.Rows)
                    {
                        List<string> fila = new List<string>();

                        foreach (DataColumn col in table.Columns)                        
                            fila.Add((row[col] ?? "").ToString());
                        
                        list.Add(fila);
                    }
                }
            }

            return list;
        }
    }
}

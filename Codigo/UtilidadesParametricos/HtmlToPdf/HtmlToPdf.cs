using DatosParametricos.Entidades;
using PuppeteerSharp;
using PuppeteerSharp.Media;

namespace UtilidadesParametricos.HtmlToPdf
{
    public class OrdenDeTrabajoPdf
    {
        public static string GenerarPresupuestoPdf(string Plantilla, Usuario Usr, string NombreProyecto, List<RelacionFinalPrecio> Ejercs, string Ruta, string UrlServidor)
        {
            return GenerarPdf(Plantilla, Usr, NombreProyecto, Ejercs, Ruta, UrlServidor).Result;
        }

        async static Task<string> GenerarPdf(string Plantilla, Usuario Usr, string NombreProyecto, List<RelacionFinalPrecio> Ejercs, string Ruta, string UrlServidor)
        {
            try
            {
                Plantilla = GenerarHtmlPdf(Plantilla, Usr, NombreProyecto, Ejercs, UrlServidor);
                Plantilla = Plantilla.Replace("{{UrlServidor}}", UrlServidor);

                var browserFetcher = new BrowserFetcher();                
                var downloadInfo = await browserFetcher.DownloadAsync();

                using var browser = await Puppeteer.LaunchAsync(new LaunchOptions { Headless = true, ExecutablePath = downloadInfo.GetExecutablePath() });

                using var page = await browser.NewPageAsync();
                await page.SetContentAsync(Plantilla);
                var result = await page.GetContentAsync();

                await page.PdfAsync(Ruta + "\\" + NombreProyecto + ".pdf", new PdfOptions
                {
                    Format = PaperFormat.A4,
                    DisplayHeaderFooter = true,
                    MarginOptions = new MarginOptions
                    {
                        Top = "20px",
                        Right = "20px",
                        Bottom = "40px",
                        Left = "20px"
                    },
                    FooterTemplate = "<div id=\"footer-template\" style=\"font-size:10px !important; color:#808080; padding-left:10px\">Footer Text</div>"
                });

                return "OK";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        static string GenerarHtmlPdf(string Plantilla, Usuario Usr, string NombreProyecto, List<RelacionFinalPrecio> Rels, string UrlServidor)
        {
            Plantilla = Plantilla.Replace("{{Fecha}}", DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss"));
            Plantilla = Plantilla.Replace("{{NombreProyecto}}", NombreProyecto);
            Plantilla = Plantilla.Replace("{{Usuario}}", Usr.NombreCompleto);

            decimal Subtotal = 0;

            string Ejes = "";

            foreach (var item in Rels)
            {
                Ejes += "\r\n<tr><td style=\"font-size: 9.5pt;\">&nbsp;</td>" +
                                "<td style=\"font-size: 9.5pt;\">" + item.Descripcion + "</td>" +
                                "<td style=\"font-size: 9.5pt;\">&nbsp;</td>" +
                                "<td style=\"font-size: 9.5pt; text-align: right;\">" + item.Cantidad.ToString("N2") + "</td>" +
                                "<td style=\"font-size: 9.5pt; text-align: right;\">" + (item.Precio * (1 + (item.Pendiente / 100))).ToString("C2") + "</td>" +
                                "<td style=\"font-size: 9.5pt; text-align: right;\">" + (item.Precio * (1 + (item.Pendiente / 100)) * item.Cantidad).ToString("C2") + "</td></tr>";

                Subtotal += (item.Precio * (1 + (item.Pendiente / 100)) * item.Cantidad);
            }

            Plantilla = Plantilla.Replace("{{Ejercicios}}", Ejes);

            Plantilla = Plantilla.Replace("{{Subtotal}}", Subtotal.ToString("C2"));
            Plantilla = Plantilla.Replace("{{IVA}}", (Subtotal * (decimal)0.16).ToString("C2"));
            Plantilla = Plantilla.Replace("{{Total}}", (Subtotal * (decimal)1.16).ToString("C2"));

            Plantilla = Plantilla.Replace("{{SubtotalLetra}}", SeguridadCore.Code.ClaseNumeroATexto.ConvertirNumero(Subtotal.ToString(), "PESOS", "M.N."));
            Plantilla = Plantilla.Replace("{{TotalLetra}}", SeguridadCore.Code.ClaseNumeroATexto.ConvertirNumero(Math.Round(Subtotal * (decimal)1.16, 2).ToString(), "PESOS", "M.N."));

            return Plantilla;
        }
    }
}

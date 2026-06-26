using APIParametricos.Dtos.Respuesta;
using APIParametricos.Dtos.Solicitud.Configuracion;
using Microsoft.AspNetCore.Mvc;

namespace APIParametricos.Controllers.Configuracion
{
    [ApiController]
    [Route("pantalla")]
    public class PantallaController : Controller
    {
        private readonly DatosParametricos.ApplicationDbContext context;

        public PantallaController(DatosParametricos.ApplicationDbContext context)
        {
            this.context = context;
        }

        [HttpPost]
        [Route("PantallaCount")]
        public Respuesta PantallaCount(reqPantallaCount sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesPantalla.PantallaCount(sol.IDPantalla, sol.Nombre, sol.Descripcion, sol.URL, context);

                Resp = new Respuesta
                {
                    Codigo = 1,
                    Resultado = res,
                    Mensaje = "",
                    Descripcion = ""
                };
            }
            catch (Exception ex)
            {
                Resp = new Respuesta
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("PantallaDelete")]
        public Respuesta PantallaDelete(reqPantallaDelete sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesPantalla.PantallaDelete(sol.IDPantalla, context);

                Resp = new Respuesta
                {
                    Codigo = 1,
                    Resultado = res,
                    Mensaje = "",
                    Descripcion = ""
                };
            }
            catch (Exception ex)
            {
                Resp = new Respuesta
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace
                };
            }

            return Resp;
        }


        [HttpPost]
        [Route("PantallaInsert")]
        public Respuesta PantallaInsert(reqPantallaInsert sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesPantalla.PantallaInsert(sol.Nombre, sol.Descripcion, sol.URL, context);

                if (res > 0)
                {
                    Resp = new Respuesta
                    {
                        Codigo = 1,
                        Resultado = res,
                        Mensaje = "",
                        Descripcion = ""
                    };
                }
                else
                {
                    Resp = new Respuesta
                    {
                        Codigo = res,
                        Resultado = res,
                        Mensaje = res == -2 ? "La pantalla ingresada ya existe" : "La URL ingresada ya existe",
                        Descripcion = ""
                    };
                }
            }
            catch (Exception ex)
            {
                Resp = new Respuesta
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("PantallaMenu")]
        public Respuesta PantallaMenu(reqPantallaMenu sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesPantalla.PantallaMenu(sol.IDPantalla, context);

                Resp = new Respuesta
                {
                    Codigo = 1,
                    Resultado = res,
                    Mensaje = "",
                    Descripcion = ""
                };
            }
            catch (Exception ex)
            {
                Resp = new Respuesta
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("PantallaSelect")]
        public RespuestaPantalla PantallaSelect(reqPantallaSelect sol)
        {
            RespuestaPantalla Resp;

            try
            {
                List<DatosParametricos.Entidades.Pantalla> res = DatosParametricos.Operaciones.OperacionesPantalla.PantallaSelect(sol.IDPantalla, sol.Nombre, sol.Descripcion, sol.URL, sol.InitRow, sol.EndRow, sol.SortColumn, sol.SortDir, context);

                Resp = new RespuestaPantalla
                {
                    Codigo = 1,
                    Resultado = 1,
                    Mensaje = "",
                    Descripcion = "",
                    Pantallas = res
                };
            }
            catch (Exception ex)
            {
                Resp = new RespuestaPantalla
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace,
                    Pantallas = new List<DatosParametricos.Entidades.Pantalla>()
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("PantallaUpdate")]
        public Respuesta PantallaUpdate(reqPantallaUpdate sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesPantalla.PantallaUpdate(sol.IDPantalla, sol.Nombre, sol.Descripcion, sol.URL, context);

                if (res > 0)
                {
                    Resp = new Respuesta
                    {
                        Codigo = 1,
                        Resultado = res,
                        Mensaje = "",
                        Descripcion = ""
                    };
                }
                else
                {
                    Resp = new Respuesta
                    {
                        Codigo = res,
                        Resultado = res,
                        Mensaje = res == -2 ? "La pantalla ingresada ya existe" : "La URL ingresada ya existe",
                        Descripcion = ""
                    };
                }

            }
            catch (Exception ex)
            {
                Resp = new Respuesta
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace
                };
            }

            return Resp;
        }
    }
}

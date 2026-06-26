using APIParametricos.Dtos.Respuesta;
using APIParametricos.Dtos.Solicitud.Configuracion;
using DatosParametricos.Operaciones;
using Microsoft.AspNetCore.Mvc;

namespace APIParametricos.Controllers.Configuracion
{
    [ApiController]
    [Route("usuario")]
    public class UsuarioController : ControllerBase
    {
        private readonly DatosParametricos.ApplicationDbContext context;
        private readonly IConfiguration configuration;

        public UsuarioController(DatosParametricos.ApplicationDbContext context, IConfiguration configuration)
        {
            this.context = context;
            this.configuration = configuration;
        }

        [HttpPost]
        [Route("UsuarioCount")]
        public Respuesta UsuarioCount(reqUsuarioCount sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesUsuario.UsuarioCount(sol.IDUsuario, sol.Login, sol.LoginExacto, sol.Email, sol.Nombre, sol.IDEstatus, sol.IDGrupo, context);

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
        [Route("UsuarioDelete")]
        public Respuesta UsuarioDelete(reqUsuarioDelete sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesUsuario.UsuarioDelete(sol.IDUsuario, context);

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
        [Route("UsuarioInsert")]
        public Respuesta UsuarioInsert(reqUsuarioInsert sol)
        {
            Respuesta Resp;

            try
            {
                DatosParametricos.Entidades.Configuracion conf = OperacionesConfiguracion.ConfiguracionSelect(context)[0];

                string Contras = "";

                if (sol.Login.Substring(0, 1).ToLower() == "s")
                    Contras = sol.Login.Substring(1);
                else
                    Contras = "963852";

                int res = OperacionesUsuario.UsuarioInsert(sol.Login, sol.IDGrupo, sol.Email, sol.Nombre, sol.Apellidos, Contras, context);

                string mensaje = conf.CorreoBienvenida.Replace("{{Usuario}}", sol.Login).Replace("{{Contrasena}}", Contras);

                Resp = new Respuesta
                {
                    Codigo = 1,
                    Resultado = res,
                    Mensaje = res > 0 ? "" : res == -2 ? "El correo electrónico ya está registrado" : "El no. de empleado/usuario ya está registrado",
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
        [Route("UsuarioSelect")]
        public RespuestaUsuario UsuarioSelect(reqUsuarioSelect sol)
        {
            RespuestaUsuario Resp;

            try
            {
                List<DatosParametricos.Entidades.Usuario> res = DatosParametricos.Operaciones.OperacionesUsuario.UsuarioSelect(sol.IDUsuario, sol.Login, sol.LoginExacto, sol.Email, sol.Nombre, sol.IDEstatus, sol.IDGrupo, sol.InitRow, sol.EndRow, sol.SortColumn, sol.SortDir, context);

                Resp = new RespuestaUsuario
                {
                    Codigo = 1,
                    Resultado = 1,
                    Mensaje = "",
                    Descripcion = "",
                    Usuarios = res
                };
            }
            catch (Exception ex)
            {
                Resp = new RespuestaUsuario
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace,
                    Usuarios = new List<DatosParametricos.Entidades.Usuario>()
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("UsuarioUpdate")]
        public Respuesta UsuarioUpdate(reqUsuarioUpdate sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesUsuario.UsuarioUpdate(sol.IDUsuario, sol.Login, sol.IDGrupo, sol.Email, sol.Nombre, sol.Apellidos, sol.IDEstatus, context);

                Resp = new Respuesta
                {
                    Codigo = 1,
                    Resultado = res,
                    Mensaje = res > 0 ? "" : "El correo electrónico ya está registrado",
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
        [Route("UsuarioValidar")]
        public Respuesta UsuarioValidar(reqUsuarioValidar sol)
        {
            Respuesta Resp;

            try
            {
                int res = DatosParametricos.Operaciones.OperacionesUsuario.UsuarioValidar(sol.Operacion, sol.IDUsuario, sol.Valor, context);

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
        [Route("UsuarioXPermisoSelect")]
        public RespuestaUsuario UsuarioXPermisoSelect(reqUsuarioXPermisoSelect sol)
        {
            RespuestaUsuario Resp;

            try
            {
                List<DatosParametricos.Entidades.Usuario> res = DatosParametricos.Operaciones.OperacionesUsuario.UsuarioXPermisoSelect(sol.Pantalla, sol.Accion, context);

                Resp = new RespuestaUsuario
                {
                    Codigo = 1,
                    Resultado = 1,
                    Mensaje = "",
                    Descripcion = "",
                    Usuarios = res
                };
            }
            catch (Exception ex)
            {
                Resp = new RespuestaUsuario
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace,
                    Usuarios = new List<DatosParametricos.Entidades.Usuario>()
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("UsuarioValidarSesion")]
        public RespuestaUsuario UsuarioValidarSesion(reqUsuarioValidarSesion sol)
        {
            RespuestaUsuario Resp;

            try
            {
                int res = OperacionesUsuario.UsuarioValidarSesion(sol.Login, sol.Pass, context);

                Resp = new RespuestaUsuario
                {
                    Codigo = 1,
                    Resultado = 1,
                    Mensaje = "",
                    Descripcion = "",
                    Usuarios = new List<DatosParametricos.Entidades.Usuario>()
                };

                if (res < 0)
                {
                    Resp.Resultado = -2;
                    Resp.Mensaje = "Usuario o contraseña inválidos";
                }
                else
                {
                    var usrs = OperacionesUsuario.UsuarioSelect(res, "", "", "", "", 0, 0, 1, 1, "Login", "ASC", context);

                    Resp.Usuarios = usrs;

                    if (usrs[0].IDEstatus == 3)
                    {
                        Resp.Resultado = -3;
                        Resp.Mensaje = "Usuario bloqueado";
                    }
                }
            }
            catch (Exception ex)
            {
                Resp = new RespuestaUsuario
                {
                    Codigo = -1,
                    Resultado = -1,
                    Mensaje = ex.Message,
                    Descripcion = ex.StackTrace,
                    Usuarios = new List<DatosParametricos.Entidades.Usuario>()
                };
            }

            return Resp;
        }

        [HttpPost]
        [Route("UsuarioCambiarContrasena")]
        public Respuesta UsuarioCambiarContrasena(reqUsuarioCambiarContrasena sol)
        {
            Respuesta Resp;

            try
            {
                Resp = new Respuesta
                {
                    Codigo = 1,
                    Resultado = 1,
                    Mensaje = "",
                    Descripcion = ""
                };

                int res = DatosParametricos.Operaciones.OperacionesUsuario.UsuarioValidar(5, sol.IDUsuario, sol.Pass, context);
                Resp.Resultado = res;
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
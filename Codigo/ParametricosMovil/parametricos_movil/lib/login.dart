import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import 'parametricos_api.dart';
import 'usuarioGlobal.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'usuarioGlobal.dart' as usuario;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ParametricosApi apiService = ParametricosApi();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  String? errorMessage;
  bool _isLoading = true;
  bool _isLoggingIn = false;

  @override
  void initState() {
    super.initState();
    _tryAutoLogin(); 
  }

  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_login', _userController.text);
    await prefs.setString('saved_pass', _passController.text);
  }

  Future<Map<String, String?>> _loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('saved_login');
    final pass = prefs.getString('saved_pass');
    return {'login': login, 'pass': pass};
  }

  Future<void> _tryAutoLogin() async {
    final credentials = await _loadCredentials();
    final savedLogin = credentials['login'];
    final savedPass = credentials['pass'];

    if (savedLogin == null || savedPass == null) {
      setState(() => _isLoading = false);
      return;
    }

    Map<String, dynamic> listaDatosInicioSesion = await apiService
        .inicioDeSesion(
          login: savedLogin,
          pass: savedPass,
        );

    if (listaDatosInicioSesion["resultado"] == 1) {
      final usuario = listaDatosInicioSesion;
      Provider.of<UsuarioProvider>(context, listen: false).setUsuario(usuario);
      
      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted) {
            context.go('/inicio');
        }
      });
    } else {
      await usuario.UsuarioProvider().clearCredentials();
      setState(() => _isLoading = false);
    }
  }

  Future<void> _login() async {
    Map<String, dynamic> listaDatosInicioSesion = await apiService
        .inicioDeSesion(
          login: _userController.text,
          pass: _passController.text,
        );

    if (listaDatosInicioSesion["resultado"] == 1) {
      final usuario = listaDatosInicioSesion;

      await _saveCredentials();

      Provider.of<UsuarioProvider>(context, listen: false).setUsuario(usuario);

      setState(() => _isLoggingIn = true);

      Future.delayed(const Duration(milliseconds: 400), () {
        context.go('/inicio');
      });
    } else {
      setState(() {
        errorMessage = listaDatosInicioSesion["mensaje"].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: azulOscuro,
        body: Center(
          child: CircularProgressIndicator(color: azulMedio),
        ),
      );
    }

    return Scaffold(
      backgroundColor: azulOscuro,
      // 🛡️ Opcional: Evita que el teclado mueva drásticamente los elementos del Stack hacia arriba si prefieres que se superponga
      resizeToAvoidBottomInset: true, 
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/fondo.jpg", fit: BoxFit.cover),
          ),

          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: _isLoggingIn
                  ? const SizedBox.shrink()
                  : ClipRRect(
                      key: const ValueKey("loginForm"),
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          width: 330,
                          // 🚀 CAMBIO 1: Eliminamos 'height: 480' y usamos constraints para dar flexibilidad dinámica
                          constraints: const BoxConstraints(
                            minHeight: 440, // Altura base inicial ideal para cuando no hay errores
                          ),
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: azulClaro.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: blancoSuave.withOpacity(0.4),
                              width: 0.5,
                            ),
                          ),
                          // 🚀 CAMBIO 2: Envolvemos la Column en un scroll para blindar la UI ante textos dinámicos largos
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 90, 
                                  child: Image.asset(
                                    "assets/favicon.png", 
                                    fit: BoxFit.contain, 
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "Iniciar Sesión",
                                  style: TextStyle(
                                    color: blancoSuave,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                TextField(
                                  controller: _userController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: "Usuario",
                                    labelStyle: TextStyle(color: azulClaro),
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color: azulClaro,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: azulClaro),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: azulMedio),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextField(
                                  controller: _passController,
                                  obscureText: true,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: "Contraseña",
                                    labelStyle: TextStyle(color: azulClaro),
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: azulClaro,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: azulClaro),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: azulMedio),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                if (errorMessage != null) ...[
                                  Text(
                                    errorMessage!,
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                ],

                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: azulMedio,
                                    foregroundColor: blancoSuave,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    minimumSize: const Size.fromHeight(45),
                                  ),
                                  onPressed: _login,
                                  child: const Text("Iniciar Sesión"),
                                ),

                                const SizedBox(height: 14),
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Si aún no tiene una cuenta, contacte al administrador",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: azulClaro),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

const Color azulOscuro = Color(0xFF0A1931); 
const Color azulProfundo = Color(0xFF1A3D63); 
const Color azulMedio = Color(0xFF4A7FA7); 
const Color azulClaro = Color(0xFFB3CFE5); 
const Color blancoSuave = Color(0xFFF6FAFD);
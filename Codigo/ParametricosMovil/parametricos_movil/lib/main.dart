import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'calculadora.dart';
import 'login.dart';
import 'usuarioGlobal.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UsuarioProvider())],
      child: const ParametricosApp(),
    ),
  );
}

class ParametricosApp extends StatelessWidget {
  const ParametricosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Parametricos App',
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: const ColorScheme.light(
          primary: Color(0xFF003D71),
          onPrimary: Colors.white,

          primaryContainer: Color(0xFFDCEAF5),
          onPrimaryContainer: Color(0xFF002A4E),

          secondary: Color(0xFF1769AA),
          onSecondary: Colors.white,

          surface: Color(0xFFF7F9FC),
          onSurface: Color(0xFF172033),

          error: Color(0xFFB3261E),
          onError: Colors.white,

          outline: Color(0xFFD4DAE3),
          outlineVariant: Color(0xFFE4E8EE),
        ),

        scaffoldBackgroundColor: const Color(0xFFF1F4F8),

        // =========================================================
        // CURSOR Y SELECCIÓN DE TEXTO
        // =========================================================
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF003D71),
          selectionColor: Color(0x403D71FF),
          selectionHandleColor: Color(0xFF003D71),
        ),

        // =========================================================
        // INPUTS
        // =========================================================
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,

          labelStyle: const TextStyle(
            color: Color(0xFF667085),
          ),

          floatingLabelStyle: const TextStyle(
            color: Color(0xFF003D71),
            fontWeight: FontWeight.w600,
          ),

          hintStyle: const TextStyle(
            color: Color(0xFF98A2B3),
          ),

          prefixIconColor: const Color(0xFF667085),
          suffixIconColor: const Color(0xFF667085),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFD4DAE3),
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFD4DAE3),
              width: 1,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF003D71),
              width: 2,
            ),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFB3261E),
            ),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFB3261E),
              width: 2,
            ),
          ),
        ),

        // =========================================================
        // DIALOG
        // =========================================================
        dialogTheme: DialogThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 8,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),

          titleTextStyle: const TextStyle(
            color: Color(0xFF003D71),
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),

          contentTextStyle: const TextStyle(
            color: Color(0xFF4F5B6B),
            fontSize: 14,
          ),
        ),

        // =========================================================
        // TEXT BUTTON
        // "CANCELAR"
        // =========================================================
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF003D71),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // =========================================================
        // ELEVATED BUTTON
        // "GUARDAR"
        // =========================================================
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF003D71),
            foregroundColor: Colors.white,
            elevation: 0,

            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),

            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: _router, 
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/inicio',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const MainLayout(paginaSeleccionada: 0),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        );
      },
    ),
    GoRoute(
      path: '/calculadora',
      builder: (context, state) => const MainLayout(paginaSeleccionada: 1),
    ),
  ],
);

class MainLayout extends StatefulWidget {
  final int paginaSeleccionada;
  const MainLayout({super.key, required this.paginaSeleccionada});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    ConstruccionScreen(),
/*     inspecciones.HomeScreen(),
    inspeccionesSinViaje.HomeScreen(), */
  ];

  static const int _logoutIndex = 1;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.paginaSeleccionada;
  }

  void _logout() {
    Provider.of<UsuarioProvider>(context, listen: false).logout();
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _currentIndex < _pages.length ? _pages[_currentIndex] : Container(),
      bottomNavigationBar: _buildBlurBottomBar(),
    );
  }

  Widget _buildBlurBottomBar() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 30),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: const Color(0xFF003D71),
            border: const Border(
              top: BorderSide(color: Colors.white24, width: 0.5),
            ),
          ),
          child: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              if (index == _logoutIndex) {
                _logout();
              } else {
                setState(() => _currentIndex = index);
              }
            },
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.calculate_outlined),
                title: const Text("Calculadora"),
                selectedColor: Color.fromARGB(255, 223, 229, 243),
                unselectedColor: Colors.white70,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.logout),
                title: const Text("Cerrar Sesión"),
                selectedColor: Colors.redAccent,
                unselectedColor: Colors.white70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
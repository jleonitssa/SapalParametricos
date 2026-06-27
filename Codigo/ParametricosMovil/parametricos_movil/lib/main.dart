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
/*       theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color(0xFF0A1931),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0A1931),
          brightness:
              Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(
            0xFFF1F4F8,
          ),
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system, */
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
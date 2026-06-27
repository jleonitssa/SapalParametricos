import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioProvider extends ChangeNotifier {
  Map<String, dynamic>? _usuario;

  Map<String, dynamic>? get usuario => _usuario;

  void setUsuario(Map<String, dynamic> nuevoUsuario) {
    _usuario = nuevoUsuario;
    print('USUARIO SETEADO: $_usuario');
    notifyListeners(); 
  }

  Future<void> clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_login');
    await prefs.remove('saved_pass');
    _usuario = null; 
    notifyListeners();
  }

  void logout() async {
    await clearCredentials();
  }
}

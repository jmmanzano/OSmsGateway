import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  int get puerto {
    return _prefs.getInt('puerto') ?? 8080;
  }

  set puerto(int puerto) {
    _prefs.setInt('puerto', puerto);
  }

  int get timeout {
    return _prefs.getInt('timeout') ?? 500;
  }

  set timeout(int timeout) {
    _prefs.setInt('timeout', timeout);
  }

  bool get temaOscuro {
    return _prefs.getBool('temaOscuro') ?? false;
  }

  set temaOscuro(bool temaOscuro) {
    _prefs.setBool('temaOscuro', temaOscuro);
  }

  bool get secure {
    return _prefs.getBool('secure') ?? false;
  }

  set secure(bool secure) {
    _prefs.setBool('secure', secure);
  }

  String get serverChain {
    return _prefs.getString('serverChain') ?? '';
  }

  set serverChain(String serverChain) {
    _prefs.setString('serverChain', serverChain);
  }

  String get serverKey {
    return _prefs.getString('serverKey') ?? '';
  }

  set serverKey(String serverKey) {
    _prefs.setString('serverKey', serverKey);
  }
}

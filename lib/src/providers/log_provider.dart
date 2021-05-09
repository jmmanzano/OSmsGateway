import 'package:flutter/widgets.dart';

class LogProvider extends ChangeNotifier {
  String _log = '';

  void escribirLog(String texto) {
    DateTime _now = DateTime.now();
    String time =
        '${_now.day}/${_now.month}/${_now.year} ${_now.hour}:${_now.minute}:${_now.second} => ';
    _log += time + texto + '\n';
    notifyListeners();
  }

  String getLog() {
    return _log;
  }

  void limpiarLog() {
    _log = '';
  }
}

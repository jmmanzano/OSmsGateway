import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:osmsgateway/src/pages/home_page.dart';
import 'package:osmsgateway/src/pages/prefs_page.dart';
import 'package:osmsgateway/src/prefs/prefs.dart';
import 'package:osmsgateway/src/providers/log_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LicenseRegistry.addLicense(() async* {
      yield LicenseEntryWithLineBreaks(['OSMSGateway'], await _getLicense());
    });
    final PreferenciasUsuario preferenciasUsuario = new PreferenciasUsuario();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LogProvider>(
            create: (context) => new LogProvider())
      ],
      child: MaterialApp(
        theme: preferenciasUsuario.temaOscuro
            ? ThemeData.dark()
            : ThemeData.light(),
        debugShowCheckedModeBanner: false,
        title: 'OSMSGateWay',
        initialRoute: 'home',
        routes: {
          'home': (context) => HomePage(),
          'prefs': (context) => PrefsPage(),
        },
      ),
    );
  }

  Future<String> _getLicense() async {
    return await rootBundle.loadString('lib/src/static/license');
  }
}

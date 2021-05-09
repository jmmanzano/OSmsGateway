import 'dart:io';

import 'package:flutter/material.dart';
import 'package:osmsgateway/src/prefs/prefs.dart';
import 'package:osmsgateway/src/utils/utils.dart' as utils;
import 'package:file_picker/file_picker.dart';

class PrefsPage extends StatefulWidget {
  PrefsPage({Key? key}) : super(key: key);

  @override
  _PrefsPageState createState() => _PrefsPageState();
}

class _PrefsPageState extends State<PrefsPage> {
  PreferenciasUsuario preferencias = PreferenciasUsuario();
  final formKey = GlobalKey<FormState>();
  TextEditingController? _textController;
  int _port = 8080;
  bool _temaOscuro = false;
  bool _isHttps = false;
  @override
  void initState() {
    super.initState();
    _port = preferencias.puerto;
    _temaOscuro = preferencias.temaOscuro;
    _isHttps = preferencias.secure;
    _textController = new TextEditingController(text: _port.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Configuracion'),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Configuracion',
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _textController,
                  decoration: InputDecoration(
                      labelText: 'Puerto', helperText: 'Puerto de conexión'),
                  onChanged: (value) {
                    if (utils.isNumeric(value)) {
                      preferencias.puerto = int.parse(value);
                      setState(() {
                        _port = int.parse(value);
                      });
                    }
                  },
                  validator: (value) {
                    print(value);
                    if (utils.isNumeric(value!)) {
                      return null;
                    } else {
                      return 'Solo números';
                    }
                  },
                ),
              ),
              Divider(),
              SwitchListTile(
                title: Text('Servidor HTTPS: '),
                value: _isHttps,
                onChanged: (value) {
                  preferencias.secure = value;
                  setState(() {
                    _isHttps = value;
                  });
                },
              ),
              Divider(),
              SwitchListTile(
                title: Text('Tema oscuro: '),
                value: _temaOscuro,
                onChanged: (value) {
                  preferencias.temaOscuro = value;
                  setState(() {
                    _temaOscuro = value;
                  });
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.security),
                title: Text('Server Chain'),
                subtitle: Text(preferencias.serverChain),
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    File file = File(result.files.single.path ?? '');
                    preferencias.serverChain = file.path;
                  } else {
                    // User canceled the picker
                  }
                  setState(() {});
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.vpn_key),
                title: Text('Server key'),
                subtitle: Text(preferencias.serverKey),
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    File file = File(result.files.single.path ?? '');
                    preferencias.serverKey = file.path;
                  } else {
                    // User canceled the picker
                  }
                  setState(() {});
                },
              ),
            ],
          ),
        ));
  }
}

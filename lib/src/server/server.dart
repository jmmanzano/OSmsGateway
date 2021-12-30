import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:osmsgateway/src/classes/sms_return.dart';
import 'package:osmsgateway/src/providers/log_provider.dart';
import 'package:osmsgateway/src/server/simple_http_server.dart';
import 'package:telephony/telephony.dart';
import 'package:flutter/services.dart' show rootBundle;

class Server extends SimpleHttpServer {
  late LogProvider _log;
  bool iniciado = false;
  final Telephony _telephony = Telephony.instance;
  static const DELIVERED = 'DELIVERED';
  static const UNSENDED = 'UNSENDED';
  static const ERROR = 'ERROR';
  int timeCounter = 200;

  iniciar(
      {required int port,
      InternetAddress? internetAddress,
      required bool secure,
      dynamic args}) async {
    timeCounter = args['timeout'];
    Map<String, String> mapIps = new Map();
    bool iniciar = true;
    await NetworkInterface.list(
            includeLoopback: false, type: InternetAddressType.any)
        .then((List<NetworkInterface> interfaces) {
      interfaces.forEach((interface) {
        interface.addresses.forEach((address) {
          if (interface.name.contains('wlan')) {
            iniciar = true;
            mapIps[interface.name] = address.address;
          }
        });
      });
    });
    if (iniciar) {
      super.start(
          port: port,
          internetAddress: internetAddress,
          secure: secure,
          args: args);
      iniciado = true;
      mapIps.entries.forEach((element) {
        _log.escribirLog(
            'Escuchando en ${element.key}: ${element.value}:$port');
      });
    } else {
      _log.escribirLog(
          'No se ha podido iniciar el servidor, compruebe el estado de la red');
    }
  }

  parar() async {
    _log.escribirLog('Apagando el servidor');
    await super.stop();
    iniciado = false;
  }

  Future<void> _sendSMS(HttpRequest request) async {
    String number = '';
    String message = '';
    Map<String, String> parameters = request.uri.queryParameters;
    parameters.forEach((key, value) {
      if (key == 'phone') {
        number = value;
      }
      if (key == 'message') {
        message = value;
      }
    });
    String msgSalida = ERROR;
    bool isSmsCapable = await _telephony.isSmsCapable ?? false;
    if (isSmsCapable) {
      bool isMultiPart = false;
      if (message.length > 160) {
        isMultiPart = true;
      }
      final SmsSendStatusListener listener = (SendStatus status) {
        if (status == SendStatus.DELIVERED) {
          msgSalida = DELIVERED;
          return;
        } else {
          msgSalida = UNSENDED;
        }
      };
      _telephony.sendSms(
          to: number,
          message: message,
          isMultipart: isMultiPart,
          statusListener: listener);
      int contador = 0;
      do {
        contador++;
      } while (await _continuar(msgSalida, contador));
    }
    if (msgSalida == DELIVERED) {
      _log.escribirLog('Mensaje enviado a $number => $message');
      request.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = ContentType.json
        ..headers.add('Access-Control-Allow-Origin', '*')
        ..headers
            .add('Access-Control-Allow-Methods', 'POST,GET,DELETE,PUT,OPTIONS')
        ..headers.add('Access-Control-Allow-Headers',
            'Origin, X-Requested-With, Content-Type, Accept')
        ..write(jsonEncode({'status': HttpStatus.ok}));
    } else {
      _log.escribirLog('Error enviado mensaje a $number => $message');
      request.response
        ..statusCode = HttpStatus.internalServerError
        ..headers.add('Access-Control-Allow-Origin', '*')
        ..headers
            .add('Access-Control-Allow-Methods', 'POST,GET,DELETE,PUT,OPTIONS')
        ..headers.add('Access-Control-Allow-Headers',
            'Origin, X-Requested-With, Content-Type, Accept')
        ..headers.contentType = ContentType.json
        ..write(jsonEncode({'status': HttpStatus.internalServerError}));
    }
  }

  Future<bool> _continuar(String status, int contador) async {
    return await Future.delayed(Duration(milliseconds: 50), () {
      if (status != DELIVERED && contador < timeCounter) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<void> _readSMS(HttpRequest request) async {
    // var route = request.uri.path;
    int desde = 0;
    int coje = 100;
    List<SmsMessage> listSms = await _telephony.getSentSms();
    List<SmsReturn> listReturn =
        listSms.skip(desde).take(coje).map((e) => SmsReturn(e)).toList();
    request.response
      ..statusCode = HttpStatus.accepted
      ..headers.add('Access-Control-Allow-Origin', '*')
      ..headers
          .add('Access-Control-Allow-Methods', 'POST,GET,DELETE,PUT,OPTIONS')
      ..headers.add('Access-Control-Allow-Headers',
          'Origin, X-Requested-With, Content-Type, Accept')
      ..headers.contentType = ContentType.json
      ..write(jsonEncode({'data': listReturn}));
  }

  void addLogger(LogProvider log) {
    _log = log;
  }

  Future<String> _readStaticFile(String route) async {
    return await rootBundle.loadString('lib/src/static/$route.html');
  }

  @override
  void addHanderls() {
    add('GET', '/', (HttpRequest request) async {
      String body = await _readStaticFile('index');
      request.response
        ..headers.contentType = ContentType.html
        ..write(body);
    });
    add('*', '*', (HttpRequest request) async {
      String body = await _readStaticFile('error');
      request.response
        ..headers.contentType = ContentType.html
        ..write(body);
    });
    add('GET', '/v1/sms/send/', (HttpRequest request) async {
      await _sendSMS(request);
    });
    add('POST', '/v1/sms/', (HttpRequest request) async {
      await _sendSMS(request);
    });
    // add('GET', '/v1/sms/', (HttpRequest request) async {
    //   await _readSMS(request);
    // });
    // add('GET', '/v1/sms/:inicio', (HttpRequest request) async {
    //   await _readSMS(request);
    // });
    // add('GET', '/v1/sms/:inicio/:fin', (HttpRequest request) async {
    //   await _readSMS(request);
    // });
  }
}

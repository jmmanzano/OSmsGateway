import 'dart:io';

bool isGet(HttpRequest request) {
  return (request.method == 'GET') ? true : false;
}

bool isPost(HttpRequest request) {
  return (request.method == 'POST') ? true : false;
}

bool isDelete(HttpRequest request) {
  return (request.method == 'DELETE') ? true : false;
}

bool isUpdate(HttpRequest request) {
  return (request.method == 'UPDATE') ? true : false;
}

bool isNumeric(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s);
  return (n == null) ? false : true;
}

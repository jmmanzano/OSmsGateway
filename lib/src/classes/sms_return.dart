// To parse this JSON data, do
//
//     final smsReturn = smsReturnFromJson(jsonString);

import 'dart:convert';

import 'package:telephony/telephony.dart';

class SmsReturn {
  int? id;
  String? address;
  String? body;
  int? date;
  int? dateSent;
  bool? read;
  bool? seen;
  String? subject;
  int? subscriptionId;
  int? threadId;
  SmsReturn(SmsMessage smsMessage) {
    this.id = smsMessage.id;
    this.address = smsMessage.address;
    this.body = smsMessage.body;
    this.date = smsMessage.date;
    this.dateSent = smsMessage.dateSent;
    this.read = smsMessage.read;
    this.seen = smsMessage.seen;
    this.subject = smsMessage.subject;
    this.subscriptionId = smsMessage.subscriptionId;
    this.threadId = smsMessage.threadId;
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "address": address == null ? null : address,
        "body": body == null ? null : body,
        "date": date == null ? null : date,
        "dateSent": dateSent == null ? null : dateSent,
        "read": read == null ? null : read,
        "seen": seen == null ? null : seen,
        "subject": subject == null ? null : subject,
        "subscriptionId": subscriptionId == null ? null : subscriptionId,
        "threadId": threadId == null ? null : threadId,
      };
}

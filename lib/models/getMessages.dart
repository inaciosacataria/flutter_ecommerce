// To parse this JSON data, do
//
//     final getMessages = getMessagesFromJson(jsonString);

import 'dart:convert';

List<GetMessages> getMessagesFromJson(String str) => List<GetMessages>.from(
    json.decode(str).map((x) => GetMessages.fromJson(x)));

String getMessagesToJson(List<GetMessages> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetMessages {
  GetMessages({
    required this.fromEmail,
    required this.toEmail,
    required this.msg,
  });

  String fromEmail;
  String toEmail;
  String msg;

  factory GetMessages.fromJson(Map<String, dynamic> json) => GetMessages(
        fromEmail: json["fromEmail"],
        toEmail: json["toEmail"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "fromEmail": fromEmail,
        "toEmail": toEmail,
        "msg": msg,
      };
}

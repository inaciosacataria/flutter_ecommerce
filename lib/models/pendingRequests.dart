// To parse this JSON data, do
//
//     final pendingRequests = pendingRequestsFromJson(jsonString);

import 'dart:convert';

List<PendingRequests> pendingRequestsFromJson(String str) =>
    List<PendingRequests>.from(
        json.decode(str).map((x) => PendingRequests.fromJson(x)));

String pendingRequestsToJson(List<PendingRequests> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingRequests {
  PendingRequests({
    required this.rid,
    required this.user,
    required this.seller,
    required this.address,
    required this.state,
    required this.city,
    required this.locality,
    required this.landmark,
    required this.phone,
    required this.issue,
    required this.service,
    required this.timeslot,
    required this.date,
    required this.status,
  });

  String rid;
  String user;
  String seller;
  String address;
  String state;
  String city;
  String locality;
  String landmark;
  String phone;
  String issue;
  String service;
  String timeslot;
  String date;
  String status;

  factory PendingRequests.fromJson(Map<String, dynamic> json) =>
      PendingRequests(
        rid: json["rid"],
        user: json["user"],
        seller: json["seller"],
        address: json["address"],
        state: json["state"],
        city: json["city"],
        locality: json["locality"],
        landmark: json["landmark"],
        phone: json["phone"],
        issue: json["issue"],
        service: json["service"],
        timeslot: json["timeslot"],
        date: json["date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "rid": rid,
        "user": user,
        "seller": seller,
        "address": address,
        "state": state,
        "city": city,
        "locality": locality,
        "landmark": landmark,
        "phone": phone,
        "issue": issue,
        "service": service,
        "timeslot": timeslot,
        "date": date,
        "status": status,
      };
}

// To parse this JSON data, do
//
//     final repairApi = repairApiFromJson(jsonString);

import 'dart:convert';

List<RepairApi> repairApiFromJson(String str) =>
    List<RepairApi>.from(json.decode(str).map((x) => RepairApi.fromJson(x)));

String repairApiToJson(List<RepairApi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RepairApi {
  RepairApi({
    required this.id,
    required this.service,
    required this.sellerId,
  });

  String id;
  String service;
  String sellerId;

  factory RepairApi.fromJson(Map<String, dynamic> json) => RepairApi(
        id: json["id"],
        service: json["service"],
        sellerId: json["seller_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service": service,
        "seller_id": sellerId,
      };
}

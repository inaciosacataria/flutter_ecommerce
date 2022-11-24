// To parse this JSON data, do
//
//     final getExtraCharges = getExtraChargesFromJson(jsonString);

import 'dart:convert';

List<GetExtraCharges> getExtraChargesFromJson(String str) =>
    List<GetExtraCharges>.from(
        json.decode(str).map((x) => GetExtraCharges.fromJson(x)));

String getExtraChargesToJson(List<GetExtraCharges> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetExtraCharges {
  GetExtraCharges({
    required this.serviceCharge,
    required this.gst,
    required this.transactionFee,
  });

  String serviceCharge;
  String gst;
  String transactionFee;

  factory GetExtraCharges.fromJson(Map<String, dynamic> json) =>
      GetExtraCharges(
        serviceCharge: json["service_charge"],
        gst: json["gst"],
        transactionFee: json["transaction_fee"],
      );

  Map<String, dynamic> toJson() => {
        "service_charge": serviceCharge,
        "gst": gst,
        "transaction_fee": transactionFee,
      };
}

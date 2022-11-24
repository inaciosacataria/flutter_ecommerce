// To parse this JSON data, do
//
//     final seller = sellerFromJson(jsonString);

import 'dart:convert';

List<Seller> sellerFromJson(String str) =>
    List<Seller>.from(json.decode(str).map((x) => Seller.fromJson(x)));

String sellerToJson(List<Seller> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Seller {
  Seller({
    required this.id,
    required this.shopName,
    required this.email,
    required this.password,
    required this.lat,
    required this.lng,
    required this.address,
    required this.phone,
    required this.deliveryArea,
    required this.gst,
    required this.isRestrict,
  });

  String id;
  String shopName;
  String email;
  String password;
  String lat;
  String lng;
  String address;
  String phone;
  String deliveryArea;
  String gst;
  String isRestrict;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        shopName: json["shop_name"],
        email: json["email"],
        password: json["password"],
        lat: json["lat"],
        lng: json["lng"],
        address: json["address"],
        phone: json["phone"],
        deliveryArea: json["delivery_area"],
        gst: json["gst"],
        isRestrict: json["isRestrict"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_name": shopName,
        "email": email,
        "password": password,
        "lat": lat,
        "lng": lng,
        "address": address,
        "phone": phone,
        "delivery_area": deliveryArea,
        "gst": gst,
        "isRestrict": isRestrict,
      };
}

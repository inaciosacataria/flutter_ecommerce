// To parse this JSON data, do
//
//     final orderDetails = orderDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<OrderDetails> orderDetailsFromJson(String str) => List<OrderDetails>.from(
    json.decode(str).map((x) => OrderDetails.fromJson(x)));

String orderDetailsToJson(List<OrderDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderDetails {
  OrderDetails({
    required this.id,
    required this.productName,
    required this.user,
    required this.seller,
    required this.shopName,
    required this.userPhone,
    required this.sellerPhone,
    required this.shopLat,
    required this.shopLng,
    required this.shopAddress,
    required this.userLat,
    required this.userLng,
    required this.userAddress,
    required this.totalAmount,
    required this.driverId,
  });

  String id;
  String productName;
  String user;
  String seller;
  String shopName;
  String userPhone;
  String sellerPhone;
  String shopLat;
  String shopLng;
  String shopAddress;
  String userLat;
  String userLng;
  String userAddress;
  String totalAmount;
  String driverId;

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        id: json["id"],
        productName: json["product_name"],
        user: json["user"],
        seller: json["seller"],
        shopName: json["shop_name"],
        userPhone: json["user_phone"],
        sellerPhone: json["seller_phone"],
        shopLat: json["shop_lat"],
        shopLng: json["shop_lng"],
        shopAddress: json["shop_address"],
        userLat: json["user_lat"],
        userLng: json["user_lng"],
        userAddress: json["user_address"],
        totalAmount: json["total_amount"],
        driverId: json["driver_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "user": user,
        "seller": seller,
        "shop_name": shopName,
        "user_phone": userPhone,
        "seller_phone": sellerPhone,
        "shop_lat": shopLat,
        "shop_lng": shopLng,
        "shop_address": shopAddress,
        "user_lat": userLat,
        "user_lng": userLng,
        "user_address": userAddress,
        "total_amount": totalAmount,
        "driver_id": driverId,
      };
}

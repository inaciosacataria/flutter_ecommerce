// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  Users({
    required this.id,
    required this.email,
    required this.password,
    required this.cartItem,
    required this.code,
    required this.refWallet,
    required this.isRestrict,
  });

  String id;
  String email;
  String password;
  String cartItem;
  String code;
  String refWallet;
  String isRestrict;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        cartItem: json["cart_item"],
        code: json["code"],
        refWallet: json["ref_wallet"],
        isRestrict: json["isRestrict"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "cart_item": cartItem,
        "code": code,
        "ref_wallet": refWallet,
        "isRestrict": isRestrict,
      };
}

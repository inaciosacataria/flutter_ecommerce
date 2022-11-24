import 'dart:convert';

List<ProductsUser> productsUserFromJson(String str) => List<ProductsUser>.from(
    json.decode(str).map((x) => ProductsUser.fromJson(x)));

String productsUserToJson(List<ProductsUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsUser {
  ProductsUser({
    required this.pid,
    required this.imgurl,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.userEmail,
    required this.gst,
  });

  String pid;
  String imgurl;
  String name;
  String description;
  String price;
  String categoryId;
  String userEmail;
  String gst;

  factory ProductsUser.fromJson(Map<String, dynamic> json) => ProductsUser(
        pid: json["id"],
        imgurl: json["image_url"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        categoryId: json["category_id"],
        userEmail: json["user_email"],
        gst: json["gst"],
      );

  Map<String, dynamic> toJson() => {
        "id": pid,
        "image_url": imgurl,
        "name": name,
        "description": description,
        "price": price,
        "category_id": categoryId,
        "user_email": userEmail,
        "gst": gst,
      };
}

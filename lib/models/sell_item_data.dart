import 'dart:convert';

List<Category1> categoryFromJson(String str) =>
    List<Category1>.from(json.decode(str).map((x) => Category1.fromJson(x)));

String categoryToJson(List<Category1> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category1 {
  Category1({
    required this.cid,
    required this.category,
  });

  String cid;
  String category;

  factory Category1.fromJson(Map<String, dynamic> json) => Category1(
        cid: json["cid"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "cid": cid,
        "category": category,
      };
}

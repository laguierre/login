import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.id,
    required this.title,
    required this.value,
    required this.available,
    required this.photoUrl,
  });

  String id;
  String title = '';
  double value = 0.0;
  bool available = true;
  String photoUrl;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        value: json["value"],
        available: json["available"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
        "available": available,
        "photoUrl": photoUrl,
      };
}

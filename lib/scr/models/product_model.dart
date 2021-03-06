import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String id;
  String title = '';
  double value = 0.0;
  bool available = true;
  String photoUrl;

  ProductModel({
    required this.id,
    required this.title,
    required this.value,
    required this.available,
    required this.photoUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        value: json["value"],
        available: json["available"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "value": value,
        "available": available,
        "photoUrl": photoUrl,
      };
}

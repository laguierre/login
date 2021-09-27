import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:login/scr/models/product_model.dart';

class ProductProvider {
  final String _url =
      'https://flutter-varios-b884a-default-rtdb.firebaseio.com';

  Future<bool> productCreate(ProductModel product) async {
    final url = '$_url/product.json';
    final resp =
        await http.post(Uri.parse(url), body: productModelToJson(product));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }




  Future<bool> productEdit(ProductModel product) async {
    final url = '$_url/product/${product.id}.json';
    final resp =
    await http.put(Uri.parse(url), body: productModelToJson(product));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }



  Future<List<ProductModel>> loadProduct() async {
    final url = '$_url/product.json';
    final resp = await http.get(Uri.parse(url));
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    List<ProductModel> product = [];

    if (decodedData == null) return [];
    decodedData.forEach((id, prod) {
      final prodTemp = ProductModel.fromJson(prod);
      prodTemp.id = id;
      product.add(prodTemp);
    });
    print(product);
    return product;
  }

  Future<int> deleteProduct(String id) async{
    final url = '$_url/product/$id.json';
    final resp = await http.delete(Uri.parse(url));
    print(json.decode(resp.body));
    return 1;
  }
}

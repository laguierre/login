import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/scr/models/product_model.dart';
import 'package:mime_type/mime_type.dart';

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
    final List<ProductModel> product = [];

    if (decodedData == null) return [];
    decodedData.forEach((id, prod) {
      print(id);
      final prodTemp = ProductModel.fromJson(prod);
      prodTemp.id = id;
      product.add(prodTemp);
    });
    return product;
  }

  Future<int> deleteProduct(String id) async {
    final url = '$_url/product/$id.json';
    final resp = await http.delete(Uri.parse(url));
    //print(json.decode(resp.body));
    print(resp.body);
    return 1;
  }

  Future<String?> uploadImage(XFile image) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dmvmtrijg/image/upload?upload_preset=enohu9xo');
    final mimeType = mime(image.path)!.split('/');                        //image/jpeg//
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', image.path,
        contentType: MediaType(mimeType[0], mimeType[1]));
    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Something it''s wrong');
      print(resp.body);
      return null;
    }
    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }
}

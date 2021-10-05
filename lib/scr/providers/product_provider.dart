import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/scr/models/product_model.dart';
import 'package:login/scr/user_preferences/user_preferences.dart';
import 'package:mime_type/mime_type.dart';

class ProductProvider {
  final String _url =
      'https://flutter-varios-b884a-default-rtdb.firebaseio.com';

  final _prefs = UserPreferences();

  Future<bool> productCreate(ProductModel product) async {
    final url = '$_url/product.json?auth=${_prefs.token}';
    final resp =
        await http.post(Uri.parse(url), body: productModelToJson(product));
    final decodedData = json.decode(resp.body);
    //print(decodedData);
    return true;
  }

  Future<bool> productEdit(ProductModel product) async {
    final url = '$_url/product/${product.id}.json?auth=${_prefs.token}';
    final resp =
        await http.put(Uri.parse(url), body: productModelToJson(product));
    final decodedData = json.decode(resp.body);
    //print(decodedData);
    return true;
  }

  Future<List<ProductModel>> loadProduct() async {
    ///
    /// https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[Base Name ]
    /// https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCg8LuhQvn_CFZlNDV0ySK420ufF5DuY-U
    /// No esta trajando acá!!!///
    //final url = '$_url/product.json?auth=${_prefs.token}';
    //final url = '$_url/product.json?auth=eyJhbGciOiJSUzI1NiIsImtpZCI6IjM1MDM0MmIwMjU1MDAyYWI3NWUwNTM0YzU4MmVjYzY2Y2YwZTE3ZDIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZmx1dHRlci12YXJpb3MtYjg4NGEiLCJhdWQiOiJmbHV0dGVyLXZhcmlvcy1iODg0YSIsImF1dGhfdGltZSI6MTYzMzMxMTU1NiwidXNlcl9pZCI6IjNHTkZHSU9GZ0JVVDhCYlY1bjB2UXN1Q3d0RTMiLCJzdWIiOiIzR05GR0lPRmdCVVQ4QmJWNW4wdlFzdUN3dEUzIiwiaWF0IjoxNjMzMzExNTU2LCJleHAiOjE2MzMzMTUxNTYsImVtYWlsIjoidGVzdEB0ZXN0LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ0ZXN0QHRlc3QuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.tchtWJOGKuoansQtxcObrRmmCTzPmtad15QMiJie2HC-aWvAY5o9w6sH9ZJDNsbZ-QXY2RPNiSlXUxTrK18Sst3XTbcfLMj8WtjWcsHQF0EdgWEz0GY9UapW3aFzcuCxQrEyAIyf9IbEAT_IAbIpyjBv618ZDbfEJxkjrAi9QnBKnJizrfmTr2A47gwPcJW4hsoNRmk6_rAqx7uj0cjT2ywi_QjlkQvldnJsEmj9dmZyMuh46Lsqc27HC4OBdHA-yB1dZl40TZmXGO4DqaX53NhzyQ7HfzHmvJLdxVTbWSBPpdHuqs-fdb3E09new0ROrI9FdcYnDWGYB2Fv9sCOXg';
    ///
    final url = Uri.tryParse('$_url/product.json?auth=${_prefs.token}');
    final resp = await http.get(url!);
    print('URL1:  ${url}, ${resp.body}');

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
    final url = '$_url/product/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(Uri.parse(url));
    //print(json.decode(resp.body));
    print(resp.body);
    return 1;
  }

  Future<String?> uploadImage(XFile image) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dmvmtrijg/image/upload?upload_preset=enohu9xo');
    final mimeType = mime(image.path)!.split('/'); //image/jpeg//
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', image.path,
        contentType: MediaType(mimeType[0], mimeType[1]));
    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Something it' 's wrong');
      print(resp.body);
      return null;
    }
    final respData = json.decode(resp.body);
    //print(respData);
    return respData['secure_url'];
  }
}

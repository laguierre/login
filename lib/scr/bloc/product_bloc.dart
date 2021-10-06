import 'package:image_picker/image_picker.dart';
import 'package:login/scr/providers/product_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'package:login/scr/models/product_model.dart';

class ProductBloc {
  final _productController = BehaviorSubject<List<ProductModel>>();
  final _loadingController = BehaviorSubject<bool>();
  final _productProvider = ProductProvider();

  Stream<List<ProductModel>> get productsStream => _productController.stream;

  Stream<bool> get loading => _loadingController.stream;

  void loadProduct() async {
    final product = await _productProvider.loadProduct();
    _productController.sink.add(product);
  }

  void addProduct(ProductModel product) async {
    _loadingController.sink.add(true);
    await _productProvider.productCreate(product);
    _loadingController.sink.add(false);
  }

  Future<String?> uploadPhoto(XFile photo) async {
    _loadingController.sink.add(true);
    final photoUrl = await _productProvider.uploadImage(photo);
    _loadingController.sink.add(false);
    return photoUrl;
  }

  void editProduct(ProductModel product) async {
    _loadingController.sink.add(true);
    await _productProvider.productEdit(product);
    _loadingController.sink.add(false);
  }

  void deleteProduct(String id) async {
    await _productProvider.deleteProduct(id);
  }

  dispose() {
    _productController.close();
    _loadingController.close();
  }
}

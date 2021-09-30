import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:login/scr/models/product_model.dart';
import 'package:login/scr/providers/product_provider.dart';
import 'package:login/scr/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productProvider = new ProductProvider();
  ProductModel product = new ProductModel(
      title: '', value: 0.0, available: false, id: '', photoUrl: '');
  bool _saving = false;
  late XFile foto = XFile('');

  static String noImagePNG = 'lib/assets/images/no-image.png';
  static String noImageLoading = 'lib/assets/images/jar-loading.gif';

  @override
  Widget build(BuildContext context) {
    final ProductModel? prodData =
        ModalRoute.of(context)?.settings.arguments as ProductModel?;

    if (prodData != null) {
      product = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Product'),
        actions: [
          IconButton(
              icon: const Icon(Icons.photo_size_select_actual),
              onPressed: _photoSelect),
          IconButton(
              icon: const Icon(Icons.camera_alt), onPressed: _takePhotos),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _showPhoto(),
                _name(),
                _price(),
                _available(),
                _btn(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _name() {
    return TextFormField(
      initialValue: product.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(labelText: 'Product'),
      validator: (value) {
        if (value!.length < 3)
          return 'Insert a valid name';
        else
          null;
      },
      onSaved: (value) => product.title = value!,
    );
  }

  Widget _price() {
    return TextFormField(
      initialValue: product.value.toString(),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: const InputDecoration(
        labelText: 'Price',
      ),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else
          return 'Only numbers.';
      },
      onSaved: (value) => product.value = double.parse(value!),
    );
  }

  Widget _btn(BuildContext context) {
    /*return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Save'),
      icon: Icon(Icons.save),
      onPressed: (_saving) ? null : _submit,
    );*/

    return ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed))
                return Theme.of(context).colorScheme.primary.withOpacity(0.5);
              else if (states.contains(MaterialState.disabled))
                return Colors.grey;
              return Colors.deepPurple; // Use the component's default.
            },
          ),
        ),
        icon: Icon(Icons.save),
        label: const Text('Save'),
        onPressed: (_saving) ? null : _submit,
        );
  }

  void _submit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    setState(() {
      _saving = true;
    });

    print(
        '**** Valid Product: ${product.title}, ${product.value.toString()}, ${product.available}, ${product.photoUrl} ****');

    print('SUBMIT: ${foto.path}');
    if (foto.path.isNotEmpty) {
      product.photoUrl = (await productProvider.uploadImage(foto))!;
    }
    if (product.id == '') {
      print('Crear');
      productProvider.productCreate(product);
    } else {
      print('append');
      productProvider.productEdit(product);
    }
    shownSnackbar(context, 'Saved!');
    Navigator.pop(context);
  }

  Widget _available() {
    return SwitchListTile(
        value: product.available,
        title: Text('Available'),
        activeColor: Colors.deepPurple,
        onChanged: (bool value) => setState(() {
              product.available = value;
            }));
  }

  void shownSnackbar(BuildContext context, String msj) {
    _saving = false;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msj), duration: Duration(milliseconds: 1500)),
    );
  }

  Widget _showPhoto() {
    if (product.photoUrl != '') {
      return FadeInImage(
          image: NetworkImage(product.photoUrl),
          height: 300.0,
          fit: BoxFit.contain,
          placeholder: AssetImage(noImageLoading));
    } else if (foto.path.isNotEmpty) {
      return FadeInImage(
          placeholder: AssetImage(noImageLoading),
          image: FileImage(File(foto.path)));
    } else {
      return Image.asset(noImagePNG);
    }

    /*foto.path.isNotEmpty
              ? FileImage(File(foto.path))
              : AssetImage(noImageLoading));*/
    /*return Image.asset(
        foto.path.isNotEmpty ? foto.path : noImagePNG,
        height: 300.0,
        fit: BoxFit.cover,
      );*/
  }

  void _photoSelect() async {
    _processPhoto(ImageSource.gallery);
  }

  void _takePhotos() async {
    _processPhoto(ImageSource.camera);
    print('El nombre de la fotos: ${foto.path}');
  }

  _processPhoto(ImageSource origin) async {
    ImagePicker _picker = ImagePicker();
    foto = (await _picker.pickImage(source: origin))!;
    if (foto == null) {
      product.photoUrl = '';
    }
    print('Ruta de la foto: ${foto.path}');
    setState(() {});
  }
}

import 'package:flutter/material.dart';
import 'package:login/scr/models/product_model.dart';
import 'package:login/scr/providers/product_provider.dart';
import 'package:login/scr/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productProvider = ProductProvider();
  bool _saving = false;
  ProductModel product = new ProductModel(
      title: '', value: 0.0, available: false, id: '', photoUrl: '');

  @override
  Widget build(BuildContext context) {
    /*final ProductModel? prodData =
        ModalRoute.of(context)?.settings.arguments as ProductModel?;

    if (prodData != null) {
      product = prodData;
    }*/

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Product'),
        actions: [
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: () {}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
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
        label: const Text('Price'),
        onPressed: _submit //(_saving) ? null : _submit,
        );
  }

  void _submit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    //_saving = true;
    print(
        'Valid Product: ${product.title}, ${product.value.toString()} + ${product.available}');


    productProvider.productCreate(product);

    /*if (product.id == null) {
      print('Crear');
      productProvider.productCreate(product);
    } else {
      print('append');
      productProvider.productEdit(product);
    }
    shownSnackbar(context, 'Saved!');
    Navigator.pop(context);*/
  }

  Widget _available() {
    return SwitchListTile(
        value: product.available,
        activeColor: Colors.deepPurple,
        title: Text('available'),
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
}

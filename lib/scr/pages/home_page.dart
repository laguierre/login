import 'package:flutter/material.dart';
import 'package:login/scr/bloc/provider.dart';
import 'package:login/scr/models/product_model.dart';
import 'package:login/scr/providers/product_provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final productProvider = ProductProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('Home Page'),
        ),
        body: _listProduct(),
        floatingActionButton: _fab(context),
      ),
    );
  }

  _fab(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'product'));
  }

  Widget _listProduct() {
    return FutureBuilder(
        future: productProvider.loadProduct(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            final product = snapshot.data;
            return ListView.builder(
                itemCount: product!.length,
                itemBuilder: (context, i) => _createItem(context, product[i]));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _createItem(BuildContext context, ProductModel product) {
    return Dismissible(
        background: Container(
          color: Colors.red,
        ),
        key: UniqueKey(),
        onDismissed: (direction){
          productProvider.deleteProduct(product.id);
        },
        child: ListTile(
          title: Text('${product.title} - ${product.value}'),
          subtitle: Text(product.id),
          onTap: () => Navigator.pushNamed(context, 'product', arguments: product),
        ));
  }
}

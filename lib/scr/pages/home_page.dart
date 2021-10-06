import 'package:flutter/material.dart';
import 'package:login/scr/bloc/product_bloc.dart';
import 'package:login/scr/bloc/provider.dart';
import 'package:login/scr/models/product_model.dart';

class HomePage extends StatelessWidget {
  static String noImagePNG = 'lib/assets/images/no-image.png';
  static String noImageLoading = 'lib/assets/images/jar-loading.gif';

  @override
  Widget build(BuildContext context) {
    final productBloc = Provider.productBloc(context);
    productBloc.loadProduct();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('Home Page'),
        ),
        body: _listProduct(productBloc),
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

  Widget _listProduct(ProductBloc productBloc) {
    return StreamBuilder(
        stream: productBloc.productsStream,
        builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            final product = snapshot.data;
            return ListView.builder(
                itemCount: product!.length,
                itemBuilder: (context, i) => _createItem(context, productBloc, product[i]));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _createItem(BuildContext context, ProductBloc productBloc, ProductModel product) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction) {
          print(product.id);
          //productProvider.deleteProduct(product.id);
          productBloc.deleteProduct(product.id);
        },
        child: Card(
          child: Column(
            children: <Widget>[
              (product.photoUrl == null)
                  ? Image(image: AssetImage(noImagePNG))
                  : FadeInImage(
                      image: NetworkImage(product.photoUrl),
                      placeholder: AssetImage(noImageLoading),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              ListTile(
                title: Text('${product.title} - ${product.value}'),
                subtitle: Text(product.id),
                onTap: () =>
                    Navigator.pushNamed(context, 'product', arguments: product),
              )
            ],
          ),
        ));
  }
}

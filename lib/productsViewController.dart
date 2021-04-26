import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/main.dart';

import 'package:shopping_app/model/appStateModel.dart';
import 'package:shopping_app/model/productModel.dart';
import 'package:shopping_app/productItem.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(builder: (context, model, child) {
      final products = model.getProductModels();
      return MaterialApp(
          home: Scaffold(
        appBar: AppBar(
          title: Text('Best shopping'),
          backgroundColor: Colors.grey,
        ),
        body: SafeArea(
            child: GridView.count(
          crossAxisCount: 1,
          children: List.generate(
            products.length,
            (index) {
              return Center(
                  child: ProductItem(
                product: products[index],
                isLastItem: index == products.length - 1,
              ));
            },
          ),
        )),
      ));
    });
  }
}

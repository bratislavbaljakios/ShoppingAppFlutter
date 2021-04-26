import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/model/appStateModel.dart';
import 'package:shopping_app/model/productModel.dart';
import 'package:share/share.dart';
import 'package:shopping_app/styles.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    this.product,
    this.isLastItem,
  });

  final ProductModel product;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(25)),
          color: Styles.primaryLightColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: 400,
        width: 380,
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 10.0),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(product.assetName,
                    package: product.assetPackage),
              ),
            ),
            Text(product.name,
                style: TextStyle(
                    fontFamily: "Source_Sans_Pro",
                    fontSize: 20,
                    color: Styles.secondaryLightColor)),
            Text(product.price.toString() + ' \$',
                style: TextStyle(
                    decorationStyle: TextDecorationStyle.dotted,
                    color: Styles.primaryColor)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Share.share('checkout',
                        subject: 'Look at this ${product.name}, its awesome!');
                  },
                  child: Expanded(
                    child: Icon(Icons.share, color: Styles.primaryColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final model =
                        Provider.of<AppStateModel>(context, listen: false);
                    model.addProductModelToCart(product.id);
                  },
                  child: Expanded(
                    child: Icon(Icons.add_shopping_cart,
                        color: Styles.primaryColor),
                  ),
                )
              ],
            )
          ],
        ));
  }
}

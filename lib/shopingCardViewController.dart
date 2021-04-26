// Copyright 2019 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:shopping_app/model/appStateModel.dart';
import 'package:shopping_app/shopingCardItem.dart';
import 'styles.dart';

class ShoppingCartTab extends StatefulWidget {
  @override
  _ShoppingCartTabState createState() {
    return _ShoppingCartTabState();
  }
}

class _ShoppingCartTabState extends State<ShoppingCartTab> {
  String name;
  String email;
  String location;
  String pin;
  DateTime dateTime = DateTime.now();
  final _currencyFormat = NumberFormat.currency(symbol: '\$');

  SliverChildBuilderDelegate _buildSliverChildBuilderDelegate(
      AppStateModel model) {
    return SliverChildBuilderDelegate(
      (context, index) {
        final productIndex = index;
        if (model.ProductModelsInCart.length > productIndex) {
          return ShoppingCartItem(
            index: index,
            product: model.getProductModelById(
                model.ProductModelsInCart.keys.toList()[productIndex]),
            quantity: model.ProductModelsInCart.values.toList()[productIndex],
            lastItem: productIndex == model.ProductModelsInCart.length - 1,
            formatter: _currencyFormat,
          );
        } else if (model.ProductModelsInCart.keys.length == productIndex &&
            model.ProductModelsInCart.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const SizedBox(height: 6),
                    Text(
                      'Total  ${_currencyFormat.format(model.totalCost)}',
                      style: Styles.productRowTotal,
                    ),
                  ],
                )
              ],
            ),
          );
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        return CustomScrollView(
          slivers: <Widget>[
            const CupertinoSliverNavigationBar(
              largeTitle: Text('Shopping Cart'),
            ),
            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.only(top: 4),
              sliver: SliverList(
                delegate: _buildSliverChildBuilderDelegate(model),
              ),
            )
          ],
        );
      },
    );
  }
}

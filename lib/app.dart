import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shopping_app/productsViewController.dart';
import 'package:shopping_app/styles.dart';
import 'productsViewController.dart';
import 'shopingCardViewController.dart';

class EasyShoppingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return CupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.light),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Styles.primaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.shopping_cart,
            ),
            label: 'Cart',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ProductsTab(),
              );
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ShoppingCartTab(),
              );
            });
            break;
        }
        return returnValue;
      },
    );
  }
}

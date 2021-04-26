import 'package:shopping_app/model/productModel.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:shopping_app/repository/productsRepository.dart';

double _salesTaxRate = 0.06;
double _shippingCostPerItem = 7;

class AppStateModel extends foundation.ChangeNotifier {
  // All the available ProductModels.
  List<ProductModel> _availableProductModels = [];

  // The currently selected category of ProductModelModels.
  Category _selectedCategory = Category.all;

  // The IDs and quantities of ProductModels currently in the cart.
  final _ProductModelsInCart = <int, int>{};

  Map<int, int> get ProductModelsInCart {
    return Map.from(_ProductModelsInCart);
  }

  // Total number of items in the cart.
  int get totalCartQuantity {
    return _ProductModelsInCart.values.fold(0, (accumulator, value) {
      return accumulator + value;
    });
  }

  Category get selectedCategory {
    return _selectedCategory;
  }

  // Totaled prices of the items in the cart.
  double get subtotalCost {
    return _ProductModelsInCart.keys.map((id) {
      // Extended price for ProductModel line
      return getProductModelById(id).price * _ProductModelsInCart[id];
    }).fold(0, (accumulator, extendedPrice) {
      return accumulator + extendedPrice;
    });
  }

  // Total shipping cost for the items in the cart.
  double get shippingCost {
    return _shippingCostPerItem *
        _ProductModelsInCart.values.fold(0.0, (accumulator, itemCount) {
          return accumulator + itemCount;
        });
  }

  // Sales tax for the items in the cart
  double get tax {
    return subtotalCost * _salesTaxRate;
  }

  // Total cost to order everything in the cart.
  double get totalCost {
    return subtotalCost;
  }

  // Returns a copy of the list of available ProductModels, filtered by category.
  List<ProductModel> getProductModels() {
    if (_selectedCategory == Category.all) {
      return List.from(_availableProductModels);
    } else {
      return _availableProductModels.where((p) {
        return p.category == _selectedCategory;
      }).toList();
    }
  }

  // Search the ProductModel catalog
  List<ProductModel> search(String searchTerms) {
    return getProductModels().where((ProductModel) {
      return ProductModel.name
          .toLowerCase()
          .contains(searchTerms.toLowerCase());
    }).toList();
  }

  // Adds a ProductModel to the cart.
  void addProductModelToCart(int ProductModelId) {
    if (!_ProductModelsInCart.containsKey(ProductModelId)) {
      _ProductModelsInCart[ProductModelId] = 1;
    } else {
      _ProductModelsInCart[ProductModelId] =
          _ProductModelsInCart[ProductModelId] + 1;
    }

    notifyListeners();
  }

  // Removes an item from the cart.
  void removeItemFromCart(int ProductModelId) {
    if (_ProductModelsInCart.containsKey(ProductModelId)) {
      if (_ProductModelsInCart[ProductModelId] == 1) {
        _ProductModelsInCart.remove(ProductModelId);
      } else {
        _ProductModelsInCart[ProductModelId] =
            _ProductModelsInCart[ProductModelId] - 1;
      }
    }

    notifyListeners();
  }

  // Returns the ProductModel instance matching the provided id.
  ProductModel getProductModelById(int id) {
    return _availableProductModels.firstWhere((p) => p.id == id);
  }

  // Removes everything from the cart.
  void clearCart() {
    _ProductModelsInCart.clear();
    notifyListeners();
  }

  // Loads the list of available ProductModels from the repo.
  void loadProductModels() {
    _availableProductModels =
        ProductModelsRepository.loadProductModels(Category.all);
    notifyListeners();
  }

  void setCategory(Category newCategory) {
    _selectedCategory = newCategory;
    notifyListeners();
  }
}

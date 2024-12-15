import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/product.dart';

const _productsKey = 'productsKey';

class ProductLocalStorage {
  Future<List<Product>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final products = prefs.getString(_productsKey);
    if (products == null) {
      return [];
    }

    final json = jsonDecode(products) as List;
    return json.map((product) => Product.fromMap(product)).toList();
  }

  Future<List<Product>> saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = jsonEncode(products.map((product) => product.toJson()));
    prefs.setString(_productsKey, productsJson);

    return products;
  }
}

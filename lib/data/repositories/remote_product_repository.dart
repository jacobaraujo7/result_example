import 'package:dio/dio.dart';
import 'package:result_example/data/services/product_local_storage.dart';
import 'package:result_example/domain/models/product.dart';

import '../services/product_client.dart';
import 'product_repository.dart';

class RemoteProductRepository implements ProductRepository {
  final ProductClient _productClient;
  final ProductLocalStorage _productLocalStorage;

  RemoteProductRepository(this._productClient, this._productLocalStorage);

  @override
  Future<List<Product>> getProducts() async {
    late List<Product> products;
    try {
      products = await _productClient.getProducts();
      await _productLocalStorage.saveProducts(products);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('Products not found');
      }

      try {
        products = await _productLocalStorage.getProducts();
      } catch (e) {
        throw Exception('LocalStorage Error');
      }
    } catch (e) {
      throw Exception('Unknown Error');
    }

    return products;
  }
}

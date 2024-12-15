import 'package:dio/dio.dart';

import '../../domain/models/product.dart';

class ProductClient {
  final Dio dio;

  ProductClient(this.dio);

  Future<List<Product>> getProducts() async {
    final response = await dio.get('/products');
    return response.data.map((e) => Product.fromMap(e)).toList();
  }
}

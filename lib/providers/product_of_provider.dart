import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class ProductProvider with ChangeNotifier {
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = false;
  String? _error;

  List<Map<String, dynamic>> get products => _products;

  bool get isLoading => _isLoading;

  String? get error => _error;


  Future<void> fetchProducts(String categoryId) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _error = 'No internet connection';
      notifyListeners();
      return;
    }

    final url = Uri.parse('http://85.31.236.78:3000/get-products-of-category');

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'pcatId': categoryId,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        _products = responseData.cast<Map<String, dynamic>>();
        print(_products);
      } else {
        _error = 'Failed to load products: ${response.reasonPhrase}';
      }
    } catch (error) {
      _error = 'An error occurred: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}


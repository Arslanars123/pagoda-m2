import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../utils/global.dart';

class CartProvider with ChangeNotifier {

  bool _isLoading = false;


  bool get isLoading => _isLoading;


 Future<void> sendData() async {
    _isLoading = true;
    notifyListeners();
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult[0]);
    if (connectivityResult[0] == ConnectivityResult.none) {
      _isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print("arslan");
      return;
    }

    final url = Uri.parse('http://85.31.236.78:3000/store-order-mobile');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      "carts": cart,
      "userId": "666e0a048145386dd5b79800",
      "status": "pending"
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print(response.body);
        Fluttertoast.showToast(
          msg: language== true ? "Ordine inviato":"Order Submitted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        throw Exception('Failed to send cart data');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg:   language == true ?"Qualcosa non va":"Something Wrong",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendCartData(String userId) async {
    print("aher");
    print(cart);
    print(userId);


    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('http://85.31.236.78:3000/store-order-mobile');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'userId': "666e0a048145386dd5b79800",
      'carts': [{"serviceId": null, "productId": "6664658c7cf9a13dccf988cb", "quantity": "2"}],
      "status":"pending"
    });
    final response = await http.post(url, body: body);
    print(response.body);
    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode != 200) {
        throw Exception('Failed to send cart data');
      }

      // Handle success response if needed
    } catch (e) {
      throw Exception('Error sending cart data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  }


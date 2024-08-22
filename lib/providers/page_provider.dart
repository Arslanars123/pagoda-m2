import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PageProvider extends ChangeNotifier {
  String _statusText = 'Checking internet connection...';

  bool _isLoading = true;
  String? internet = "checking";
  String get statusText => _statusText;

  bool get isLoading => _isLoading;
  var data;
  Future<void> fetchPages() async {
    data = null;
    internet = "checking";
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      print(connectivityResult);
      if (connectivityResult[0] == ConnectivityResult.none) {

        internet = "no";
        print("arslan");
        print(internet);
        notifyListeners();
        return;
      }

      internet = "yes";
      final response = await http.get(Uri.parse('http://85.31.236.78:3000/get-pages'));
      final statusCode = response.statusCode;

      if (statusCode == 200) {
        print("status");
        data = json.decode(response.body);
        print(data);

        print(data);


        _statusText = 'Data received successfully';

        print("here");

        _isLoading = false;
      } else {
        _statusText = 'Error: $statusCode';

        _isLoading = false;
      }
    } catch (e) {
      _statusText = 'Error: ${e.toString()}';

      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> checkInternetConnection() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        _statusText = 'No internet connection';
        _isLoading = false;
      } else {
        fetchPages();
      }
    } on SocketException catch (_) {
      _statusText = 'No internet connection';
      _isLoading = false;
    } catch (e) {
      _statusText = 'Error: $e';
      _isLoading = false;
    }
    notifyListeners();
  }
}

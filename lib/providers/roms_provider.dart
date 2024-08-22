import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RoomsProvider extends ChangeNotifier {
  String _statusText = 'Checking internet connection...';

  bool _isLoading = true;

  String get statusText => _statusText;

  bool get isLoading => _isLoading;
  String? internet = "checking";
  var data;
  Future<void> fetchRooms() async {
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
      final response = await http.get(Uri.parse('http://85.31.236.78:3000/get-rooms'));
      final statusCode = response.statusCode;

      if (statusCode == 200) {
        print("status");
        data = json.decode(response.body);
        print(data);

        print(data);

        final coverImageHotel = data['coverImage'];
        _statusText = 'Data received successfully';

        print("here");
        print(coverImageHotel);
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
        fetchRooms();
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

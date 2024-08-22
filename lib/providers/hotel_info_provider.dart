import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pagoda/utils/global.dart';

class HotelInfoProvider extends ChangeNotifier {
  String _statusText = 'Checking internet connection...';

  bool _isLoading = true;
    String? internet = "checking";
  String get statusText => _statusText;

  bool get isLoading => _isLoading;
var data;
  Future<void> fetchData() async {
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
      final response = await http.get(Uri.parse('http://85.31.236.78:3000/get-detail'));
      final statusCode = response.statusCode;
      print("after Internet");
      if (statusCode == 200) {
        print("status");
         data = json.decode(response.body);
        description4 = language == true ? data["description4I"]:data["description4"];

        checkinImage = data["checkImage"];
        print(data);
print("arslan yaha h");
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
        fetchData();
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

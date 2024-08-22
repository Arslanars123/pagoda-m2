import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pagoda/utils/global.dart';
import 'package:provider/provider.dart';

class PolicyData with ChangeNotifier {
  String _data = ''; // Variable to store fetched data

  String get data => _data;

  Future<void> fetchData() async {
    try {
      // Make GET request to API
      final response = await http.get(Uri.parse('http://85.31.236.78:3000/get-policy'));

      // Check status code
      if (response.statusCode == 200) {
        // Decode response data
        final responseData = json.decode(response.body);

        _data = language == true ? responseData["descriptionI"].toString():responseData["description"].toString(); // Update data variable
      } else {
        // Handle non-200 status code
        throw Exception('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors
      throw Exception('Failed to fetch data. ${e.toString()}');
    } finally {
      notifyListeners(); // Notify listeners regardless of success or failure
    }
  }
}

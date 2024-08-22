import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pagoda/views/success.dart';

import '../utils/global.dart';

class SendEmailProvider extends ChangeNotifier {
  bool _isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController Telephone  = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool get isLoading => _isLoading;

  Future<void> postData(BuildContext context, String imagePath, String email, String reservationCode, String dateArrive, String dateDeparture, String Telephone , String name) async {
    _isLoading = true;
    notifyListeners();

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _isLoading = false;
      notifyListeners();
      _showErrorDialog(context, 'No Internet Connection');
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://85.31.236.78:3000/check-in'),
    );

    request.fields.addAll({
      'name': name,
      'email': "dd@gmail.com",
      'reservationCode': reservationCode,
      'dateArrive': dateArrive,
      'dateDeparture': dateDeparture,
      'Telephone number': Telephone ,
    });
    print("departure");
    print(dateDeparture);
    try {
      if (imagePath.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            imagePath,
          ),
        );
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(), // Circular progress indicator
                SizedBox(height: 20),
                Text(language == true ? 'Invio dati in corso':'Sending data...',style: GoogleFonts.montserrat(
                  fontWeight: FontWeight
                      .w500, // Semi-bold style
                  fontSize: 17,
                  color: Color(0xFF777777),
                )),
              ],
            ),
          ),
        ),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print(response.body);
      if (response.statusCode == 200) {
        Navigator.pop(context);
       await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Success()),
        );
        print(response.body);
      } else {
        print('Error sending data: ${response.statusCode}');
        _showErrorDialog(context, 'Error sending data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending request: $e');
      _showErrorDialog(context, 'Error sending request: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
     // Close the progress dialog
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

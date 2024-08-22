import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pagoda/utils/global.dart';
import 'package:pagoda/views/success.dart';
import 'package:pagoda/views/unsuccess.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckInProvider extends ChangeNotifier {
  bool _isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController reservationCodeController = TextEditingController();
  TextEditingController dateArriveController = TextEditingController();
  TextEditingController dateDepartureController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool get isLoading => _isLoading;
 /* Future<void> sendEmail({
    required String name,
    required String telephone,
    required String email,
    required String dateArrival,
    required String dateDeparture,
    required String code,
    required String doc,
  }) async {
    // Define your endpoint
    final String endpoint = 'http://85.31.236.78:3000/send-email2';

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(endpoint));

    // Add fields to the request
    request.fields['name'] = name;
    request.fields['telephone'] = telephone;
    request.fields['email'] = email;
    request.fields['dateArrival'] = dateArrival;
    request.fields['dateDeparture'] = dateDeparture;
    request.fields['code'] = code;

    // Add file to the request
    var fileStream = http.ByteStream(doc.openRead());
    var length = await doc.length();
    var multipartFile = http.MultipartFile('doc', fileStream, length,
        filename: doc.path.split('/').last);

    // Add the file to the request
    request.files.add(multipartFile);

    try {
      // Send the request
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        print('Email sent successfully');
      } else {
        print('Failed to send email. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending email: $e');
    }
  }*/

  Future<void> postEmailTwo(BuildContext context, String imagePath, String email, String reservationCode, String dateArrive, String dateDeparture, String Telephone , String name) async {
    _isLoading = true;
    notifyListeners();

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _isLoading = false;
      notifyListeners();
      _showErrorDialog(context, language == true ? "Per favore, controlla la tua connessione dati":"No Internet Connection");
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://85.31.236.78:3000/send-email2'),
    );

    request.fields.addAll({
      'name': name,
      'email': email,
      'code': reservationCode,
      'dateArrival': dateArrive,
      'dateDeparture': dateDeparture,
      'telephone': Telephone ,
    });
    print("departure");
    print(dateDeparture);
    try {
      if (imagePath.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'doc',
            imagePath,
          ),
        );
      }



      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var decode = jsonDecode(response.body);
      print("here jkwbvdkwajvukajbvwkjfbvwqkjbfwqkjfbqkjfbwqkjq");
      print(decode);

      if (response.statusCode == 200 && decode["message"] == "Email sent successfully") {
        emailController.clear();
        reservationCodeController.clear();
        dateArriveController.clear();
        dateDepartureController.clear();
        PhoneController.clear();
        nameController.clear();

        print(response.body);
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Success()),
        );

      } else {
        print('Error sending data: ${response.statusCode}');
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UnSucess()),
        );
      }
    } catch (e) {
      print('Error sending request: $e');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UnSucess()),
      );
    } finally {
      _isLoading = false;
      notifyListeners();

    }
  }

  Future<void> postData(BuildContext context, String imagePath, String email, String reservationCode, String dateArrive, String dateDeparture, String Telephone , String name) async {
    _isLoading = true;
    notifyListeners();http://85.31.236.78:3000/store-order-mobile

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult[0] == ConnectivityResult.none) {
      print("internet check");
      _isLoading = false;
      notifyListeners();
      _showErrorDialog(context, language == true ? "Per favore, controlla la tua connessione dati":"No Internet Connection");
      return;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      _isLoading = false;
      notifyListeners();
      _showErrorDialog(context, language ? "Per favore inserisci un indirizzo email valido" : "Please enter a valid email");
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://85.31.236.78:3000/check-in'),
    );
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('userId');
    request.fields.addAll({
      'name': name,
      'email': email,
      'reservationCode': reservationCode,
      'dateArrive': dateArrive,
      'dateDeparture': dateDeparture,
      'phone': Telephone ,
      "userId": userId!,
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

      var decode = jsonDecode(response.body);
      if (response.statusCode == 200 && decode == "stored successfully" ) {
        print("check condition");


    postEmailTwo(context, imagePath, email, reservationCode, dateArrive, dateDeparture, Telephone, name);
      } else {
        _isLoading = false;
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UnSucess()),
        );

      }
    } catch (e) {
      _isLoading = false;
      Navigator.pop(context);
      print('Error sending request: $e');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UnSucess()),
      );
    } finally {
      _isLoading = false;
      notifyListeners();

    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message,    style: GoogleFonts.montserrat(
          fontWeight: FontWeight
              .w600, // Semi-bold style
          fontSize: 20,
          color: Color(0xFF777777),
        ),),
        actions: [
          TextButton(

            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: GoogleFonts.montserrat(
              fontWeight: FontWeight
                  .w600, // Semi-bold style
              fontSize: 14,
              color:Color(0xFF88A8FF),
            ),),
          ),
        ],
      ),
    );
  }
}

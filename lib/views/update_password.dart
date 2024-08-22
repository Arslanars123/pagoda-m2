import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/views/loginscreen.dart';

class UpdatePasswordScreen extends StatefulWidget {
  var userEmail;
  UpdatePasswordScreen({this.userEmail});
  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6B34D3), Color(0xFF5D78E0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _isLoading
                ? CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Logo Container
                      Logolog(),
                      SizedBox(height: 20.0), // Spacing between logo and form
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _newPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'New Password',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Color(0xFFBBC2D5),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              validator: _validateNewPassword,
                              style: GoogleFonts.montserrat(color: Colors.white),
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              controller: _confirmNewPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Confirm New Password',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Color(0xFFBBC2D5),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              validator: _validateConfirmNewPassword,
                              style: GoogleFonts.montserrat(color: Colors.white),
                            ),
                            SizedBox(height: 20.0),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _updatePassword,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
                                ),
                                child: Text(
                                  'Update Password',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Back to Login',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your new password';
    }
    if (value.length < 6) {
      return 'New password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your new password';
    }
    if (value != _newPasswordController.text) {
      return 'New passwords do not match';
    }
    return null;
  }

  Future<void> _updatePassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: 'No internet connection.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    final String newPassword = _newPasswordController.text;

    final url = Uri.parse('http://85.31.236.78:3000/update_password'); // Update with your actual endpoint
    print(widget.userEmail);
    print(_newPasswordController.text);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email":widget.userEmail,
        'password': newPassword,
      }),
    );

    print(response.body);
    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the JSON
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      // Handle successful password update (e.g., navigate to another screen, show a message, etc.)
      print('Password updated successfully: $responseData');
      Fluttertoast.showToast(
        msg: 'Password updated successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
                        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
    } else {
      // If the server returns an error response, show an error message
      print('Password update failed: ${response.reasonPhrase}');
      Fluttertoast.showToast(
        msg: 'Password update failed: ${response.reasonPhrase}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}

class Logolog extends StatelessWidget {
  const Logolog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.4, // Fixed width for the logo container
      height: MediaQuery.of(context).size.width / 5, // Fixed height for the logo container
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/logo.png'), // Update with your logo path
          fit: BoxFit.fill, // Adjust to cover the container
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/views/otp_screen.dart';
import 'package:pagoda/views/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _sendPasswordResetLink() async {
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

    final String email = _emailController.text;

    final url = Uri.parse('http://85.31.236.78:3000/otp'); // Update with your actual endpoint
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );
print("here data");
print(response.body);
    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the JSON
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      // Handle successful password reset request
      print('Password reset link sent: $responseData');
      Fluttertoast.showToast(
        msg: 'Password reset link sent!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      // If the server returns an error response, show an error message
      print('Failed to send password reset link: ${response.reasonPhrase}');
      Fluttertoast.showToast(
        msg: 'Failed to send password reset link: ${response.reasonPhrase}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  @override
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back,color: Colors.white,),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
          backgroundColor: Color(0xFF6B34D3), // Make the AppBar transparent if needed
      elevation: 0, // Remove shadow
    ),
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6B34D3), Color(0xFF5D78E0)], // Gradient background colors
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Email',
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
                      validator: _validateEmail,
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                    SizedBox(height: 20.0),
                 SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {
      // Check if the form is valid
      if (_formKey.currentState!.validate()) {
        // If valid, navigate to the next screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PinputExample(_emailController.text)),
        );
      } else {
        // If not valid, show a message or handle the error
        Fluttertoast.showToast(
          msg: 'Please enter a valid email address.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 15.0),
    ),
    child: Text(
      'Send Password Reset Link',
      style: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 16.0,
      ),
    ),
  ),
)

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
 }

class Logolog extends StatelessWidget {
  const Logolog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/1.4, // Fixed width for the logo container
      height:MediaQuery.of(context).size.width/5, // Fixed height for the logo container
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/logo.png'), // Update with your logo path
          fit: BoxFit.fill, // Adjust to cover the container
        ),
      ),
    );
  }
}

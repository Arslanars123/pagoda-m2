import 'package:flutter/material.dart';

class SplashController {
  Future<void> initializeApp(BuildContext context) async {
    // Simulate initialization delay
    await Future.delayed(Duration(seconds: 2));

    Navigator.pushReplacementNamed(context, '/rooms');
  }
}

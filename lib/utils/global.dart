import 'dart:io';
import 'package:flutter/material.dart';
bool language = true;
var description4;
var checkinImage;
var name = "Details";
int indexRoom = 0;
var  room;
File? selectedImage;
List<Map<String, dynamic>> cart = [];


 final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/chat_example.dart';
import 'package:pagoda/models/experience.dart';
import 'package:pagoda/utils/global.dart';
import 'package:pagoda/views/language.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class ExperiencDetailsScreen extends StatefulWidget {
  final Experience experience;

  ExperiencDetailsScreen({required this.experience});

  @override
  _ExperiencDetailsScreenState createState() => _ExperiencDetailsScreenState();
}

class _ExperiencDetailsScreenState extends State<ExperiencDetailsScreen> {
  Future<void> storeTopicAndNavigate(BuildContext context,var topic) async {
  // URL of your API endpoint
  final String apiUrl = 'http://85.31.236.78:3000/store-topic';

  // Retrieve the selectedUserId and userId from shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? userId = prefs.getString('userId'); // Assuming you also store userId

  if ( userId != null) {
    print(userId);
    print(widget.experience.name);
    try {
      // Make the API POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'name': widget.experience.name, // You may want to replace this with the actual topic name
          'selectedUserId': userId,
         
        }),
        headers: {'Content-Type': 'application/json'},
      );
print(response.body);
      if (response.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> data = jsonDecode(response.body);
        String topicId = data['topicId'];
        print(topicId);

     
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              topicId: topicId,
              senderId: userId,
            ),
          ),
        );
      } else {
        // Handle server response error
        print('Failed to store topic. Server responded with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network error
      print('Error occurred while storing topic: $e');
    }
  } else {
    // Handle the case where selectedUserId or userId is not found in shared preferences
    print('selectedUserId or userId not found in shared preferences');
  }
}
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    print(widget.experience);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  // Header section
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), // Subtle shadow color
                          spreadRadius: 1, // How much the shadow spreads
                          blurRadius: 3, // How blurry the shadow is
                          offset: Offset(0, 2), // The position of the shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: width / 25, top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Container(
                                child: Icon(Icons.arrow_back, color: Color(0xFF777777)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Container(
                              width: width / 1.5, // Adjust width as needed
                              child: Text(
                                language == true ? widget.experience.name : widget.experience.nameI,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.clip, // Add overflow property
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, // Semi-bold style
                                  fontSize: 14,
                                  color: Color(0xFF777777),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: width / 25, bottom: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LanguageScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                height: height / 25,
                                width: width / 9,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      language == true ? "assets/images/it flag.png" : "assets/images/uk.png",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: height / 16),
                  child: Container(
                    width: double.infinity,
                    height: height / 4,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(height: height / 7),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // Subtle shadow color
                            spreadRadius: 1, // How much the shadow spreads
                            blurRadius: 3, // How blurry the shadow is
                            offset: Offset(0, 2), // The position of the shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: width / 1.1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HtmlWidget(
                          language == true ? widget.experience.descriptionI : widget.experience.description,
                          renderMode: RenderMode.column,
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFB5B5B5),
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.montserrat().fontFamily,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: width / 1.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // Subtle shadow color
                            spreadRadius: 1, // How much the shadow spreads
                            blurRadius: 3, // How blurry the shadow is
                            offset: Offset(0, 2), // The position of the shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Giorni e orari',
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 8),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Giorni Disponibili:',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    widget.experience.availableDays,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Minimo:',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    widget.experience.minimumPerson,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    widget.experience.preavviso,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    '2.89',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            // Button section
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: height / 20,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                   storeTopicAndNavigate(context, widget.experience.name);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF289DD1),
                                    padding: EdgeInsets.symmetric(vertical: 4.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  child: Text(
                                    'CHATTA CON IL TUO CONCIERGE',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/chat_example.dart';
import 'package:pagoda/utils/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/serve.dart';
import '../../widgets/tab_list.dart';

import 'package:http/http.dart' as http;
class RestaurantDetailsScreen extends StatefulWidget {
   RestaurantDetailsScreen({super.key, required this.serve});

  final Serve serve;


  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  final String BASE_URL = 'http://85.31.236.78:3000';
   Future<void> storeTopicAndNavigate(BuildContext context,var topic) async {
  // URL of your API endpoint
  final String apiUrl = 'http://85.31.236.78:3000/store-topic';

  // Retrieve the selectedUserId and userId from shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? userId = prefs.getString('userId'); // Assuming you also store userId

  if ( userId != null) {
    print(userId);
    print(widget.serve.name);
    try {
      // Make the API POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'name': widget.serve.name, // You may want to replace this with the actual topic name
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
  void initState() {
   print(widget.serve);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      backgroundColor: const Color.fromARGB(255, 236, 232, 232),

      appBar: AppBar(
        backgroundColor: Colors.white,
        //
        automaticallyImplyLeading: true,

        centerTitle: true,

        title: Text(
          widget.serve.nameI,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: const Color(0xFF777777),
          ),
        ),

        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: const BoxDecoration(shape: BoxShape.circle),
            height: 35,
            width: 35,
            child: ClipOval(
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/en/thumb/0/03/Flag_of_Italy.svg/1500px-Flag_of_Italy.svg.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),

      body: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            children: [
              // restaurant banner image
              SizedBox(
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  '$BASE_URL/${widget.serve.image}',
                  fit: BoxFit.cover,
                ),
              ),

              Stack(
                clipBehavior: Clip.none,
                children: [
                  //
                  Container(height: 380),

                  Positioned(
                    top: -30,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: Column(
                        children: [
                          // title + details
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0XFFFFFFFF),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(28),
                              child: Column(
                                children: [
                                  // title
                                  Text(
                                    widget.serve.nameI,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: const Color(0xFF777777),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  HtmlWidget(
                                    // the first parameter (`html`) is required
                                    language == true ?  widget.serve.descriptionI:widget.serve.description,

                                    // all other parameters are optional, a few notable params:

                                    // specify custom styling for an element
                                    // see supported inline styling below

                                    // this callback will be triggered when user taps a link

                                    // select the render mode for HTML body
                                    // by default, a simple `Column` is rendered
                                    // consider using `ListView` or `SliverList` for better performance

                                    // set the default styling for text
                                    textStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFFB5B5B5),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //
                              _buildCard('Apertura', widget.serve.openTime),


                              _buildCard('Chiusura', widget.serve.closeTime),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

               widget.serve.images.length != 0 ?    const SizedBox(height: 120):SizedBox(),

              const Divider(height: 20, thickness: 1),

              const SizedBox(height: 16),

           widget.serve.images.length != 0 ?   SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    //
                    SizedBox(height: widget.serve.images.isEmpty ? 0 : 36),

                    ...widget.serve.images.map(
                          (image) => _buildImageContainer(image),
                    ),
                  ],
                ),
              ):SizedBox(),

               widget.serve.images.length != 0 ?   SizedBox(height: widget.serve.images.isEmpty ? 0 : 28):SizedBox(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.82,
                    child: FilledButton(
                      onPressed: () {
                        storeTopicAndNavigate(context, "");
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 27, 145, 241),
                        padding: const EdgeInsets.all(12),
                      ),
                      child: Text(
                        'PRENOTA CON IL TUO CONCIERGE',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const Divider(height: 20, thickness: 1),

              const SizedBox(height: 16),

              TabList(categories: widget.serve.pcatsIds),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String time) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height/7,

        decoration: BoxDecoration(
          color: const Color(0XFFFFFFFF),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            //
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: const Color(0xFF244756).withOpacity(0.7),
              ),
            ),

            const SizedBox(height: 6),

            Text(
              time,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.blueAccent.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContainer(var image) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            'https://upload.wikimedia.org/wikipedia/en/thumb/0/03/Flag_of_Italy.svg/1500px-Flag_of_Italy.svg.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

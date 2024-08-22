import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/chat_example.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late Future<List<Map>> messagesFuture;

  @override
  void initState() {
    super.initState();
    messagesFuture = getMessages(
      url: 'http://85.31.236.78:3000/get-user-topics',
    // Example body with userId
    );
  }

  Future<List<Map>> getMessages({required String url}) async {
    List<Map> myList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw Exception('No internet connection');
      }

      print('API hit start');
      print(userId);
      http.Response response = await http.post(
        Uri.parse(url),
        body: {'selectedUserId': userId},
      );
      print("data check");
print(userId);
print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        for (var i in data) {
          myList.add(i);
        }
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error caught: $e');
      throw e;
    }
    return myList;
  }

  void retryFetchingMessages() {
    setState(() {
      messagesFuture = getMessages(
        url: 'http://85.31.236.78:3000/get-user-topics',
   // Example body with userId
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
    
        // appBar: AppBar(
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Icon(
        //         Icons.arrow_back,
        //         color: const Color(0xff8E8E8E),
        //       ),
        //       Text(
        //         'Conierge chat',
        //         style: GoogleFonts.montserrat(
        //           color: const Color(0xff848484),
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ),
        //       CircleAvatar(
        //         radius: width * 0.0375,
        //         backgroundImage: const NetworkImage(
        //           'https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/Flag_of_Italy.svg/1024px-Flag_of_Italy.svg.png',
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // body: SingleChildScrollView(
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchBar(),
                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.05,
                    right: width * 0.05,
                    top: height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Messaggi',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff011474),
                          fontSize: width * 0.06,
                        ),
                      ),
                      Text(
                        'Hai due nuovi messaggi',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff7D8CB6),
                          fontSize: width * 0.03,
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      SizedBox(
                        height: height * 0.5,
                        child: FutureBuilder<List<Map>>(
                          future: messagesFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              String errorMessage = snapshot.error.toString();
                              if (errorMessage.toLowerCase().contains('no internet')) {
                                return NoConnectionWidget(onRetry: retryFetchingMessages);
                              } else {
                                return ErrorWidget(onRetry: retryFetchingMessages);
                              }
                            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                              return NoDataWidget(onRetry: retryFetchingMessages);
                            } else if (snapshot.hasData) {
                              print('snapshot.hasData: ' + snapshot.data.toString());
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: ()async{
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      var userI = prefs.getString("userId");
                                     
                                        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen(senderId:userI,topicId:snapshot.data![index]['_id'].toString())),
              );
                                    },
                                    child: SingleChatContact(
                                      title: snapshot.data![index]['name'].toString(),
                                      lastMessage: 'lorem ipsum dolor sit amen',
                                      time: 'Adesso',
                                      imageUrl:
                                          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/Flag_of_Italy.svg/1024px-Flag_of_Italy.svg.png',
                                      isOnline: true,
                                    ),
                                  );
                                },
                              );
                            } else {
                              print(snapshot.error.toString());
                              return Center(
                                child: Text(
                                  'An unknown error just occurred!',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        
      
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.125,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xff001379),
      ),
      child: Center(
        child: Container(
          height: height * 0.06,
          width: width * 0.8,
          padding: EdgeInsets.only(
            left: width * 0.05,
          ),
          decoration: BoxDecoration(
            color: const Color(0xff7F89BC),
            borderRadius: BorderRadius.circular(
              width * 5,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 15,
                blurStyle: BlurStyle.outer,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 10),
                hintText: 'Cerca...',
                hintStyle: GoogleFonts.montserrat(
                  color: Colors.white,
                ),
                border: InputBorder.none,
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SingleChatContact extends StatelessWidget {
  SingleChatContact({
    super.key,
    required this.title,
    required this.lastMessage,
    required this.time,
    required this.imageUrl,
    required this.isOnline,
  });

  String title;
  String lastMessage;
  String time;
  String imageUrl;
  bool isOnline;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;

    return Container(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              imageUrl,
            ),
          ),
          SizedBox(
            width: width * 0.035,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: width * 0.035,
                  ),
                ),
                Text(
                  lastMessage,
                  style: GoogleFonts.montserrat(
                    color: const Color(0xffBABABA),
                    fontWeight: FontWeight.w600,
                    fontSize: width * 0.035,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: GoogleFonts.montserrat(
              color: const Color(0xffBABABA),
              fontWeight: FontWeight.w600,
              fontSize: width * 0.035,
            ),
          ),
        ],
      ),
    );
  }
}

class NoConnectionWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const NoConnectionWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Internet Connection',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRetry,
            child: Text(
              'Try Again',
              style: GoogleFonts.montserrat(),
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const ErrorWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Something went wrong. Please try again.',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRetry,
            child: Text(
              'Retry',
              style: GoogleFonts.montserrat(),
            ),
          ),
        ],
      ),
    );
  }
}

class NoDataWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const NoDataWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Data Available',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRetry,
            child: Text(
              'Retry',
              style: GoogleFonts.montserrat(),
            ),
          ),
        ],
      ),
    );
  }
}

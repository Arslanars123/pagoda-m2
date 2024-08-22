import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/other_pages.dart';
import 'package:pagoda/views/online_check.dart';
import 'package:pagoda/views/rooms_list.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/global.dart';
import 'language.dart';

class BottomBarScreenFirst extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreenFirst> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _screens = [
    OnlineCheckIn(),
    RoomsListNew(),
    OnlineCheckIn(),
    OtherPages(),
  ];

  load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    language = prefs.getBool("language") ?? true;
    setState(() {
      print(language);
    });
  }

  @override
  void initState() {
    load();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Widget buildMenuItem(
        {required String image,
          required String text,
          required Function() onTap}) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          height: height / 16,
          child: Padding(
            padding: EdgeInsets.only(left: width / 12, top: 20),
            child: Row(
              children: [
                Container(
                  width: width / 9,
                  height: height / 16,
                  child: Padding(
                    padding: EdgeInsets.only(right: width / 23),
                    child: Image.asset(
                      image,
                      scale: 1.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  text,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF404040),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).popUntil((route) => route.isFirst);
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
        /*  drawer: Drawer(
            backgroundColor: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height / 25,
                  ),
                  Container(
                      width: double.infinity,
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: width / 14),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.grey.withOpacity(0.4),
                                size: height / 30,
                              ),
                            ),
                          ))),
                  SizedBox(
                    height: height / 25,
                  ),
                  Image.asset(
                    "assets/images/hats_1.png",
                    scale: height / 400,
                  ),
                  SizedBox(
                    height: height / 25,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: width / 14,
                      right: width / 14,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: height / 11,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/pagoda_logo.png"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          await prefs.setBool("language", false);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomBarScreen()),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.height / 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/uk flag.png'),
                              // Replace with your image path
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width / 20,
                      ),
                      InkWell(
                        onTap: () async {
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          await prefs.setBool("language", true);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomBarScreen()),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.height / 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(language == true ?"assets/images/it flag.png":"assets/images/uk.png"),
                              // Replace with your image path
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildMenuItem(
                        image: 'assets/images/1.png',
                        text: 'Home',
                        onTap: () {
                          // Add onTap functionality here
                        },
                      ),
                      buildMenuItem(
                        image: 'assets/images/2.png',
                        text:
                        language == true ? 'Camere & Suite' : 'Rooms & Suites',
                        onTap: () {
                          // Add onTap functionality here
                        },
                      ),
                      buildMenuItem(
                        image: 'assets/images/3.png',
                        text: 'Beach Bar',
                        onTap: () {
                          // Add onTap functionality here
                        },
                      ),
                      buildMenuItem(
                        image: 'assets/images/4.png',
                        text: 'Ristorante',
                        onTap: () {
                          // Add onTap functionality here
                        },
                      ),
                      buildMenuItem(
                        image: 'assets/images/5.png',
                        text: 'Esperienze',
                        onTap: () {
                          // Add onTap functionality here
                        },
                      ),
                      buildMenuItem(
                        image: 'assets/images/6.png',
                        text: 'Servizi',
                        onTap: () {
                          // Add onTap functionality here
                        },
                      ),
                      buildMenuItem(
                        image: 'assets/images/7.png',
                        text: 'Impostazioni',
                        onTap: () {
                          // Add onTap functionality here
                        },
                      ),
                      // Additional menu items

                      // Add more buildMenuItem calls for other menu items
                    ],
                  )
                ],
              ),
            ),
          ),*/
          /* Text(
            'Camere e Suite',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600, // Semi-bold style
              fontSize: 20,
              color: Color(0xFF777777),
            ),
          ),*/
          body: Column(
            children: [
              _selectedIndex == 0
                  ? Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                height: height / 13,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Container(width: width / 10,
                      child:Icon(Icons.arrow_back,color: Color(0xFF777777),)
                      ),

                      Padding(
                        padding:
                        EdgeInsets.only(top: height / 110),
                        child: Text(
                          language == true
                              ? 'Check-in'
                              : "Check-in",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight
                                .w600, // Semi-bold style
                            fontSize: 20,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LanguageScreen()),
                          );
                        },
                        child:Image.asset(language == true ?language == true ?"assets/images/it flag.png":"assets/images/uk.png":"assets/images/uk.png",),
                      ),
                    ],
                  ),
                ),
              )
                  : _selectedIndex == 1
                  ? Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                height: height / 13,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: width / 10),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height / 110, right: width / 80),
                        child: Text(
                          language == true
                              ? "Camere & Suite"
                              : 'Rooms & Suites',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LanguageScreen()),
                          );
                        },
                        child:Image.asset(language == true ?language == true ?"assets/images/it flag.png":"assets/images/uk.png":"assets/images/uk.png",),
                      ),
                    ],
                  ),
                ),
              )   : _selectedIndex == 2 ?
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                height: height / 13,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: width / 10),
                      Padding(
                        padding:
                        EdgeInsets.only(top: height / 110),
                        child: Text(
                          language == true
                              ? 'Check-in'
                              : "Check-in",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight
                                .w600, // Semi-bold style
                            fontSize: 20,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LanguageScreen()),
                          );
                        },
                        child:Image.asset(language == true ?language == true ?"assets/images/it flag.png":"assets/images/uk.png":"assets/images/uk.png",),
                      ),
                    ],
                  ),
                ),
              ): _selectedIndex == 3 ?
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                height: height / 13,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: width / 10),
                      Padding(
                        padding:
                        EdgeInsets.only(top: height / 110),
                        child: Text(
                          language == true
                              ? 'Info'
                              : "Info",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight
                                .w600, // Semi-bold style
                            fontSize: 20,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LanguageScreen()),
                          );
                        },
                        child:Image.asset(language == true ?language == true ?"assets/images/it flag.png":"assets/images/uk.png":"assets/images/uk.png",),
                      ),
                    ],
                  ),
                ),
              )

                  : SizedBox(),
              _screens[_selectedIndex],
            ],
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            height: MediaQuery.of(context).size.height * 0.075,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
                bottomRight: Radius.circular(24.0),
                bottomLeft: Radius.circular(24.0),
              ),
              child: BottomAppBar(
                padding: EdgeInsets.zero,
                color: Color(0xFF001378),
                elevation: 10.0,
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => _onItemTapped(0),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: SvgPicture.asset(
                            'assets/images/one.svg',
                            color: _selectedIndex == 0
                                ? Colors.white
                                : Color(0xFF88A8FF),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => _onItemTapped(1),
                        child: SvgPicture.asset(
                          'assets/images/two.svg',
                          color: _selectedIndex == 1
                              ? Colors.white
                              : Color(0xFF88A8FF),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => _onItemTapped(2),
                        child: SvgPicture.asset(
                          'assets/images/three.svg',
                          color: _selectedIndex == 2
                              ? Colors.white
                              : Color(0xFF88A8FF),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => _onItemTapped(3),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SvgPicture.asset(
                            'assets/images/four.svg',
                            color: _selectedIndex == 3
                                ? Colors.white
                                : Color(0xFF88A8FF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
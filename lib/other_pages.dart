import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/providers/page_provider.dart';
import 'package:pagoda/utils/global.dart';
import 'package:pagoda/views/check_in_two.dart';
import 'package:pagoda/views/detail_page.dart';
import 'package:pagoda/views/home.dart';
import 'package:pagoda/views/language.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtherPages extends StatefulWidget {
  const OtherPages({super.key});

  @override
  State<OtherPages> createState() => _OtherPagesState();
}

class _OtherPagesState extends State<OtherPages> {
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var id = [];

  choose(int num) {
    id.clear();
    id.add(num);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final roomsProvider = Provider.of<PageProvider>(context, listen: false);
  Widget buildMenuItem(
        {required String image,
        required String text,
        required Function() onTap}) {
      return GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(

              child: Padding(
                padding: EdgeInsets.only(left: width / 12,top: height/70,bottom: height/70),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                   /* Container(
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
                    ),*/
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

         Divider(),
          ],
        ),
      );
    }

   
    return Scaffold(
      backgroundColor: Colors.white,
       key: _scaffoldKey,
      appBar:   AppBar(
        backgroundColor: Colors.white,
          title: Text(
                                    language == true
                                        ? "Info"
                                        : 'Info',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Color(0xFF777777),
                                    ),
                                  ),
          leading: IconButton(
            icon: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 10,
                              child: Image.asset("assets/images/menu.png",scale: 1.7,)),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer(); // Open the drawer
            },
          ),
          actions: [
                   InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LanguageScreen()),
                                    );
                                  },
                                  child: Image.asset(
                                    scale: 2,
                                    language == true
                                        ? language == true
                                            ? "assets/images/it flag.png"
                                            : "assets/images/uk.png"
                                        : "assets/images/uk.png",
                                  ),
                                ),
          ],
        ),
           drawer: Drawer(
            backgroundColor: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height / 35,
                  ),
                  Container(
                      width: double.infinity,
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: width / 14,top: 20),
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
                    scale: height / 300,
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
                      height: height / 13,
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
                                builder: (context) => OnlineCheckInTwo()),
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
                                builder: (context) => OnlineCheckInTwo()),
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
                     Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomBarScreen()),
                          );
                        },
                      ),
                      // buildMenuItem(
                      //   image: 'assets/images/2.png',
                      //   text: language == true
                      //       ? 'Camere & Suite'
                      //       : 'Rooms & Suites',
                      //   onTap: () {
                      //     // Add onTap functionality here
                      //   },
                      // ),
                      // buildMenuItem(
                      //   image: 'assets/images/3.png',
                      //   text: 'Beach Bar',
                      //   onTap: () {
                      //     // Add onTap functionality here
                      //   },
                      // ),
                          buildMenuItem(
                        image: 'assets/images/3.png',
                        text: 'Info',
                        onTap: () {
                             Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtherPages()),
                          );
                        },
                      ),
                             buildMenuItem(
                        image: 'assets/images/3.png',
                        text: 'Check-in',
                        onTap: () {
                         Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OnlineCheckInTwo()),
              );
                        },
                      ),
                      // buildMenuItem(
                      //   image: 'assets/images/4.png',
                      //   text: 'Ristorante',
                      //   onTap: () {
                      //     // Add onTap functionality here
                      //   },
                      // ),
                      // buildMenuItem(
                      //   image: 'assets/images/exp.',
                      //   text: 'Esperienze',
                      //   onTap: () {
                      //     // Add onTap functionality here
                      //   },
                      // ),
                      // buildMenuItem(
                      //   image: 'assets/images/6.png',
                      //   text: 'Servizi',
                      //   onTap: () {
                      //     // Add onTap functionality here
                      //   },
                      // ),
                      // buildMenuItem(
                      //   image: 'assets/images/7.png',
                      //   text: 'Impostazioni',
                      //   onTap: () {
                      //     // Add onTap functionality here
                      //   },
                      // ),
                      // Additional menu items
      
                      // Add more buildMenuItem calls for other menu items
                    ],
                  )
                ],
              ),
            ),
          ),
      
        
      body: Column(
        children: [
          SizedBox(height: 20,),
          Expanded(
            child: SingleChildScrollView(
              child: RefreshIndicator(
                onRefresh: (){
                  setState(() {
                    
                  });
                  return Future.value(false);
                },
                child: FutureBuilder(
                    future: roomsProvider.fetchPages(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: Column(
                          children: [
                            SizedBox(height: height/3,),
                            CircularProgressIndicator(),
                          ],
                        ));
                      } else if (snapshot.hasError) {
                        return Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: height/4,),
                              Icon(
                                Icons.wifi,
                                size: height / 7,
                                color: Color(0xFF001378),
                              ),
                              Text(
                                language == true ?"Qualcosa non va":'Something is wrong',
                                style: GoogleFonts.montserrat(
                                  textStyle:
                                      TextStyle(color: Color(0xFF777777), fontSize: 14),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {});
                                    },
                                    child: Text(
                                      language == true ? "Riprova":'Retry',                              style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color: Color(0xFF777777), fontSize: 14),
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        );
                      } else {
                        if (roomsProvider.data == null) {
                // No data available
                          if (roomsProvider.internet == "no") {
                // No internet connection
                    
                            return Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                    
                                  Icon(
                                    Icons.wifi,
                                    size: height / 7,
                                    color: Color(0xFF001378),
                                  ),
                                  Text(
                                    language == true ? "Per favore, controlla la tua connessione dati": 'No internet connection',
                    
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Color(0xFF777777), fontSize: 14),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {});
                                        },
                                        child: Text(
                                          language == true ? "Riprova":'Retry',                                  style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Color(0xFF777777), fontSize: 14),
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            );
                          } else {
                // Internet connection available but no data
                            return Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                    
                                  Icon(
                                    Icons.folder_copy_outlined,
                                    size: height / 7,
                                    color: Color(0xFF001378),
                                  ),
                                  Text(
                                    language == true ? "nessun dato disponibile"  :'No Data Available',
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Color(0xFF777777), fontSize: 14),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {});
                                        },
                                        child: Text(
                                          language == true ? "Riprova":'Retry',                                  style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Color(0xFF777777), fontSize: 14),
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            );
                          }
                        } else {
                          return roomsProvider.data.length != 0 ?ListView.builder(
                            shrinkWrap: true,
                            itemCount: roomsProvider.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      name = language == true
                                          ? roomsProvider.data[index]["titleI"]
                                          : roomsProvider.data[index]["title"];
                                    });
                                    await choose(index);
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (_, __, ___) => OtherDetailPage(
                                          data: roomsProvider.data[index],
                                        ),
                                        transitionsBuilder: (_, animation, __, child) {
                                          return SlideTransition(
                                            position: Tween<Offset>(
                                              begin: Offset(1.0, 0.0),
                                              end: Offset.zero,
                                            ).animate(
                                              CurvedAnimation(
                                                parent: animation,
                                                curve: Curves.easeInOut, // You can change the curve as desired
                                              ),
                                            ),
                                            child: child,
                                          );
                                        },
                                        transitionDuration: Duration(milliseconds: 900), // Set forward duration
                                      ),
                                    ).then((_) {
                                      // This code runs when the pushed route (RoomDetail) is popped
                                      // You can put any code that needs to run after the pop here
                                    });
                    
                                   /* Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BottomBarScreenThree(
                                              data: roomsProvider.data[index])),
                                    );*/
                                  },
                                  child: Container(
                                    /*  height: height/14,*/
                                    decoration: BoxDecoration(
                                      color: id.contains(index)
                                          ? Color(0xFF5B7FE1)
                                          : Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          // Light shadow color
                                          spreadRadius: 2,
                                          // Spread radius
                                          blurRadius: 4,
                                          // Blur radius
                                          offset:
                                              Offset(0, 2), // Offset in x and y direction
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, bottom: 10, top: 10),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: width / 15,
                                          ),
                                          Expanded(
                                            child: Text(
                                              language == true
                                                  ? roomsProvider.data[index]["titleI"]
                                                  : roomsProvider.data[index]["title"],
                                              maxLines: 3,
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w700,
                                                // Semi-bold style
                                                fontSize: 14,
                                                color: id.contains(index)
                                                    ? Colors.white
                                                    : Color(0xFF6478AF),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ):SizedBox();
                        }
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

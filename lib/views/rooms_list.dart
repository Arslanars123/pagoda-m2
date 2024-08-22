import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/utils/global.dart';
import 'package:pagoda/views/example.dart';
import 'package:provider/provider.dart';

import '../providers/roms_provider.dart';

class RoomsListNew extends StatefulWidget {
  const RoomsListNew({super.key});

  @override
  State<RoomsListNew> createState() => _RoomsListNewState();
}

class _RoomsListNewState extends State<RoomsListNew> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final roomsProvider = Provider.of<RoomsProvider>(context, listen: false);
    return Expanded(
      child: Container(

        child: RefreshIndicator(
          onRefresh: (){
            setState(() {

            });
            return Future.value(false);
          },
          child: Padding(
            padding: EdgeInsets.only(left: width / 25, right: width / 25),
            child: FutureBuilder(
              future: roomsProvider.fetchRooms(),
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
                                language == true ? "Riprova":'Retry',                                style: GoogleFonts.montserrat(
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
                                    language == true ? "Riprova":'Retry',                                    style: GoogleFonts.montserrat(
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
                                    language == true ? "Riprova":'Retry',
                                    style: GoogleFonts.montserrat(
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
                // Data available, proceed with your UI
                // Your existing code for handling data
                    return Padding(
                      padding: EdgeInsets.only(left: width / 40, right: width / 40),
                      child: Container(

                        child: ListView.builder(
                          padding: EdgeInsets.only(top: height / 50),
                          shrinkWrap: true,
                          itemCount: roomsProvider.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(roomsProvider.data[index]);
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>  RoomDetail(
                                      data: roomsProvider
                                          .data[
                                      index],),
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
                             /*   Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RoomDetail(
                                              data: roomsProvider
                                                  .data[
                                              index],)),
                                );*/
                                /*   Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  Bottom(data: roomsProvider.data[index])),
                                  );*/
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        // Shadow color
                                        spreadRadius: 2,
                                        // Spread radius
                                        blurRadius: 5,
                                        // Blur radius
                                        offset: Offset(0,
                                            3), // Offset from the top-left corner
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: height / 5,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10)
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10)
                                              ),
                                              child: roomsProvider.data[index]["images"].length != 0 ?CachedNetworkImage(
                                                imageUrl: "http://85.31.236.78:3000/${roomsProvider.data[index]["images"][0]}",
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Color(0xFF001378),)),
                                                errorWidget: (context, url, error) => Image.asset("assets/images/no.jpg",fit: BoxFit.cover,),
                                              ):SizedBox(),
                                            ),
                                          ),
                                          roomsProvider.data[index]["nameI"] !=
                                                      null ||
                                                  roomsProvider.data[index]["name"]
                                              ? SizedBox(
                                                  height: height / 50,
                                                )
                                              : SizedBox(),
                                          roomsProvider.data[index]["nameI"] !=
                                                      null ||
                                                  roomsProvider.data[index]
                                                          ["name"] !=
                                                      null
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width / 20),
                                                  child: Container(
                                                    width: width / 1.9,
                                                    child: Text(
                                                      language == true
                                                          ? roomsProvider
                                                              .data[index]["nameI"]
                                                              .toString()
                                                          : roomsProvider
                                                                  .data[index]
                                                                      ["name"]
                                                                  .toString() ??
                                                              "",
                                                      maxLines: 2,
                                                      style: GoogleFonts.montserrat(
                                                        textStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            // Semi-bold
                                                            fontSize: 14.0,
                                                            color:
                                                                Color(0xFF777777)),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                      /*    SizedBox(
                                            height: height / 50,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: width / 20,
                                              right: width / 20,
                                            ),
                                            child: Html(
                                              data: language == true
                                                  ? roomsProvider.data[index]
                                                      ["descriptionI"]
                                                  : roomsProvider.data[index]
                                                      ["description"],
                                              style: {
                                                '#': Style(
                                                  maxLines: 2,
                                                  textOverflow:
                                                      TextOverflow.ellipsis,
                                                  color: Color(0xFFB5B5B5),
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily:
                                                      GoogleFonts.montserrat()
                                                          .fontFamily,
                                                ),
                                              },
                                            )
                                            *//*Text(
                                                maxLines: 2,
                                                  roomsProvider.data[index]["name"].toString() ?? "",
                                                style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                      fontWeight: FontWeight.w600, // Semi-bold
                                                      fontSize: 14.0,
                                                      color: Color(0xFFB5B5B5)
                                                  ),
                                                ),
                                              )*//*
                                            ,
                                          ),*/
                                          SizedBox(
                                            height: height / 40,
                                          ),
                                        ],
                                      ),
                                      roomsProvider.data[index]["price"]
                                                      .toString() ==
                                                  "no" ||
                                              roomsProvider.data[index]["price"] ==
                                                  null
                                          ? SizedBox()
                                          : Positioned(
                                              top: height / 6.5,
                                              left: width / 1.6,
                                              child: Container(
                                                width: width / 5.5,
                                                height: height / 11,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10)),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(
                                                          0xFF8089BC), // Start color
                                                      Color(
                                                          0xFF8089BC), // End color
                                                    ],
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '\€ ' +
                                                          roomsProvider.data[index]
                                                              ["price"],
                                                      style: GoogleFonts.montserrat(
                                                        textStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            // Semi-bold
                                                            fontSize: 14.0,
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                    Text(
                                                      language == true
                                                          ? "Notte"
                                                          : "Night",
                                                      style: GoogleFonts.montserrat(
                                                        textStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            // Semi-bold
                                                            fontSize: 14.0,
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

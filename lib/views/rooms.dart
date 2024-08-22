import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/views/room_detail.dart';
import 'package:provider/provider.dart';

import '../providers/roms_provider.dart';

class RoomsListScreen extends StatefulWidget {
  const RoomsListScreen({super.key});

  @override
  State<RoomsListScreen> createState() => _RoomsListScreenState();
}

class _RoomsListScreenState extends State<RoomsListScreen> {

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.height;
    var height = MediaQuery.of(context).size.height;
    final roomsProvider = Provider.of<RoomsProvider>(context, listen: false);
    return  Column(
        children: [
         /* Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(
                left: width / 35,
                top: height / 80,

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 14,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/menu.png",
                          scale: 1.7,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Camere e Suite',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600, // Semi-bold style
                      fontSize: 20,
                      color: Color(0xFF777777),
                    ),
                  ),
                  Container(
                    height: height / 15,
                    width: width / 15,
                    decoration: BoxDecoration(
                      // Box decoration with image
                      image: DecorationImage(
                        image: AssetImage(language == true ?"assets/images/it flag.png":"assets/images/uk.png"),
                        // Provide your image path here
                        fit: BoxFit
                            .contain, // This will contain (cover) the image within the container
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),*/
          FutureBuilder(
              future: roomsProvider.fetchRooms(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else  {
                  return    Padding(
                    padding:  EdgeInsets.only(left: width/40,right: width/40),
                    child: Container(

                      height: height/1.299,

                      child: ListView.builder(
                        padding: EdgeInsets.only(top: height/50),
                        shrinkWrap: true,
                        itemCount: roomsProvider.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  RoomDetails(data: roomsProvider.data[index])),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10,right: 10,bottom: 20),
                              height: height/5.6,
                             /* child: Stack(
                                children: [
                                  Padding(
                                    padding:   EdgeInsets.only(left: width/23),
                                    child: Container(
                                      height:height/4.7,

                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5), // Light shadow color
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: Offset(0, 2), // changes position of shadow
                                            ),
                                          ],

                                          borderRadius: BorderRadius.circular(10)
                                      ),

                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          roomsProvider.data[index].containsKey("coverImage") ?    Container(
                                            height:height/8,
                                            width: width/9,
                                            decoration: BoxDecoration(
                                                image:roomsProvider.data[index]["coverImage"] != null ? DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                     "http://85.31.236.78:3000/"+ roomsProvider.data[index]["coverImage"] ,
                                                  ),

                                                ):DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                    "no.jpg" ,
                                                  ),

                                                ),

                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                )
                                            ),
                                          ):Container(
                                            height:height/8,
                                            width: width/9,
                                            decoration: BoxDecoration(
                                                image:DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                    "assets/images/no.jpg" ,
                                                  ),

                                                ),

                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                )
                                            ),
                                          ),
                                          SizedBox(width: width/50,),
                                          Container(
                                            width:width/4,
                                            child: Column(
                                              crossAxisAlignment:CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  roomsProvider.data[index]["name"],
                                                  maxLines: 1,
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    color: Color(0xFF777777),
                                                  ),
                                                ),
                                                Text(
                                                  roomsProvider.data[index]["description"],
                                                  maxLines: 2,
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    color: Color(0xFFB5B5B5),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),


                                      Padding(
                                        padding:  EdgeInsets.only(left: width/18,right: width/50,),
                                        child: Padding(
                                          padding:  EdgeInsets.only(bottom: height/60),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.arrow_back_ios,size: width/50,color: Color(0XFF777777).withOpacity(0.5),),
                                                  SizedBox(width: width/80,),
                                                  Icon(Icons.arrow_forward_ios,size: width/50,color: Color(0XFF777777).withOpacity(0.5),),
                                                ],
                                              ),
                                              Text(
                                                "\$ "+    roomsProvider.data[index]["price"].toString()+"/ Night",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600, // Semi bold
                                                  color: Color(0xFF5B7FE1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),*/
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              }),
        ],

    );
  }
}

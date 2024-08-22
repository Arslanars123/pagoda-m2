import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/utils/global.dart';
import 'package:provider/single_child_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'language.dart';
class RoomDetails extends StatefulWidget {
  var data;
   RoomDetails({super.key,required this.data});

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {

  List<String> services = [
    "Ristorante",
    "Servizio in Camera",
    "Altro servizio",
    "Piscina"
  ];
  Future<void> _launchUrl() async {
    if(language == true){
      print(language);
      if (!await launchUrl(Uri.parse("https://reservations.verticalbooking.com/premium/index.html?id_albergo=22576&dc=6945&id_stile=16986&lingua_int=ita"))) {
        throw Exception('Could not launch');
      }
    }else{
      if (!await launchUrl(Uri.parse("https://reservations.verticalbooking.com/premium/index.html?id_albergo=22576&dc=6945&id_stile=16986&lingua_int=eng"))) {
        throw Exception('Could not launch');
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          child:
              Column(
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: width / 20, ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(width: width / 10,
                                child:Icon(Icons.arrow_back,color: Color(0xFF777777),)
                            ),
                          ),

                          Container(

                            width: width / 1.5, // Adjust width as needed

                            child: Text(


                              language == true
                                  ? widget.data["name"]
                                  : widget.data["nameI"],
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              // Add overflow property
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600, // Semi-bold style
                                fontSize: 14,
                                color: Color(0xFF777777),
                              ),
                            ),
                          ),
                          /*Text(
                                  language == true
                                      ? widget.data["name"]
                                      : widget.data["nameI"],
                                  style: GoogleFonts.montserrat(
                                    fontWeight:
                                        FontWeight.w600, // Semi-bold style
                                    fontSize: 20,
                                    color: Color(0xFF777777),
                                  ),
                                ),*/
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LanguageScreen()),
                                );
                              },
                              child: Container(
                                height: height / 20,
                                width: width / 9,
                                decoration: BoxDecoration(
                                  // Box decoration with image
                                  image: DecorationImage(
                                    image: AssetImage(
                                        language == true ?"assets/images/it flag.png":"assets/images/uk.png"),
                                    // Provide your image path here
                                    fit: BoxFit
                                        .cover, // This will contain (cover) the image within the container
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          widget.data["images"][0] != null?  InkWell(
                            onTap: (){
                            /*  Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  Example(image: "http://85.31.236.78:3000/" + widget.data["images"][0])),
                              );*/
                    },
                            child: Hero(
                                                  tag: "imageHero", // Unique tag for the Hero animation
                                                    child: Container(
                            width: double.infinity,
                            height: height / 5.7,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("http://85.31.236.78:3000/" + widget.data["images"][0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                                                    ),
                                                  ),
                          ):
                          Container(
                            width: double.infinity, // Set width of the container
                            height: height / 5.7, // Set height of the container
                            decoration: BoxDecoration(
                              // Box decoration with image
                              image: DecorationImage(
                                image: AssetImage("assets/images/no.jpg"),
                                // Provide your image path here
                                fit: BoxFit
                                    .cover, // This will contain (cover) the image within the container
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: height / 7),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                   widget.data["description"] !="" ?  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)),

                                    width: width / 1.2,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: width / 12, right: width / 12, top: height / 30,bottom: height / 30),
                                        child: Html(data: widget.data["description"],style:  {
                                          '#': Style(
                                            maxLines: 5,
                                            textOverflow: TextOverflow.ellipsis,
                                            color: Color(0xFFB5B5B5),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: GoogleFonts.montserrat().fontFamily,
                                          ),
                                        },)
                                      /* Text(
                                widget.data["description"],
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                    fontSize: 13, color: Color(0xFFB5B5B5)),
                              ),*/
                                    ),
                                  ):SizedBox(),
                                /*  Text(
                                    'Camere & Suite',
                                    style: GoogleFonts.montserrat(
                                      textStyle:
                                      TextStyle(color: Color(0xFF777777), fontSize: 14),
                                    ),
                                  ),*/
                                  SizedBox(
                                    height: height / 13,
                                  ),
                                  widget.data["servicesIds"].length != 0 ?     Image.asset(
                                    "assets/images/logo2.png",
                                    scale: 1.9,
                                  ):SizedBox(),
                                  SizedBox(
                                    height: height / 50,
                                  ),
                                  widget.data["servicesIds"].length != 0 ?    Text(
                                 language == true ?  "Cosa troverai nella tua camera":"What you will find in your room",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13, color: Color(0xFF777777)),
                                  ):SizedBox(),
                                  SizedBox(
                                    height: height / 50,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: width / 12,
                                      right: width / 12,
                                    ),
                                    child:  GridView.builder(

                                      shrinkWrap: true,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, // Number of columns
                                      ),
                                      physics: NeverScrollableScrollPhysics(), // Disable scrolling
                                      itemCount: widget.data["servicesIds"].length, // Number of grid items

                                      itemBuilder: (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Container(
                                            width: width / 2.5,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                top: height / 35,
                                                bottom: height / 35,
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                Container(
                                                width: width/10, // Adjust the width as needed
                                                height: height/22, // Adjust the height as needed
                                                decoration: BoxDecoration(

                                                  image: DecorationImage(
                                                    image: widget.data["servicesIds"][index]["image1"] != null
                                                        ? NetworkImage(
                                                      "http://85.31.236.78:3000/" +
                                                          widget.data["servicesIds"][index]["image1"],
                                                    ) as ImageProvider<Object>
                                                        : AssetImage("assets/images/no.jpg") as ImageProvider<Object>,
                                                    fit: BoxFit.cover, // Box fit cover to cover the entire space
                                                  ),

                                                   // Default color if image is not available
                                                ),
                                              ),


                                              SizedBox(
                                                    height: height / 50,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(2),
                                                    child: Text(

                                                      widget.data["servicesIds"][index]["title"] ?? "",
                                                      maxLines: 2,
                                                      style: GoogleFonts.montserrat(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(
                                                            0xFFB5B5B5), // Use the color code #B5B5B5
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
                                    /*Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: width / 2.5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: height / 35, bottom: height / 35),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/img0.png",
                                      scale: 1.5,
                                    ),
                                    SizedBox(
                                      height: height / 50,
                                    ),
                                    Text(
                                      'Televisore',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(
                                            0xFFB5B5B5), // Use the color code #B5B5B5
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: width / 2.5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: height / 35, bottom: height / 35),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/img0.png",
                                      scale: 1.5,
                                    ),
                                    SizedBox(
                                      height: height / 50,
                                    ),
                                    Text(
                                      'Televisore',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(
                                            0xFFB5B5B5), // Use the color code #B5B5B5
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),*/
                                  ),


                                  SizedBox(
                                    height: height / 20,
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(left: width/12,right: width/12),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _launchUrl();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF289DD1), // Use the color code #289DD1
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20), // Set border radius to 20 for rounded corners
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Text(
                                           language == true ? 'Verifica disponibilità':"Check availability",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white, // Use the color code #B5B5B5
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ),
                                  SizedBox(
                                    height: height / 20,
                                  ),
                                  widget.data["images"].length != 1 ? buildImages(widget.data["images"],height,width):SizedBox(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),


                ],
              ),



        ),
      ),
    );

  }
}
Widget buildImages(List<dynamic> servicesIds, double height, double width) {
  double imageHeight = height / 6; // Calculate the height for each image

  if (servicesIds.isEmpty) {
    return SizedBox.shrink(); // Return empty container if servicesIds list is empty
  } else if (servicesIds.length == 1) {
    // If there's only one service, display its image
    return Padding(
      padding: EdgeInsets.only(left: width / 12, right: width / 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: imageHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage("http://85.31.236.78:3000/${servicesIds[0]}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } else if (servicesIds.length == 2) {
    // If there are two services, display their images side by side
    return Padding(
      padding: EdgeInsets.only(left: width / 12, right: width / 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: imageHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage("http://85.31.236.78:3000/${servicesIds[0]}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 10), // Adjust spacing between images
          Expanded(
            child: Container(
              height: imageHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage("http://85.31.236.78:3000/${servicesIds[1]}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } else if (servicesIds.length >= 3) {
    // If there are three or more services, display the first two images in a row and the third below in full width
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage("http://85.31.236.78:3000/${servicesIds[0]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: Container(
                  height: imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage("http://85.31.236.78:3000/${servicesIds[1]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10), // Adjust spacing between rows
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Container(
            height: imageHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage("http://85.31.236.78:3000/${servicesIds[2]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  } else {
    return SizedBox.shrink(); // Handle other cases if needed
  }
}





/*
Wrap(
children: [
Container(


child: Stack(
children: [
Column(
children: [
SizedBox(height: height / 25),
Container(
height: height / 10,
width: width / 3,
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.only(
topLeft: Radius.circular(10),
topRight: Radius.circular(10),
bottomLeft: Radius.circular(10),
bottomRight: Radius.circular(10),
),
),
),
],
),
Container(
width: width / 3,
height: height / 18,
child: Center(
child: Container(
height: height / 18,
width: width / 8,
decoration: BoxDecoration(
color: Color(0xFF001378),
borderRadius: BorderRadius.only(
topLeft: Radius.circular(10),
bottomLeft: Radius.circular(10),
bottomRight: Radius.circular(10),
),
),
child: index != 0
? Image.asset(
"assets/images/Icon$number.png",
scale: 2,
)
    : Image.asset(
"assets/images/Icon.png",
scale: 2,
),
),
),
),
],
),
),
],
);*/

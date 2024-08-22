import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/utils/global.dart';
import 'package:pagoda/views/light.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'language.dart';

class ServiceDetail extends StatefulWidget {
  var data;
  VoidCallback? prev;

  ServiceDetail({this.data,this.prev});

  @override
  State<ServiceDetail> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<ServiceDetail> {
  List<String> services = [
    "Ristorante",
    "Servizio in Camera",
    "Altro servizio",
    "Piscina"
  ];

  Future<void> _launchUrl() async {
    if (language == true) {
      print(language);
      if (!await launchUrl(Uri.parse(
          "https://reservations.verticalbooking.com/premium/index.html?id_albergo=22576&dc=6945&id_stile=16986&lingua_int=ita"))) {
        throw Exception('Could not launch');
      }
    } else {
      if (!await launchUrl(Uri.parse(
          "https://reservations.verticalbooking.com/premium/index.html?id_albergo=22576&dc=6945&id_stile=16986&lingua_int=eng"))) {
        throw Exception('Could not launch');
      }
    }
  }

  saveImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(widget.data["images"]);

    await prefs.setString('dynamicList', jsonString);
  }
  Widget _buildItem(dynamic item) {
    return  Container(
      width: MediaQuery.of(context).size.width/2.4,
      height: MediaQuery.of(context).size.height/8,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 4, // Adjust as needed
          bottom: 4, // Adjust as needed
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width/10, // Adjust as needed
              height: MediaQuery.of(context).size.height/25, // Adjust as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(

                    "http://85.31.236.78:3000/" + item["image1"],
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: 4, // Adjust as needed
            ),
            Padding(
              padding: const EdgeInsets.all(2),
              child: Text(
                language == true
                    ? item["titleI"]
                    : item["title"],
                maxLines: 2,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFB5B5B5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> generateGrid(List<dynamic> items) {
    List<Widget> gridItems = [];

    for (int i = 0; i < items.length; i += 2) {
      // Check if we have enough items for a full row
      if (i + 1 < items.length) {
        // Add two items in a row
        gridItems.add(Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildItem(items[i]),
              _buildItem(items[i + 1]),
            ],
          ),
        ));
      } else {
        // If there's only one item left, add it as the first item in a new row
        gridItems.add(Row(

          children: [
            _buildItem(items[i]),
          ],
        ));
      }
    }

    return gridItems;
  }



// Usage:



  @override
  void initState() {

   /* saveImages();*/


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.data = {
      "_id": "6622e6ad43b942a6934c8b7e",
      "name": "CLASSIC",
      "nameI": "CLASSIC",
      "price": "no",
      "type": "no",
      "description": "<div class=\"av-special-heading av-lqbawiur-863ef40f3fd6043666e550621123d10a av-special-heading-h2 blockquote modern-quote modern-centered  avia-builder-el-5  el_after_av_heading  el_before_av_hr  av-inherit-size\">\r\n<p class=\"av-special-heading-tag\" style=\"text-align: center;\"><strong>Quiet and private</strong>, <br>these rooms feature <br>a patio equipped with a small table and chairs.</p>\r\n</div>\r\n<div class=\"hr av-57fka5-de9cc8208eee6f5cc51e3c1e4b337386 hr-invisible  avia-builder-el-6  el_after_av_heading  avia-builder-el-last \">&nbsp;</div>",
      "descriptionI": "<h3 class=\"av-special-heading-tag\" style=\"text-align: center;\"><strong>Tranquille e riservate</strong>,</h3>\r\n<p class=\"av-special-heading-tag\" style=\"text-align: center;\">queste camere sono caratterizzate&nbsp;<br>da un patio attrezzato con tavolino e sedie.</p>",
      "capacity": "no",
      "images": [
        "A2A0536_classic-1500x630.jpg",
        "classsichotelpagoda-1030x687.jpg"
      ],
      "servicesIds": [
        {
          "_id": "6622e23b43b942a6934c8b5a",
          "title": "Air conditioning",
          "titleI": "Aria condizionata",
          "description": "<p>no</p>",
          "descriptionI": "<p>no</p>",
          "weekDay": "no",
          "pricePerPerson": "no",
          "minimumPerson": "no",
          "visible": "no",
          "visibleToDate": "2024-04-20T00:00:00.000Z",
          "visibleFromDate": "2024-04-20T00:00:00.000Z",
          "position": "1",
          "image1": "air-conditioner.png",
          "image2": "air-conditioner.png",
          "image3": "air-conditioner.png",
          "__v": 0
        },
        {
          "_id": "6622e26543b942a6934c8b5d",
          "title": "WI-FI",
          "titleI": "WI-FI",
          "description": "<p>no</p>",
          "descriptionI": "<p>no</p>",
          "weekDay": "no",
          "pricePerPerson": "no",
          "minimumPerson": "no",
          "visible": "no",
          "visibleToDate": "2024-04-20T00:00:00.000Z",
          "visibleFromDate": "2024-04-20T00:00:00.000Z",
          "position": "1",
          "image1": "wifi.png",
          "image2": "wifi.png",
          "image3": "wifi.png",
          "__v": 0
        },
        {
          "_id": "6622e29043b942a6934c8b60",
          "title": "Safe deposit box",
          "titleI": "Cassaforte",
          "description": "<p>no</p>",
          "descriptionI": "<p>no</p>",
          "weekDay": "no",
          "pricePerPerson": "no",
          "minimumPerson": "no",
          "visible": "no",
          "visibleToDate": "2024-04-27T00:00:00.000Z",
          "visibleFromDate": "2024-04-27T00:00:00.000Z",
          "position": "1",
          "image1": "safe-box.png",
          "image2": "safe-box.png",
          "image3": "safe-box.png",
          "__v": 0
        },
        {
          "_id": "6622e2ba43b942a6934c8b63",
          "title": "Phone",
          "titleI": "Telefono",
          "description": "<p>no</p>",
          "descriptionI": "<p>no</p>",
          "weekDay": "no",
          "pricePerPerson": "no",
          "minimumPerson": "no",
          "visible": "no",
          "visibleToDate": "2024-04-18T00:00:00.000Z",
          "visibleFromDate": "2024-04-18T00:00:00.000Z",
          "position": "1",
          "image1": "telephone.png",
          "image2": "telephone.png",
          "image3": "telephone.png",
          "__v": 0
        },
        {
          "_id": "6622e2e443b942a6934c8b66",
          "title": "Smart TV",
          "titleI": "Smart TV",
          "description": "<p>no</p>",
          "descriptionI": "<p>no</p>",
          "weekDay": "no",
          "pricePerPerson": "no",
          "minimumPerson": "no",
          "visible": "no",
          "visibleToDate": "2024-04-19T00:00:00.000Z",
          "visibleFromDate": "2024-04-18T00:00:00.000Z",
          "position": "1",
          "image1": "smart-tv.png",
          "image2": "smart-tv.png",
          "image3": "smart-tv.png",
          "__v": 0
        },
        {
          "_id": "6622e32643b942a6934c8b69",
          "title": "Coffee station",
          "titleI": "Coffee station",
          "description": "<p>no</p>",
          "descriptionI": "<p>no</p>",
          "weekDay": "no",
          "pricePerPerson": "no",
          "minimumPerson": "no",
          "visible": "no",
          "visibleToDate": "2024-04-20T00:00:00.000Z",
          "visibleFromDate": "2024-04-18T00:00:00.000Z",
          "position": "1",
          "image1": "coffee-cup.png",
          "image2": "coffee-cup.png",
          "image3": "coffee-cup.png",
          "__v": 0
        },
        {
          "_id": "6622e35f43b942a6934c8b6c",
          "title": "Kettle",
          "titleI": "Bollitore",
          "description": "<p>no</p>",
          "descriptionI": "<p>no</p>",
          "weekDay": "no",
          "pricePerPerson": "no",
          "minimumPerson": "no",
          "visible": "no",
          "visibleToDate": "2024-04-19T00:00:00.000Z",
          "visibleFromDate": "2024-04-19T00:00:00.000Z",
          "position": "1",
          "image1": "kettle.png",
          "image2": "kettle.png",
          "image3": "kettle.png",
          "__v": 0
        },
        {
          "_id": "6622e39043b942a6934c8b6f",
          "title": "Mini bar",
          "titleI": "Mini bar",
          "description": "<p>no</p>",
          "descriptionI": "<p>no</p>",
          "weekDay": "no",
          "pricePerPerson": "no",
          "minimumPerson": "no",
          "visible": "no",
          "visibleToDate": "2024-04-18T00:00:00.000Z",
          "visibleFromDate": "2024-04-18T00:00:00.000Z",
          "position": "1",
          "image1": "mini.png",
          "image2": "mini.png",
          "image3": "mini.png",
          "__v": 0
        },
        {
          "_id": "6622e5a043b942a6934c8b72",
          "title": "Snack drawer",
          "titleI": "Cassetto snack",
          "description": "<p>no</p>",
          "descriptionI": "<p>no</p>",
          "weekDay": "no",
          "pricePerPerson": "no",
          "minimumPerson": "no",
          "visible": "no",
          "visibleToDate": "2024-04-18T00:00:00.000Z",
          "visibleFromDate": "2024-04-18T00:00:00.000Z",
          "position": "1",
          "image1": "snack.png",
          "image2": "snack.png",
          "image3": "snack.png",
          "__v": 0
        },
        {
          "_id": "6622e5d343b942a6934c8b75",
          "title": "Hair dryer",
          "titleI": "Asciugacapelli",
          "description": "<p>no</p>",
          "descriptionI": "<p>no</p>",
          "weekDay": "no",
          "pricePerPerson": "no",
          "minimumPerson": "no",
          "visible": "no",
          "visibleToDate": "2024-04-18T00:00:00.000Z",
          "visibleFromDate": "2024-04-18T00:00:00.000Z",
          "position": "1",
          "image1": "hairdryer.png",
          "image2": "hairdryer.png",
          "image3": "hairdryer.png",
          "__v": 0
        },
        {
          "_id": "6622e62743b942a6934c8b78",
          "title": "Courtesy set",
          "titleI": "Set di cortesia",
          "description": "<p>no</p>",
          "descriptionI": "<p>no</p>",
          "weekDay": "no",
          "pricePerPerson": "no",
          "minimumPerson": "no",
          "visible": "no",
          "visibleToDate": "2024-04-18T00:00:00.000Z",
          "visibleFromDate": "2024-04-18T00:00:00.000Z",
          "position": "1",
          "image1": "towels.png",
          "image2": "towels.png",
          "image3": "towels.png",
          "__v": 0
        }
      ],
      "__v": 57
    };
    indexRoom = 0;
    List<dynamic> items = widget.data["servicesIds"]; // Assuming widget.data["servicesIds"] contains your list of items





    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx > 10) {
              Navigator.pop(context);
            }},
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: width / 25,top: 10 ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding:  EdgeInsets.only(bottom: 5),
                          child: Container(width: width / 10,
                              child:Icon(Icons.arrow_back,color: Color(0xFF777777),)
                          ),
                        ),
                      ),

                      Padding(
                        padding:  EdgeInsets.only(bottom: 5),
                        child: Container(
                          width: width / 1.5, // Adjust width as needed
                          child: Text(
                            language == true
                                ? widget.data["nameI"]
                                : widget.data["name"],
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
                        padding:  EdgeInsets.only(right: width/25,bottom: 10),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LanguageScreen()),
                            );
                          },
                          child: Container(
                            height: height / 25,
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
                      Container(
                        child: widget.data["images"].length != 0
                            ? InkWell(
                          onTap: () {
                            print(widget.data["images"][0]);
                          },
                          child: Hero(
                            tag:
                            "imageHero", // Unique tag for the Hero animation
                            child:
                            Container(
                              width: double.infinity,
                              height: height / 5.7,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: "http://85.31.236.78:3000/${widget.data["images"][0]}",
                                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Image.asset("assets/images/no.jpg",fit: BoxFit.cover,),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                            : Container(
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height / 10),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              widget.data["description"] != ""
                                  ? Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                width: width / 1.2,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: width / 12,
                                      right: width / 12,
                                      top: height / 30,
                                      bottom: height / 30),
                                  child: HtmlWidget(
                                    // the first parameter (`html`) is required
                                    language == true
                                        ? widget.data["descriptionI"]
                                        : widget.data["description"],

                                    // all other parameters are optional, a few notable params:

                                    // specify custom styling for an element
                                    // see supported inline styling below

                                    // this callback will be triggered when user taps a link

                                    // select the render mode for HTML body
                                    // by default, a simple `Column` is rendered
                                    // consider using `ListView` or `SliverList` for better performance
                                    renderMode: RenderMode.column,

                                    // set the default styling for text
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFB5B5B5),
                                      fontWeight: FontWeight.w600,
                                      fontFamily:
                                      GoogleFonts.montserrat().fontFamily,
                                    ),
                                  ),
                                  /* Text(
                                          widget.data["description"],
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13, color: Color(0xFFB5B5B5)),
                                        ),*/
                                ),
                              )
                                  : SizedBox(),
                              /*  Text(
                                              'Camere & Suite',
                                              style: GoogleFonts.montserrat(
                                                textStyle:
                                                TextStyle(color: Color(0xFF777777), fontSize: 14),
                                              ),
                                            ),*/
                            /*  SizedBox(
                                height: height / 13,
                              ),
                              widget.data["servicesIds"].length != 0
                                  ? Image.asset(
                                "assets/images/logo2.png",
                                scale: 1.9,
                              )
                                  : SizedBox(),
                              SizedBox(
                                height: height / 50,
                              ),
                              widget.data["servicesIds"].length != 0
                                  ? Text(
                                language == true
                                    ? "Cosa troverai nella tua camera"
                                    : "What you will find in your room",
                                style: GoogleFonts.montserrat(
                                    fontSize: 13, color: Color(0xFF777777)),
                              )
                                  : SizedBox(),
                              SizedBox(
                                height: height / 50,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: width / 14,
                                  right: width / 14,
                                ),
                                child:Column(
                                    children: generateGrid(items)
                                ),*//* GridView.builder(

                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent: height/5,
                                     mainAxisSpacing: 1,
                                    crossAxisCount: 2, // Number of columns
                                  ),
                                  physics: NeverScrollableScrollPhysics(),
                                  // Disable scrolling
                                  itemCount: widget.data["servicesIds"].length,
                                  // Number of grid items

                                  itemBuilder: (BuildContext context, int index) {
                                    return FractionallySizedBox(
                                      widthFactor: 0.60, // 25% of the width of the parent
                                      heightFactor: 0.60, // 10% of the height of the parent
                                      child: Container(

                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.1),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: 4, // Adjust as needed
                                            bottom: 4, // Adjust as needed
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 25, // Adjust as needed
                                                height: 15, // Adjust as needed
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      "http://85.31.236.78:3000/" + widget.data["servicesIds"][index]["image1"],
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4, // Adjust as needed
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(2),
                                                child: Text(
                                                  language == true
                                                      ? widget.data["servicesIds"][index]["titleI"]
                                                      : widget.data["servicesIds"][index]["title"],
                                                  maxLines: 2,
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFB5B5B5),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )*//*
                                *//*Row(
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
                                  ),*//*
                              ),
                              SizedBox(
                                height: height / 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width / 12, right: width / 12),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              language == false
                                                  ? "By proceeding, you will be redirected to our platform to check availability. Are you sure you want to continue?"
                                                  : "Proseguendo, verrai reindirizzato alla nostra piattaforma per verificare la disponibilità. Sei sicuro di voler continuare?",
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20,
                                                color: Color(0xFF777777),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () async {
                                                  Navigator.of(context).pop();

                                                  if (language == true) {
                                                    print(language);
                                                    if (!await launchUrl(Uri.parse(
                                                        "https://reservations.verticalbooking.com/premium/index.html?id_albergo=22576&dc=6945&id_stile=16986&lingua_int=ita"))) {
                                                      throw Exception(
                                                          'Could not launch');
                                                    }
                                                  } else {
                                                    if (!await launchUrl(Uri.parse(
                                                        "https://reservations.verticalbooking.com/premium/index.html?id_albergo=22576&dc=6945&id_stile=16986&lingua_int=eng"))) {
                                                      throw Exception(
                                                          'Could not launch');
                                                    }
                                                  }
                                                },
                                                child: Text(
                                                  language == true
                                                      ? "Conferma"
                                                      : "Confirm",
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                    color: Color(0xFF8089BC),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                    language == true
                                                        ? "Annulla"
                                                        : "Cancel",
                                                    style: GoogleFonts.montserrat(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 15,
                                                      color: Color(0xFF8089BC),
                                                    )),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF289DD1),
                                      // Use the color code #289DD1
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20), // Set border radius to 20 for rounded corners
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Text(
                                        language == true
                                            ? 'Verifica disponibilità'
                                            : "Check availability",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors
                                              .white, // Use the color code #B5B5B5
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height / 20,
                              ),
                              widget.data["images"].length != 1
                                  ? buildImages(
                                  widget.data["images"], height, width, context)
                                  : SizedBox(),*/
                              SizedBox(
                                height: MediaQuery.of(context).size.height/50,
                              ),
                              Container(
                                width: width / 1.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10)),
                                      width: width / 2.5,
                                      height: height/9,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: width / 12,
                                            right: width / 12,
                                            top: height / 30,
                                            bottom: height / 30),
                                        child: Text("skkls",   style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFFB5B5B5),
                                          fontWeight: FontWeight.w600,
                                          fontFamily:
                                          GoogleFonts.montserrat().fontFamily,
                                        ),),
                                        /* Text(
                                                widget.data["description"],
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 13, color: Color(0xFFB5B5B5)),
                                              ),*/
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10)),
                                      width: width / 2.5,
                                      height: height/9,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: width / 12,
                                            right: width / 12,
                                            top: height / 30,
                                            bottom: height / 30),
                                        child: Text("skkls",   style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFFB5B5B5),
                                          fontWeight: FontWeight.w600,
                                          fontFamily:
                                          GoogleFonts.montserrat().fontFamily,
                                        ),),
                                        /* Text(
                                                widget.data["description"],
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 13, color: Color(0xFFB5B5B5)),
                                              ),*/
                                      ),
                                    ),
                                  ],
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
            ],
          ),
        ),
      ),
    );
  }
}
/*
Widget buildImages(List<dynamic> servicesIds, double height, double width,var data,BuildContext context) {
  double imageHeight = height / 6; // Calculate the height for each image

  if (servicesIds.isEmpty) {
    return SizedBox.shrink(); // Return empty container if servicesIds list is empty
  } else if (servicesIds.length == 1) {
  print(data);
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
                child: InkWell(
                  onTap: (){

                  },
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
*/

/*
Widget buildImages(List<dynamic> servicesIds, double height, double width, var data, BuildContext context) {
  double imageHeight = height / 6; // Calculate the height for each image
print(servicesIds.length);
print("arslan");
  if (servicesIds.isEmpty) {
    return SizedBox.shrink(); // Return empty container if servicesIds list is empty
  } else if (servicesIds.length == 1) {
    return Padding(
      padding: EdgeInsets.only(left: width / 12, right: width / 12),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {

              },
              child: Hero(
                tag: 'service_${servicesIds[0]}', // Unique tag for the Hero animation
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
            ),
          ),
        ],
      ),
    );
  } else if (servicesIds.length == 2) {
    return Padding(
      padding: EdgeInsets.only(left: width / 12, right: width / 12),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                // Handle tap action
              },
              child: Hero(
                tag: 'service_${servicesIds[0]}', // Unique tag for the first Hero animation
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
            ),
          ),
          SizedBox(width: 10), // Adjust spacing between images
          Expanded(
            child: InkWell(
              onTap: () {
                // Handle tap action
              },
              child: Hero(
                tag: 'service_${servicesIds[1]}', // Unique tag for the second Hero animation
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
            ),
          ),
        ],
      ),
    );
  } else if (servicesIds.length == 3) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[0]}', // Unique tag for the first Hero animation
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
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[1]}', // Unique tag for the second Hero animation
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
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10), // Adjust spacing between rows
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: InkWell(
            onTap: () {
              // Handle tap action
            },
            child: Hero(
              tag: 'service_${servicesIds[2]}', // Unique tag for the third Hero animation
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
          ),
        ),
      ],
    );
  } else if (servicesIds.length == 4) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[0]}', // Unique tag for the first Hero animation
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
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[1]}', // Unique tag for the second Hero animation
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
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10), // Adjust spacing between rows
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: InkWell(
            onTap: () {

            },
            child: Hero(
              tag: 'service_${servicesIds[2]}', // Unique tag for the third Hero animation
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
          ),
        ),
      Container(width: 10,height: 10,color: Colors.transparent,),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[3]}', // Unique tag for the first Hero animation
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
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: Container(

                  height: imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),


      ],
    );
  }else if (servicesIds.length == 5) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[0]}', // Unique tag for the first Hero animation
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
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[1]}', // Unique tag for the second Hero animation
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
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10), // Adjust spacing between rows
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: InkWell(
            onTap: () {

            },
            child: Hero(
              tag: 'service_${servicesIds[2]}', // Unique tag for the third Hero animation
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
          ),
        ),
        Container(width: 10,height: 10,color: Colors.transparent,),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[3]}', // Unique tag for the first Hero animation
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage("http://85.31.236.78:3000/${servicesIds[3]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[4]}', // Unique tag for the second Hero animation
                    child: Container(

                      height: height/3+10,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("http://85.31.236.78:3000/${servicesIds[4]}"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),


      ],
    );
  }else if (servicesIds.length == 6) {
    print("here six");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[0]}', // Unique tag for the first Hero animation
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
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[1]}', // Unique tag for the second Hero animation
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
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10), // Adjust spacing between rows
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: InkWell(
            onTap: () {

            },
            child: Hero(
              tag: 'service_${servicesIds[2]}', // Unique tag for the third Hero animation
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
          ),
        ),
        Container(width: 10,height: 10,color: Colors.transparent,),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        // Handle tap action
                      },
                      child: Hero(
                        tag: 'service_${servicesIds[3]}', // Unique tag for the first Hero animation
                        child: Container(

                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage("http://85.31.236.78:3000/${servicesIds[3]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        // Handle tap action
                      },
                      child: Hero(
                        tag: 'service_${servicesIds[5]}', // Unique tag for the first Hero animation
                        child: Container(
                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage("http://85.31.236.78:3000/${servicesIds[5]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[4]}', // Unique tag for the second Hero animation
                    child: Container(

                      height: height/3+10,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("http://85.31.236.78:3000/${servicesIds[4]}"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),


      ],
    );
  }else if (servicesIds.length == 7) {
    print("here seven");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[0]}', // Unique tag for the first Hero animation
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
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[1]}', // Unique tag for the second Hero animation
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
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10), // Adjust spacing between rows
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: InkWell(
            onTap: () {

            },
            child: Hero(
              tag: 'service_${servicesIds[2]}', // Unique tag for the third Hero animation
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
          ),
        ),
        Container(width: 10,height: 10,color: Colors.transparent,),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        // Handle tap action
                      },
                      child: Hero(
                        tag: 'service_${servicesIds[3]}', // Unique tag for the first Hero animation
                        child: Container(

                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage("http://85.31.236.78:3000/${servicesIds[3]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        // Handle tap action
                      },
                      child: Hero(
                        tag: 'service_${servicesIds[5]}', // Unique tag for the first Hero animation
                        child: Container(
                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage("http://85.31.236.78:3000/${servicesIds[5]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[4]}', // Unique tag for the second Hero animation
                    child: Container(

                      height: height/3+10,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("http://85.31.236.78:3000/${servicesIds[4]}"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: InkWell(
            onTap: () {

            },
            child: Hero(
              tag: 'service_${servicesIds[6]}', // Unique tag for the third Hero animation
              child: Container(
                height: imageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage("http://85.31.236.78:3000/${servicesIds[6]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
  else if (servicesIds.length == 8) {
    print("here seven");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[0]}', // Unique tag for the first Hero animation
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
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[1]}', // Unique tag for the second Hero animation
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
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10), // Adjust spacing between rows
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: InkWell(
            onTap: () {

            },
            child: Hero(
              tag: 'service_${servicesIds[2]}', // Unique tag for the third Hero animation
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
          ),
        ),
        Container(width: 10,height: 10,color: Colors.transparent,),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        // Handle tap action
                      },
                      child: Hero(
                        tag: 'service_${servicesIds[3]}', // Unique tag for the first Hero animation
                        child: Container(

                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage("http://85.31.236.78:3000/${servicesIds[3]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        // Handle tap action
                      },
                      child: Hero(
                        tag: 'service_${servicesIds[5]}', // Unique tag for the first Hero animation
                        child: Container(
                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage("http://85.31.236.78:3000/${servicesIds[5]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[4]}', // Unique tag for the second Hero animation
                    child: Container(

                      height: height/3+10,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("http://85.31.236.78:3000/${servicesIds[4]}"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: InkWell(
            onTap: () {

            },
            child: Hero(
              tag: 'service_${servicesIds[6]}', // Unique tag for the third Hero animation
              child: Container(
                height: imageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage("http://85.31.236.78:3000/${servicesIds[6]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[7]}', // Unique tag for the first Hero animation
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage("http://85.31.236.78:3000/${servicesIds[7]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Container(
                  height: imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),

                  ),
                ),
              ),
           // Adjust spacing between images

            ],
          ),
        ),

      ],
    );
  }
  else if (servicesIds.length == 9) {
    print("here seven");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[0]}', // Unique tag for the first Hero animation
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
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[1]}', // Unique tag for the second Hero animation
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
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10), // Adjust spacing between rows
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: InkWell(
            onTap: () {

            },
            child: Hero(
              tag: 'service_${servicesIds[2]}', // Unique tag for the third Hero animation
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
          ),
        ),
        Container(width: 10,height: 10,color: Colors.transparent,),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        // Handle tap action
                      },
                      child: Hero(
                        tag: 'service_${servicesIds[3]}', // Unique tag for the first Hero animation
                        child: Container(

                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage("http://85.31.236.78:3000/${servicesIds[3]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        // Handle tap action
                      },
                      child: Hero(
                        tag: 'service_${servicesIds[5]}', // Unique tag for the first Hero animation
                        child: Container(
                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage("http://85.31.236.78:3000/${servicesIds[5]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[4]}', // Unique tag for the second Hero animation
                    child: Container(

                      height: height/3+10,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("http://85.31.236.78:3000/${servicesIds[4]}"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: InkWell(
            onTap: () {

            },
            child: Hero(
              tag: 'service_${servicesIds[6]}', // Unique tag for the third Hero animation
              child: Container(
                height: imageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage("http://85.31.236.78:3000/${servicesIds[6]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[7]}', // Unique tag for the first Hero animation
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage("http://85.31.236.78:3000/${servicesIds[7]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle tap action
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[8]}', // Unique tag for the first Hero animation
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage("http://85.31.236.78:3000/${servicesIds[8]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Adjust spacing between images

            ],
          ),
        ),

      ],
    );
  }
  else {
    return SizedBox.shrink(); // Handle other cases if needed
  }
}
*/

Widget buildImages(List<dynamic> servicesIds, double height, double width,
    BuildContext context) {
  double imageHeight = height / 6; // Calculate the height for each image

  if (servicesIds.isEmpty) {
    return SizedBox
        .shrink(); // Return empty container if servicesIds list is empty
  } else if (servicesIds.length == 1) {
    return Padding(
      padding: EdgeInsets.only(left: width / 12, right: width / 12),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BlackScreenWithImage(data: servicesIds),
                  ),
                );
              },
              child: Hero(
                tag: 'service_${servicesIds[0]}',
                child: Container(
                  height: imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          "http://85.31.236.78:3000/${servicesIds[0]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } else if (servicesIds.length == 2) {
    return Padding(
      padding: EdgeInsets.only(left: width / 12, right: width / 12),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                servicesIds.clear();
                String? jsonString = prefs.getString('dynamicList');
                List<dynamic> list = jsonDecode(jsonString!);
                servicesIds = list;
                var tappedService = servicesIds[0];
                servicesIds.removeAt(0);
                servicesIds.insert(0, tappedService);

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BlackScreenWithImage(data: servicesIds),
                  ),
                );
              },
              child: Hero(
                tag: 'service_${servicesIds[0]}',
                child: Container(
                  height: imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          "http://85.31.236.78:3000/${servicesIds[0]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                servicesIds.clear();
                String? jsonString = prefs.getString('dynamicList');
                List<dynamic> list = jsonDecode(jsonString!);
                servicesIds = list;
                var tappedService = servicesIds[1];
                servicesIds.removeAt(1);
                servicesIds.insert(0, tappedService);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BlackScreenWithImage(data: servicesIds),
                  ),
                );
              },
              child: Hero(
                tag: 'service_${servicesIds[1]}',
                child: Container(
                  height: imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          "http://85.31.236.78:3000/${servicesIds[1]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } else if (servicesIds.length == 3) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Container(
            color: Colors.yellow,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                      servicesIds.clear();
                      String? jsonString = prefs.getString('dynamicList');
                      List<dynamic> list = jsonDecode(jsonString!);
                      servicesIds = list;

                      var tappedService = servicesIds[0];
                      servicesIds.removeAt(0);
                      servicesIds.insert(0, tappedService);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BlackScreenWithImage(data: servicesIds),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'service_${servicesIds[0]}',
                      child: Container(
                        height: imageHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                                "http://85.31.236.78:3000/${servicesIds[0]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      servicesIds.clear();
                      String? jsonString = prefs.getString('dynamicList');
                      List<dynamic> list = jsonDecode(jsonString!);
                      servicesIds = list;
                      var tappedService = servicesIds[1];
                      servicesIds.removeAt(1);
                      servicesIds.insert(0, tappedService);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BlackScreenWithImage(data: servicesIds),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'service_${servicesIds[1]}',
                      child: Container(
                        height: imageHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                                "http://85.31.236.78:3000/${servicesIds[1]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            servicesIds.clear();
            String? jsonString = prefs.getString('dynamicList');
            List<dynamic> list = jsonDecode(jsonString!);
            servicesIds = list;

            var tappedService = servicesIds[2];
            servicesIds.removeAt(2);
            servicesIds.insert(0, tappedService);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlackScreenWithImage(data: servicesIds),
              ),
            );
          },
          child: Container(
            color: Colors.red,
            child: Padding(
              padding: EdgeInsets.only(left: width / 12, right: width / 12),
              child: Hero(
                tag: 'service_${servicesIds[2]}',
                child: Container(
                  height: imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          "http://85.31.236.78:3000/${servicesIds[2]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  } else if (servicesIds.length == 4) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[0];
                    servicesIds.removeAt(0);
                    servicesIds.insert(0, tappedService);

                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[0]}',
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[0]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[1];
                    servicesIds.removeAt(1);
                    servicesIds.insert(0, tappedService);

                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[1]}',
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[1]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: GestureDetector(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              servicesIds.clear();
              String? jsonString = prefs.getString('dynamicList');
              List<dynamic> list = jsonDecode(jsonString!);
              servicesIds = list;
              var tappedService = servicesIds[2];
              servicesIds.removeAt(2);
              servicesIds.insert(0, tappedService);
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlackScreenWithImage(data: servicesIds),
                ),
              );
            },
            child: Hero(
              tag: 'service_${servicesIds[2]}',
              child: Container(
                height: imageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        "http://85.31.236.78:3000/${servicesIds[2]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[3];
                    servicesIds.removeAt(3);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[3]}',
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[3]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  } else if (servicesIds.length == 5) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[0];
                    servicesIds.removeAt(0);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[0]}',
                    // Unique tag for the first Hero animation
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[0]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[1];
                    servicesIds.removeAt(1);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[1]}',
                    // Unique tag for the second Hero animation
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[1]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
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
          child: InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              servicesIds.clear();
              String? jsonString = prefs.getString('dynamicList');
              List<dynamic> list = jsonDecode(jsonString!);
              servicesIds = list;
              var tappedService = servicesIds[2];
              servicesIds.removeAt(2);
              servicesIds.insert(0, tappedService);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlackScreenWithImage(data: servicesIds),
                ),
              );
            },
            child: Hero(
              tag: 'service_${servicesIds[2]}',
              // Unique tag for the third Hero animation
              child: Container(
                height: imageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        "http://85.31.236.78:3000/${servicesIds[2]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 10,
          height: 10,
          color: Colors.transparent,
        ),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[3];
                    servicesIds.removeAt(3);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[3]}',
                    // Unique tag for the first Hero animation
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[3]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[4];
                    servicesIds.removeAt(4);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[4]}',
                    // Unique tag for the second Hero animation
                    child: Container(
                      height: height / 3 + 10,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[4]}"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  } else if (servicesIds.length == 6) {
    print("here six");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[0];
                    servicesIds.removeAt(0);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[0]}',
                    // Unique tag for the first Hero animation
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[0]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[1];
                    servicesIds.removeAt(1);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[1]}',
                    // Unique tag for the second Hero animation
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[1]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
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
          child: InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              servicesIds.clear();
              String? jsonString = prefs.getString('dynamicList');
              List<dynamic> list = jsonDecode(jsonString!);
              servicesIds = list;
              var tappedService = servicesIds[2];
              servicesIds.removeAt(2);
              servicesIds.insert(0, tappedService);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlackScreenWithImage(data: servicesIds),
                ),
              );
            },
            child: Hero(
              tag: 'service_${servicesIds[2]}',
              // Unique tag for the third Hero animation
              child: Container(
                height: imageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        "http://85.31.236.78:3000/${servicesIds[2]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 10,
          height: 10,
          color: Colors.transparent,
        ),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        servicesIds.clear();
                        String? jsonString = prefs.getString('dynamicList');
                        List<dynamic> list = jsonDecode(jsonString!);
                        servicesIds = list;
                        var tappedService = servicesIds[3];
                        servicesIds.removeAt(3);
                        servicesIds.insert(0, tappedService);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BlackScreenWithImage(data: servicesIds),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'service_${servicesIds[3]}',
                        // Unique tag for the first Hero animation
                        child: Container(
                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "http://85.31.236.78:3000/${servicesIds[3]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        servicesIds.clear();
                        String? jsonString = prefs.getString('dynamicList');
                        List<dynamic> list = jsonDecode(jsonString!);
                        servicesIds = list;
                        var tappedService = servicesIds[5];
                        servicesIds.removeAt(5);
                        servicesIds.insert(0, tappedService);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BlackScreenWithImage(data: servicesIds),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'service_${servicesIds[5]}',
                        // Unique tag for the first Hero animation
                        child: Container(
                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "http://85.31.236.78:3000/${servicesIds[5]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[4];
                    servicesIds.removeAt(4);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[4]}',
                    // Unique tag for the second Hero animation
                    child: Container(
                      height: height / 3 + 10,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[4]}"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  } else if (servicesIds.length == 7) {
    print("here six");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[0];
                    servicesIds.removeAt(0);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[0]}',
                    // Unique tag for the first Hero animation
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[0]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[1];
                    servicesIds.removeAt(1);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[1]}',
                    // Unique tag for the second Hero animation
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[1]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
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
          child: InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              servicesIds.clear();
              String? jsonString = prefs.getString('dynamicList');
              List<dynamic> list = jsonDecode(jsonString!);
              servicesIds = list;
              var tappedService = servicesIds[2];
              servicesIds.removeAt(2);
              servicesIds.insert(0, tappedService);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlackScreenWithImage(data: servicesIds),
                ),
              );
            },
            child: Hero(
              tag: 'service_${servicesIds[2]}',
              // Unique tag for the third Hero animation
              child: Container(
                height: imageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        "http://85.31.236.78:3000/${servicesIds[2]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 10,
          height: 10,
          color: Colors.transparent,
        ),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        servicesIds.clear();
                        String? jsonString = prefs.getString('dynamicList');
                        List<dynamic> list = jsonDecode(jsonString!);
                        servicesIds = list;
                        var tappedService = servicesIds[3];
                        servicesIds.removeAt(3);
                        servicesIds.insert(0, tappedService);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BlackScreenWithImage(data: servicesIds),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'service_${servicesIds[3]}',
                        // Unique tag for the first Hero animation
                        child: Container(
                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "http://85.31.236.78:3000/${servicesIds[3]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        servicesIds.clear();
                        String? jsonString = prefs.getString('dynamicList');
                        List<dynamic> list = jsonDecode(jsonString!);
                        servicesIds = list;
                        var tappedService = servicesIds[5];
                        servicesIds.removeAt(5);
                        servicesIds.insert(0, tappedService);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BlackScreenWithImage(data: servicesIds),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'service_${servicesIds[5]}',
                        // Unique tag for the first Hero animation
                        child: Container(
                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "http://85.31.236.78:3000/${servicesIds[5]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[4];
                    servicesIds.removeAt(4);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[4]}',
                    // Unique tag for the second Hero animation
                    child: Container(
                      height: height / 3 + 10,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[4]}"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),
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
          child: InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              servicesIds.clear();
              String? jsonString = prefs.getString('dynamicList');
              List<dynamic> list = jsonDecode(jsonString!);
              servicesIds = list;
              var tappedService = servicesIds[6];
              servicesIds.removeAt(6);
              servicesIds.insert(0, tappedService);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlackScreenWithImage(data: servicesIds),
                ),
              );
            },
            child: Hero(
              tag: 'service_${servicesIds[2]}',
              // Unique tag for the third Hero animation
              child: Container(
                height: imageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        "http://85.31.236.78:3000/${servicesIds[6]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  } else if (servicesIds.length == 8) {
    print("here six");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[0];
                    servicesIds.removeAt(0);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[0]}',
                    // Unique tag for the first Hero animation
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[0]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[1];
                    servicesIds.removeAt(1);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[1]}',
                    // Unique tag for the second Hero animation
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[1]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
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
          child: InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              servicesIds.clear();
              String? jsonString = prefs.getString('dynamicList');
              List<dynamic> list = jsonDecode(jsonString!);
              servicesIds = list;
              var tappedService = servicesIds[2];
              servicesIds.removeAt(2);
              servicesIds.insert(0, tappedService);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlackScreenWithImage(data: servicesIds),
                ),
              );
            },
            child: Hero(
              tag: 'service_${servicesIds[2]}',
              // Unique tag for the third Hero animation
              child: Container(
                height: imageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        "http://85.31.236.78:3000/${servicesIds[2]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 10,
          height: 10,
          color: Colors.transparent,
        ),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        servicesIds.clear();
                        String? jsonString = prefs.getString('dynamicList');
                        List<dynamic> list = jsonDecode(jsonString!);
                        servicesIds = list;
                        var tappedService = servicesIds[3];
                        servicesIds.removeAt(3);
                        servicesIds.insert(0, tappedService);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BlackScreenWithImage(data: servicesIds),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'service_${servicesIds[3]}',
                        // Unique tag for the first Hero animation
                        child: Container(
                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "http://85.31.236.78:3000/${servicesIds[3]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        servicesIds.clear();
                        String? jsonString = prefs.getString('dynamicList');
                        List<dynamic> list = jsonDecode(jsonString!);
                        servicesIds = list;
                        var tappedService = servicesIds[5];
                        servicesIds.removeAt(5);
                        servicesIds.insert(0, tappedService);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BlackScreenWithImage(data: servicesIds),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'service_${servicesIds[5]}',
                        // Unique tag for the first Hero animation
                        child: Container(
                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "http://85.31.236.78:3000/${servicesIds[5]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[4];
                    servicesIds.removeAt(4);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[4]}',
                    // Unique tag for the second Hero animation
                    child: Container(
                      height: height / 3 + 10,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[4]}"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),
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
          child: InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              servicesIds.clear();
              String? jsonString = prefs.getString('dynamicList');
              List<dynamic> list = jsonDecode(jsonString!);
              servicesIds = list;
              var tappedService = servicesIds[6];
              servicesIds.removeAt(6);
              servicesIds.insert(0, tappedService);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlackScreenWithImage(data: servicesIds),
                ),
              );
            },
            child: Hero(
              tag: 'service_${servicesIds[2]}',
              // Unique tag for the third Hero animation
              child: Container(
                height: imageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        "http://85.31.236.78:3000/${servicesIds[6]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[7];
                    servicesIds.removeAt(7);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[0]}',
                    // Unique tag for the first Hero animation
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[7]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  } else if (servicesIds.length == 9) {
    print("here six");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[0];
                    servicesIds.removeAt(0);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[0]}',
                    // Unique tag for the first Hero animation
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[0]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[1];
                    servicesIds.removeAt(1);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[1]}',
                    // Unique tag for the second Hero animation
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[1]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
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
          child: InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              servicesIds.clear();
              String? jsonString = prefs.getString('dynamicList');
              List<dynamic> list = jsonDecode(jsonString!);
              servicesIds = list;
              var tappedService = servicesIds[2];
              servicesIds.removeAt(2);
              servicesIds.insert(0, tappedService);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlackScreenWithImage(data: servicesIds),
                ),
              );
            },
            child: Hero(
              tag: 'service_${servicesIds[2]}',
              // Unique tag for the third Hero animation
              child: Container(
                height: imageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        "http://85.31.236.78:3000/${servicesIds[2]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 10,
          height: 10,
          color: Colors.transparent,
        ),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        servicesIds.clear();
                        String? jsonString = prefs.getString('dynamicList');
                        List<dynamic> list = jsonDecode(jsonString!);
                        servicesIds = list;
                        var tappedService = servicesIds[3];
                        servicesIds.removeAt(3);
                        servicesIds.insert(0, tappedService);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BlackScreenWithImage(data: servicesIds),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'service_${servicesIds[3]}',
                        // Unique tag for the first Hero animation
                        child: Container(
                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "http://85.31.236.78:3000/${servicesIds[3]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        servicesIds.clear();
                        String? jsonString = prefs.getString('dynamicList');
                        List<dynamic> list = jsonDecode(jsonString!);
                        servicesIds = list;
                        var tappedService = servicesIds[5];
                        servicesIds.removeAt(5);
                        servicesIds.insert(0, tappedService);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BlackScreenWithImage(data: servicesIds),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'service_${servicesIds[5]}',
                        // Unique tag for the first Hero animation
                        child: Container(
                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "http://85.31.236.78:3000/${servicesIds[5]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[4];
                    servicesIds.removeAt(4);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[4]}',
                    // Unique tag for the second Hero animation
                    child: Container(
                      height: height / 3 + 10,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[4]}"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),
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
          child: InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              servicesIds.clear();
              String? jsonString = prefs.getString('dynamicList');
              List<dynamic> list = jsonDecode(jsonString!);
              servicesIds = list;
              var tappedService = servicesIds[6];
              servicesIds.removeAt(6);
              servicesIds.insert(0, tappedService);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlackScreenWithImage(data: servicesIds),
                ),
              );
            },
            child: Hero(
              tag: 'service_${servicesIds[6]}',
              // Unique tag for the third Hero animation
              child: Container(
                height: imageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        "http://85.31.236.78:3000/${servicesIds[6]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: width / 12, right: width / 12),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[7];
                    servicesIds.removeAt(7);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[7]}',
                    // Unique tag for the first Hero animation
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[7]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images
              Expanded(
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    servicesIds.clear();
                    String? jsonString = prefs.getString('dynamicList');
                    List<dynamic> list = jsonDecode(jsonString!);
                    servicesIds = list;
                    var tappedService = servicesIds[8];
                    servicesIds.removeAt(8);
                    servicesIds.insert(0, tappedService);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlackScreenWithImage(data: servicesIds),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'service_${servicesIds[8]}',
                    // Unique tag for the first Hero animation
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://85.31.236.78:3000/${servicesIds[8]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  else {
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

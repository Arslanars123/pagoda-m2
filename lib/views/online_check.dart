import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/providers/checkin_providers.dart';
import 'package:pagoda/utils/widgets.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../providers/check-in-provider.dart';
import '../utils/global.dart';
import 'language.dart';

class OnlineCheckIn extends StatefulWidget {
  const OnlineCheckIn({super.key});

  @override
  State<OnlineCheckIn> createState() => _OnlineCheckInState();
}

class _OnlineCheckInState extends State<OnlineCheckIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController  numberController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isChecked = false;
  DateTime selectedDate = DateTime.now();
  DateTime selectedDateDep = DateTime.now();

  String? name = language == true ?"Documento di riconoscimento":"Identity card";
  Future<void> _showFilePickerBottomSheet() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedImage = File(result.files.single.path!);
        var get = path.basename(selectedImage!.path);
        name = get.toString();
        print(name);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final checkInProvider =
        Provider.of<CheckInProvider>(context, listen: false);
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),

          locale: Locale(language == true ?'it':"en")
      );
      if (picked != null && picked != selectedDate) {
        print(selectedDate);
        setState(() {
          selectedDate = picked;
        });
        setState(() {
          checkInProvider.dateArriveController.text =
              selectedDate.year.toString() +
                  "-" +
                  selectedDate.month.toString() +
                  "-" +
                  selectedDate.day.toString();
        });
      } else {
        setState(() {
          checkInProvider.dateArriveController.text =
              selectedDate.year.toString() +
                  "-" +
                  selectedDate.month.toString() +
                  "-" +
                  selectedDate.day.toString();
        });
        print(checkInProvider.dateArriveController.text);
      }
    }

    Future<void> _selectDateDeparture(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateDep,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != selectedDateDep) {
        setState(() {
          selectedDateDep = picked;
        });
        setState(() {
          checkInProvider.dateDepartureController.text =
              selectedDateDep.year.toString() +
                  "-" +
                  selectedDateDep.month.toString() +
                  "-" +
                  selectedDateDep.day.toString();
        });
      } else {
        setState(() {
          checkInProvider.dateDepartureController.text =
              selectedDateDep.year.toString() +
                  "-" +
                  selectedDateDep.month.toString() +
                  "-" +
                  selectedDateDep.day.toString();
        });
        print(checkInProvider.dateDepartureController.text);
      }
    }


    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String hintTextName = language ? "Nome e Cognome" : "Surname and Name";
    String hintTextPhone  = language ? "Telefono" : "Telephone number";
    String hintTextEmail = language ? "E-mail" : "E-mail address";
    String hintTextDateArrive = language ? "Data di arrivo" : "Check-in date";
    String hintTextDateDeparture =
        language ? "Data di partenza" : "Check-out date";
    String hintTextReservationCode = language
        ? "Codice di prenotazione (es:1222463)"
        : "Reservation code (es:1222463)";

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
                    left: width / 25,top: 5 ),
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

                      Expanded(
                        child: Text(
                          textAlign: TextAlign.center,
                          "Check-in",

                          style: GoogleFonts.montserrat(
                            fontWeight:
                            FontWeight.w600, // Semi-bold style
                            fontSize: 20,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(right: width/25,bottom: 5),
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
                      Column(
                        children: [
                          checkinImage != null ?     Container(
                            width: double.infinity, // Set width of the container
                            height: height / 5.7, // Set height of the container
                            child: CachedNetworkImage(
                              imageUrl: 'http://85.31.236.78:3000/' + checkinImage, // Network image URL
                              placeholder: (context, url) => SizedBox(), // Placeholder widget while loading
                              errorWidget: (context, url, error) => Container(
                             // Set height of the container
                                decoration: BoxDecoration(
                                  // Box decoration with image
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/no.jpg"),
                                    // Provide your image path here
                                    fit: BoxFit
                                        .cover, // This will contain (cover) the image within the container
                                  ),
                                ),
                              ), // Widget to display when image fails to load
                              fit: BoxFit.cover, // This will contain (cover) the image within the container
                            ),
                          ):Container(
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

                          SizedBox(
                            height: height / 4,
                          ),

                        ],
                      ),
                           description4 != null && description4.toString().isNotEmpty ?        Padding(
                        padding: EdgeInsets.only(top: height / 8),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),

                                width: width / 1.2,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: width / 12, right: width / 12, top: height / 30,bottom: height / 30),
                                  child:  HtmlWidget(
                                    // the first parameter (`html`) is required
                                   description4,

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
                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: height/15,),
                              Padding(
                                padding: EdgeInsets.only(left: width / 12, right: width / 12),
                                child: Column(
                                  children: [
                                    MyTextField(
                                      hintText: hintTextName,
                                      controller: checkInProvider.nameController,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    MyTextField(
                                      hintText: hintTextPhone,
                                      controller: checkInProvider.PhoneController,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    MyTextField(
                                      hintText: hintTextEmail,
                                      controller: checkInProvider.emailController,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            _selectDate(context);
                                          },
                                          child: Container(
                                              width: width / 2.5,
                                              child: MyTextFieldDrop(
                                                hintText: hintTextDateArrive,
                                                controller:
                                                checkInProvider.dateArriveController,
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _selectDateDeparture(context);
                                          },
                                          child: Container(
                                              width: width / 2.5,
                                              child: MyTextFieldDrop(
                                                hintText: hintTextDateDeparture,
                                                controller:
                                                checkInProvider.dateDepartureController,
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    MyTextField(
                                      hintText: hintTextReservationCode,
                                      controller: checkInProvider.reservationCodeController,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          height: height / 6,
                                          // Set container height
                                          width: double.infinity,
                                          // Set container width to fill available space
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.grey.withOpacity(0.8),
                                              // Set border color
                                              width: 1.0, // Set border width
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            // Add padding inside container
                                            child: Text(
                                              name.toString(),
                                              textAlign: TextAlign.left,
                                              // Align text to the top left
                                              style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFC1C7D9)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: height / 6,
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(top: height / 30),
                                              child: SizedBox(
                                                width: width / 2.3,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(

                                                          title: Text(language == false ?"You are about to upload your identification document. Do you want to proceed with this operation? Confirm to continue or cancel to stop.":"Stai per caricare il tuo documento di identità. Vuoi procedere con questa operazione? Conferma per continuare o annulla per interrompere.",  style: GoogleFonts.montserrat(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 17,
                                                            color: Color(0xFF777777),
                                                          ),),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                                _showFilePickerBottomSheet();

                                                              },
                                                              child: Text(language == true ?"Conferma":"Confirm",  style: GoogleFonts.montserrat(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 15,
                                                                color: Color(0xFF8089BC),
                                                              ),),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: Text(language == true ?"Annulla":"Cancel",style: GoogleFonts.montserrat(
                                                                fontWeight: FontWeight.w500,
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
                                                    backgroundColor:
                                                    Color(0xFF979797).withOpacity(0.35),
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
                                                      language == true ? 'CARICA' : "Load",
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
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isChecked = !isChecked;
                                            });
                                          },
                                          child: Container(
                                            width: 20.0,
                                            height: 20.0,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey.withOpacity(0.8),
                                                width: 1.0,
                                              ),
                                            ),
                                            child: isChecked
                                                ? Icon(
                                              Icons.check,
                                              color: Colors.black,
                                              size: 20.0,
                                            )
                                                : null,
                                          ),
                                        ),
                                        SizedBox(
                                          width: width / 40,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              child: Text(
                                               language == true ? "Acconsento all’utilizzo  ":"I agree with the use of my data. .",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 12,

                                                  fontWeight: FontWeight.w600,
                                                  color: Color(
                                                      0xFF6478AF), // Use the color code #B5B5B5
                                                ),
                                              ),
                                            ),

                                          ],
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 29),
                                      child: Row(
                                        children: [
                                          Text(
                                            language == true ? "dei miei dati. ":"Read the. ",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,

                                              fontWeight: FontWeight.w600,
                                              color: Color(
                                                  0xFF6478AF), // Use the color code #B5B5B5
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Provider.of<PolicyData>(context,
                                                  listen: false)
                                                  .fetchData()
                                                  .then((_) {
                                                // Show dialog with fetched data
                                                showDialog(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                    title: Text(language == true ? "Privacy Policy":"Privacy Policy"),
                                                    content: Consumer<PolicyData>(
                                                      builder:
                                                          (context, policyData, child) {
                                                        return Html(data: policyData.data,style:  {
                                                          '#': Style(
                                                            maxLines: 5,
                                                            textOverflow: TextOverflow.ellipsis,
                                                            color: Color(0xFF404040),
                                                            fontWeight: FontWeight.w600,
                                                            fontFamily: GoogleFonts.montserrat().fontFamily,
                                                          ),
                                                        },);
                                                      },
                                                    ),

                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(context),
                                                        child: Text(language == true? "OK":'Close', style: GoogleFonts.montserrat(
                                                          decoration: TextDecoration.underline,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w600,
                                                          color: Color(
                                                              0xFF6478AF), // Use the color code #B5B5B5
                                                        ),),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).catchError((error) {
                                                // Show error dialog
                                                showDialog(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                    title: Text('Error'),
                                                    content: Text(error.toString()),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(context),
                                                        child: Text(language == true? "OK":'OK', style: GoogleFonts.montserrat(
                                                          decoration: TextDecoration.underline,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w600,
                                                          color: Color(
                                                              0xFF6478AF), // Use the color code #B5B5B5
                                                        ),),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                            },
                                            child: Text(
                                              'Privacy Policy',
                                              style: GoogleFonts.montserrat(
                                                decoration: TextDecoration.underline,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(
                                                    0xFF6478AF), // Use the color code #B5B5B5
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print(checkInProvider.dateDepartureController.text);
                                          if (selectedImage == null ||
                                              selectedImage!.path.isEmpty ||
                                              checkInProvider.emailController.text.isEmpty ||
                                              checkInProvider
                                                  .reservationCodeController.text.isEmpty ||
                                              checkInProvider
                                                  .dateArriveController.text.isEmpty ||
                                              checkInProvider
                                                  .dateDepartureController.text.isEmpty ||
                                              checkInProvider.PhoneController.text.isEmpty ||
                                              checkInProvider.nameController.text.isEmpty ||
                                              isChecked == false) {
                                            Fluttertoast.showToast(
                                                msg: language == true ?"Per favore completa tutti i campi":"Please fill all the fields",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Color(0xFF289DD1),
                                                textColor: Colors.white,
                                                fontSize: 12.0);
                                          } else {
                                            // All parameters are valid, proceed with postData method
                                            checkInProvider.postData(
                                              context,
                                              selectedImage!.path,
                                              checkInProvider.emailController.text,
                                              checkInProvider.reservationCodeController.text,
                                              checkInProvider.dateArriveController.text,
                                              checkInProvider.dateDepartureController.text,
                                              checkInProvider.PhoneController.text,
                                              checkInProvider.nameController.text,
                                            );
                                          }

                                          /*          Navigator.pushReplacementNamed(context, '/success');*/
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
                                            language == true ? 'Conferma':"Conferma",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color:
                                              Colors.white, // Use the color code #B5B5B5
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ):SizedBox()
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

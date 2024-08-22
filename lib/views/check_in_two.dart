import 'dart:convert';
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
import 'package:intl/intl.dart';
import 'package:pagoda/other_pages.dart';
import 'package:pagoda/providers/checkin_providers.dart';
import 'package:pagoda/utils/widgets.dart';
import 'package:pagoda/views/home.dart';
import 'package:pagoda/views/language.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/check-in-provider.dart';
import '../utils/global.dart';

class OnlineCheckInTwo extends StatefulWidget {
  const OnlineCheckInTwo({super.key});

  @override
  State<OnlineCheckInTwo> createState() => _OnlineCheckInState();
}

class _OnlineCheckInState extends State<OnlineCheckInTwo> {
  bool isLoading = false;
  bool hasError = false;
    bool? hasDeparturePassed;
  Map<String, dynamic>? responseData;
  DateTime _parseDate(String dateString) {
    try {
      return DateFormat('yyyy-M-d').parse(dateString);
    } catch (e) {
      return DateTime.now(); // Default to current date if parsing fails
    }
  }
  Future<void> postUserId() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    final url = 'http://85.31.236.78:3000/get-check-info';

    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'userId': pref.getString("userId"),
        }),
      );
var userId = pref.getString("userId");
print(response.statusCode);
      if (response.statusCode == 200) {
        print(responseData);
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          responseData = data.firstWhere(
            (item) => item['userId'] == userId,
            orElse: () => null,
          );
        });
        final String dateDepartureString = responseData!['dateDeparture'];
final DateTime dateDeparture = _parseDate(dateDepartureString);
final DateTime currentDate = DateTime.now().toUtc(); // Ensure it's in UTC

hasDeparturePassed = currentDate.isAfter(dateDeparture);
print(currentDate);
print(dateDeparture);
print("here by default");
print(hasDeparturePassed);
print(responseData!["dateDeparture"]);

      } else {
        print("in else condition");
        print(responseData);
        setState(() {
          hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
   @override
  void initState() {
    super.initState();
    postUserId(); // Call the method to fetch data
  }
  TextEditingController emailController = TextEditingController();
  TextEditingController  numberController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isChecked = false;
  DateTime selectedDate = DateTime.now();
  DateTime selectedDateDep = DateTime.now();
  File? selectedImage;
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

 final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
          locale: Locale(language == true ?'it':"en")
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

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
      appBar:   AppBar(
          title: Text(
                                    language == true
                                        ? "Check-in"
                                        : 'Check-in',
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
      
         
        body: SingleChildScrollView(
          child: isLoading ? Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Checking Status"),
              CircularProgressIndicator(),
            ],
          )):responseData == null  ? Stack(
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
                  child:  Column(
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
                           
                            description4,
              
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
                                 
                                  width: double.infinity,
                                 
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.8),
                                    
                                      width: 1.0, 
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                 
                                    child: Text(
                                      name.toString(),
                                      textAlign: TextAlign.left,
                                     
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
                        )
                      ),
              
                    ],
                  ),
                ),
              ):SizedBox()
            ],
          ): Stack(
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
                  child:  Column(
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
                           
                            description4,
              
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
                      SizedBox(height: height/15,),
                      Padding(
                        padding: EdgeInsets.only(left: width / 12, right: width / 12),
                        child: hasDeparturePassed == true || responseData!["status"] == "rejected" ?Column(
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
                                 
                                  width: double.infinity,
                                 
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.8),
                                    
                                      width: 1.0, 
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                 
                                    child: Text(
                                      name.toString(),
                                      textAlign: TextAlign.left,
                                     
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
                        ):Column(
                          children: [
                             _buildDetailRow('Name:', responseData!['name']),
              _buildDetailRow('Email:', responseData!['email']),
              _buildDetailRow('Reservation Code:', responseData!['reservationCode']),
              _buildDetailRow('Date Arrive:', responseData!['dateArrive']),
              _buildDetailRow('Date Departure:', responseData!['dateDeparture']),
              _buildDetailRow('Status:', responseData!['status']),
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
    );
  }
  Widget _buildDetailRow(String heading, String? text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              heading,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF777777),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              text ?? 'N/A',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Color(0xFF777777),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

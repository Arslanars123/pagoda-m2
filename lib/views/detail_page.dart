import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/providers/send_email_provider.dart';
import 'package:pagoda/views/online_check.dart';
import 'package:pagoda/views/success.dart';
import 'package:pagoda/views/unsuccess.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../providers/check-in-provider.dart';
import '../utils/global.dart';
import '../utils/widgets.dart';
import 'language.dart';
class OtherDetailPage extends StatefulWidget {
  final data;
  OtherDetailPage({required this.data});


  @override
  State<OtherDetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<OtherDetailPage> {
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
  void initState() {
    print("data");
    print(widget.data["_id"].toString()+"ggggggggjbjgjdkadagjkkgdadgad");
    super.initState();
  }
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message,    style: GoogleFonts.montserrat(
          fontWeight: FontWeight
              .w600, // Semi-bold style
          fontSize: 20,
          color: Color(0xFF777777),
        ),),
        actions: [
          TextButton(

            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: GoogleFonts.montserrat(
              fontWeight: FontWeight
                  .w600, // Semi-bold style
              fontSize: 14,
              color:Color(0xFF88A8FF),
            ),),
          ),
        ],
      ),
    );
  }
  Future<void> sendEmail({
    required String name,
    required String telephone,
    required String email,
    required String message,
    required BuildContext context, // Add BuildContext as a parameter
  }) async {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(), // Circular progress indicator
              SizedBox(height: 20),
              Text(language == true ? 'Invio dati in corso':'Sending data...',style: GoogleFonts.montserrat(
                fontWeight: FontWeight
                    .w500, // Semi-bold style
                fontSize: 17,
                color: Color(0xFF777777),
              )),
            ],
          ),
        ),
      ),
    );

    // Check Internet connectivity
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult[0] == ConnectivityResult.none) {
      Navigator.pop(context);
      _showErrorDialog(context, language == true ? "Per favore, controlla la tua connessione dati":"No Internet Connection");

      return;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      Navigator.pop(context);

      _showErrorDialog(context, language ? "Per favore inserisci un indirizzo email valido" : "Please enter a valid email");
      return;
    }

    // Define your endpoint
    final String endpoint = 'http://85.31.236.78:3000/send-email1';

    // Define the request body
    Map<String, String> body = {
      'name': name,
      'telephone': telephone,
      'email': email,
      'message': message,
    };

    try {
      // Send the POST request
      var response = await http.post(Uri.parse(endpoint), body: body);
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        if (data["message"] == "Email sent successfully") {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Success()),
          );

        } else {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UnSucess()),
          );
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UnSucess()),
        );
        print('Failed to send email. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UnSucess()),
      );

      print('Error sending email: $e');
    }
  }

TextEditingController names = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController telePhone = TextEditingController();
  TextEditingController message = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final checkInProvider =
    Provider.of<SendEmailProvider>(context, listen: false);
    String hintTextName = language ? "Nome e Cognome" : "Surname and Name";
    String hintTextTelephone  = language ? "Telefono" : "Telephone number";
    String hintTextEmail = language ? "E-mail" : "E-mail address";
    String hintTextMessage = language ? "scrivici qui il tuo messagio" : "Write Your Message";
    bool isChecked = false;
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

                      Container(
                        width: width / 1.5, // Adjust width as needed
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            name,
                            maxLines: 1,
                            // Add overflow property
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600, // Semi-bold style
                              fontSize: 14,
                              color: Color(0xFF777777),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(right: width/25,bottom: 5),
                        child: InkWell(
                          onTap: (){
                            Navigator.pushReplacement(
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
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          widget.data["image"] == null ?  Container(
                            width: double.infinity,
                            height: height / 5.7,
                            decoration: BoxDecoration(
                                image:DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(

                                        "assets/images/no.jpg"
                                    )

                                )

                            ),

                          ):
                  Container(
                  width: double.infinity,
                  height: height / 5.7,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: "http://85.31.236.78:3000/${widget.data["image"]}",
                    placeholder: (context, url) => Center(child: SizedBox()),
                    errorWidget: (context, url, error) => Image.asset("assets/images/no.jpg",fit: BoxFit.cover,),
                    fit: BoxFit.cover,
                  ),
                ),
                          Padding(
                            padding: EdgeInsets.only(top: height / 7.5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: InkWell(
                                    onTap: (){

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                      BoxShadow(
                                      color: Colors.grey.withOpacity(0.1), // Adjust opacity for a very light shadow
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10)),

                                      width: width / 1.2,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: width / 12, right: width / 12, top: height / 100,bottom: height / 100),
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

                                          // set the default styling for text
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFFB5B5B5),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: GoogleFonts.montserrat().fontFamily,
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
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height / 13,
                                ),
                                widget.data["availability"] == "yes" ?    Padding(
                                  padding: EdgeInsets.only(left: width / 20, right: width / 20),
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
                /*          Navigator.pushReplacementNamed(context, '/success');*/
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
                                            horizontal: 20, vertical: 12),
                                        child: Text(
                                          language == true ?   "Verifica disponibilità" :"Check Availability",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white, // Use the color code #B5B5B5
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ):SizedBox(),
                                widget.data["availability"] == "yes" ?  SizedBox(
                                  height: height / 13,
                                ):SizedBox(),


                              ],
                            ),
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          widget.data["email"] == "yes" ?   Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: width / 20, right: width / 20),
                                child: MyTextField(
                                  hintText: hintTextName,
                                  controller: names,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: width / 20, right: width / 20),
                                child: MyTextField(
                                  hintText: hintTextTelephone,
                                  controller: telePhone,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: width / 20, right: width / 20),
                                child: MyTextField(
                                  hintText: hintTextEmail,
                                  controller: email,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: width / 20, right: width / 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(width: 1,color: Colors.grey.withOpacity(0.8))
                                  ),
                                  child: TextField(

                                    maxLines: 5,
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFC1C7D9)
                                      ),

                                    ),
                                    controller: message,
                                    decoration: InputDecoration(

                                      border: InputBorder.none,
                                      hintText: hintTextMessage,

                                      hintStyle: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFFC1C7D9)
                                        ),

                                      ),
                                      /*   border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  borderSide: BorderSide(
                                                    color: Color(0xFFC1C7D9),
                                                    width: 1.0,
                                                  ),
                                                ),*/
                                      contentPadding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0), // Adjust left content padding here
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ):SizedBox(),

                          widget.data["email"] == "yes" ?    Padding(
                            padding: EdgeInsets.only(left: width / 20, right: width / 20),
                            child:        Row(
                              children: [
                                StatefulBuilder(
                                  builder: (context,setState) {
                                    return GestureDetector(
                                      onTap: () {
                                        print("name");
                                        setState(() {
                                          isChecked = !isChecked;
                                          print(isChecked);
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
                                        child: isChecked == true
                                            ? Icon(
                                          Icons.check,
                                          color: Colors.black,
                                          size: 20.0,
                                        )
                                            : SizedBox(),
                                      ),
                                    );
                                  }
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

                          ):SizedBox(),
                          widget.data["email"] == "yes" ?     Padding(
                            padding:  EdgeInsets.only(left: width/7.7),
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
                                              return SingleChildScrollView(
                                                child: HtmlWidget(
                                                  // the first parameter (`html`) is required
                                                  policyData.data,


                                                  // all other parameters are optional, a few notable params:

                                                  // specify custom styling for an element
                                                  // see supported inline styling below

                                                  // this callback will be triggered when user taps a link

                                                  // select the render mode for HTML body
                                                  // by default, a simple `Column` is rendered
                                                  // consider using `ListView` or `SliverList` for better performance

                                                  // set the default styling for text
                                                  textStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFFB5B5B5),
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: GoogleFonts.montserrat().fontFamily,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),

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
                          ):SizedBox(),
                          SizedBox(
                            height: height/20,
                          ),
                          widget.data["email"] == "yes" ?   Padding(
                            padding: EdgeInsets.only(left: width / 20, right: width / 20),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (names.text.isEmpty || email.text.isEmpty || telePhone.text.isEmpty || message.text.isEmpty ||isChecked != true) {
                                    Fluttertoast.showToast(
                                        msg: language == true ?"Per favore completa tutti i campi":"Please fill all the fields",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Color(0xFF289DD1),
                                        textColor: Colors.white,
                                        fontSize: 12.0);
                                  } else {
                                    // All fields are filled
                                    // Proceed with sending the email
                                    print("here");
                                    sendEmail(
                                      context: context,
                                      name: names.text,
                                      email: email.text,
                                      telephone: telePhone.text,
                                      message: message.text,
                                    );
                                  }

                                  /*          Navigator.pushReplacementNamed(context, '/success');*/
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF289DD1), // Use the color code #289DD1
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20), // Set border radius to 20
                                    // for rounded corners
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  child: Text(
                                    language == true ?   "Invia richiesta":"Send request",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white, // Use the color code #B5B5B5
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ):SizedBox(),
                          widget.data["email"] == "yes" ? SizedBox(
                            height: height/15,
                          ):SizedBox(),
                          widget.data["checkin"] == "yes" ?  Padding(
                            padding: EdgeInsets.only(left: width / 20, right: width / 20),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          OnlineCheckIn(),
                                      transitionsBuilder:
                                          (_, animation, __, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: Offset(1.0, 0.0),
                                            end: Offset.zero,
                                          ).animate(
                                            CurvedAnimation(
                                              parent: animation,
                                              curve: Curves
                                                  .easeInOut, // You can change the curve as desired
                                            ),
                                          ),
                                          child: child,
                                        );
                                      },
                                      transitionDuration: Duration(
                                          milliseconds:
                                          900), // Set forward duration
                                    ),
                                  ).then((_) {
                                    // This code runs when the pushed route (RoomDetail) is popped
                                    // You can put any code that needs to run after the pop here
                                  });
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
                                      horizontal: 20, vertical: 12),
                                  child: Text(
                                    language == true
                                        ? "Vai al check-in"
                                        : "Go to check-in",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white, // Use the color code #B5B5B5
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ):SizedBox(),
                          widget.data["email"] == "yes" ? SizedBox(
                            height: height/20,
                          ):SizedBox(),
                        ],
                      ),
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}

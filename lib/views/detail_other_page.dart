import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/providers/send_email_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/check-in-provider.dart';
import '../utils/global.dart';
import '../utils/widgets.dart';
class OtherDetail extends StatefulWidget {
  final data;
  OtherDetail({required this.data});


  @override
  State<OtherDetail> createState() => _DetailPageState();
}

class _DetailPageState extends State<OtherDetail> {
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
   print(widget.data["_id"].toStrg()+"ggggggggjbjgjdkadagjkkgdadgad");
    super.initState();
  }
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

        body: Stack(
          children: [
            Column(
              children: [

                Container(
                  color: Colors.white,
                  child: Padding(
                    padding:
                    EdgeInsets.only(left: width / 20, top: height / 70),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(

                          width: MediaQuery.of(context).size.width / 14,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap:(){
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  "assets/images/arrow-left.png",
                                  scale: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                       language == true ?  widget.data["titleI"] :widget.data["title"],
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, // Semi-bold style
                            fontSize: 20,
                            color: Color(0xFF777777),
                          ),
                        ),
                        Container(
                          height: height / 19,
                          width: width / 9,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // Box decoration with image
                            image: DecorationImage(

                              image: AssetImage(language == true ?"assets/images/it flag.png":"assets/images/uk.png"),
                              // Provide your image path here
                              fit: BoxFit
                                  .cover, // This will contain (cover) the image within the container
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

                 ):     Container(
                     width: double.infinity,
                     height: height / 5.7,
                     decoration: BoxDecoration(
                         image:DecorationImage(
                             fit: BoxFit.cover,
                             image: NetworkImage(

                                 "http://85.31.236.78:3000/"+widget.data["image"]
                             )

                         )

                     ),

                   ),

                   ],
                 ),
               ),
             ),



              ],
            ),

            Padding(
              padding: EdgeInsets.only(top: height / 5),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),

                      width: width / 1.2,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: width / 12, right: width / 12, top: height / 100,bottom: height / 100),
                        child: Html(data: "<p>h</p>",style:  {
                          '#': Style(
                            maxLines: 5,
                            textOverflow: TextOverflow.ellipsis,
                            color: Color(0xFFB5B5B5),
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.montserrat().fontFamily,
                          ),
                        },),

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
                  SizedBox(
                    height: height / 13,
                  ),
              widget.data["availability"] == "yes" ?    Padding(
                    padding: EdgeInsets.only(left: width / 20, right: width / 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
_launchUrl();


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
            Column(
              children: [
                SizedBox(height: height/2,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        widget.data["email"] == "yes" ?   Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: width / 20, right: width / 20),
                              child: MyTextField(
                                hintText: hintTextName,
                                controller: checkInProvider.nameController,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width / 20, right: width / 20),
                              child: MyTextField(
                                hintText: hintTextTelephone ,
                                controller: checkInProvider.Telephone,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                           Padding(
                              padding: EdgeInsets.only(left: width / 20, right: width / 20),
                              child: MyTextField(
                                hintText: hintTextEmail,
                                controller: checkInProvider.emailController,
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
                                  controller: checkInProvider.descriptionController,
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

                        Padding(
                          padding: EdgeInsets.only(left: width / 20, right: width / 20),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    print("here");
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
                                  Text(
                                   language == true ? "Acconsento all’utilizzo dei miei dati. Privacy Policy":"I agree with the use of my data. Read the Privacy Policy.",
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
                                            title: Text(language == true ? "Privacy Policy":"Privacy Policy.",),
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
                                      'GDPR',
                                      style: GoogleFonts.montserrat(
                                        decoration: TextDecoration.underline,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(
                                            0xFF6478AF), // Use the color code #B5B5B5
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height/20,
                        ),
                     widget.data["email"] == "yes" ?   Padding(
                          padding: EdgeInsets.only(left: width / 20, right: width / 20),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {



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
                        widget.data["email"] == "yes" ? SizedBox(
                          height: height/20,
                        ):SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

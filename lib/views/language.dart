import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/utils/global.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/checkin_providers.dart';
import 'home.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    final checkInProvider =
    Provider.of<CheckInProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xFF313890),
      body: Container(
        width: double.infinity,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width/1.3,
                  child: Text(
                    textAlign: TextAlign.center,
                   language == true ? 'Seleziona la lingua che':"Choose in which language you want to continue",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 21.0,
                        fontWeight: FontWeight.w600, // Semi-bold
                      ),
                    ),
                  ),
                ),
              ),
            language == true ?Container(
                width: MediaQuery.of(context).size.width/1.3,
                child: Text(
                  textAlign: TextAlign.center,
                  'preferisci',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 21.0,
                      fontWeight: FontWeight.w600, // Semi-bold
                    ),
                  ),
                ),
              ):SizedBox(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 80,
              ),
              Container(
                width: MediaQuery.of(context).size.width/1.3,
                child: Text(
                  textAlign: TextAlign.center,
                  language == true?'Clicca sull’icona che preferisci':"Click on the flag below",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600, // Semi-bold
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool("language", true);

                      checkInProvider.emailController.clear();
                      checkInProvider.reservationCodeController.clear();
                      checkInProvider.dateArriveController.clear();
                      checkInProvider.dateDepartureController.clear();
                      checkInProvider.PhoneController.clear();
                      checkInProvider.nameController.clear();
                      selectedImage = null;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomBarScreen()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/images/it.png"),
                          fit: BoxFit
                              .cover, // Controlla il modo in cui l'immagine viene ridimensionata per adattarsi al contenitore
                        ),
                      ),
                      width: MediaQuery.of(context).size.width /
                          4, // Imposta la larghezza del contenitore
                      height: MediaQuery.of(context).size.width /
                          6, // Imposta l'altezza del contenitore
                    ),
                  ),
                  InkWell(
                    onTap: ()async{
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool("language", false);
                      checkInProvider.emailController.clear();
                      checkInProvider.reservationCodeController.clear();
                      checkInProvider.dateArriveController.clear();
                      checkInProvider.dateDepartureController.clear();
                      checkInProvider.PhoneController.clear();
                      checkInProvider.nameController.clear();
                      selectedImage = null;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomBarScreen()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/images/uk.png"),
                          fit: BoxFit
                              .cover, // Controlla il modo in cui l'immagine viene ridimensionata per adattarsi al contenitore
                        ),
                      ),
                      width: MediaQuery.of(context).size.width /
                          4, // Imposta la larghezza del contenitore
                      height: MediaQuery.of(context).size.width /
                          6, // Imposta l'altezza del contenitore
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

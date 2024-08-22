import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/views/home.dart';

import '../utils/global.dart';
class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _UnSucessState();
}

class _UnSucessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF001378),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset("assets/images/Success.png",scale: 2,),
            SizedBox(height: MediaQuery.of(context).size.height/5,),

            Container(
              width: double.infinity,
              child: Text(

              language == true ?  'Complimenti':'Congratulations',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600, // Semi-bold style
                  fontSize: 23,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Text(

               language == true ? 'I dati sono stati caricati con':"your check-in has been sent",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600, // Semi-bold style
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),

            ),
          Container(
              width: double.infinity,
              child: Text(
                language == true ? 'successo':"successfully",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600, // Semi-bold style
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),

            ),
            SizedBox(height: height/10,),
            Padding(
              padding:  EdgeInsets.only(left: width/12,right: width/12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  BottomBarScreen()),
                    );

   /*                 Navigator.pushReplacementNamed(context, '/unsuccess');*/
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Use the color code #289DD1
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Set border radius to 20 for rounded corners
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      'ok',
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF001378), // Use the color code #B5B5B5
                      ),
                    ),
                  ),
                ),
              ),

            ),
            SizedBox(height: height/20,),
          ],
        ),
      ),
    );
  }
}

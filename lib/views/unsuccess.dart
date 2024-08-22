import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/utils/global.dart';
class UnSucess extends StatefulWidget {
  const UnSucess({super.key});

  @override
  State<UnSucess> createState() => _UnSucessState();
}

class _UnSucessState extends State<UnSucess> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF8089BC),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset("assets/images/Unsuccessful.png",scale: 2,),
            SizedBox(height: MediaQuery.of(context).size.height/5,),

            Text(
             language == true ? 'Qualcosa non va':"Something is wrong",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600, // Semi-bold style
                fontSize: 23,
                color: Colors.white,
              ),
            ),
          language == true ?  Container(
              width: MediaQuery.of(context).size.width/1.5,
              child: Center(
                child: Text(
                  'Ti preghiamo di riprovare',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600, // Semi-bold style
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),

            ):SizedBox(),
          language == true ?  Container(
              width: MediaQuery.of(context).size.width/1.6,
              child: Center(
                child: Text(
                  'tra qualche minuto',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600, // Semi-bold style
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),

            ):SizedBox(),
           language == false ? Container(
              width: MediaQuery.of(context).size.width/1.6,
              child: Center(
                child: Text(
               language == true ? 'tra qualche minuto':"Please try again later",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600, // Semi-bold style
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),

            ):SizedBox(),
            SizedBox(height: height/10,),
            Padding(
              padding:  EdgeInsets.only(left: width/12,right: width/12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
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

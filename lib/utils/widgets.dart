import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  MyTextField({required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1,color: Colors.grey.withOpacity(0.8))
      ),
      child: TextField(
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFFC1C7D9)
          ),

        ),
        controller: controller,
        decoration: InputDecoration(

          border: InputBorder.none,
          hintText: hintText,

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
    );
  }
}

class MyTextFieldDrop extends StatelessWidget {
  final String hintText;
  TextEditingController controller;

   MyTextFieldDrop({super.key, required this.hintText,required this.controller});




  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1,color: Colors.grey.withOpacity(0.8))
      ),
      child: TextField(
        enabled: false,

        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: controller.text.isEmpty ? hintText:controller.text,
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
          suffixIcon: Icon(Icons.keyboard_arrow_down_outlined,color: Color(0xFFC1C7D9),),
          contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 5.0), // Adjust left content padding here
        ),
      ),
    );
  }
}

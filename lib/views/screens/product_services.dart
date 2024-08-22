import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/views/screens/product_screen.dart';
import 'package:pagoda/views/screens/serve_screen.dart';



class ProductServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
           DefaultTabController(
           
            length: 2,
            
             child: Column(
              children: [
                 TabBar(
                    labelStyle: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600), // Style for selected tab
            unselectedLabelStyle: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w400), // Style for unselected tabs
            indicatorColor: Color(0xFF001378),
                  dividerColor: Colors.transparent,
                indicatorPadding: EdgeInsets.zero, // No extra space around the indicator
                labelPadding: EdgeInsets.symmetric(horizontal: 10.0), // Minimal horizontal padding between tabs
                tabs: [
                  Tab(text: 'Products'),
                  Tab(text: 'Services'),
                ],
              ),
              SizedBox(height: 50,),
                Expanded(
                  child: TabBarView(
                    children: [
                      ProductScreen(),
                  ServeScreen(),
                    ],
                  ),
                ),
              ],
                       ),
           ),
        );
      
    
  }
}

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('List of Products'),
    );
  }
}

class ServicesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('List of Services'),
    );
  }
}

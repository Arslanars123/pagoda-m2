// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pagoda/utils/global.dart';
// import 'package:pagoda/views/language.dart';

// class OrdersScreen1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Stack(
//             children: [
//               Column(
//                 children: [
//                   // Header section
                     
//                      Container(
                    
//                       decoration: BoxDecoration(
//                           color: Colors.white,
                             
//                         boxShadow: [ 
                    
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1), // Subtle shadow color
//                       spreadRadius: 1, // How much the shadow spreads
//                       blurRadius: 3, // How blurry the shadow is
//                       offset: Offset(0, 2), // The position of the shadow
//                     ),
//                   ],
//                       ),
                     
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                           left: width / 25,top: 10 ),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             InkWell(
//                               onTap: (){
//                                 Navigator.pop(context);
//                               },
//                               child: Padding(
//                                 padding:  EdgeInsets.only(bottom: 5),
//                                 child: Container(
//                                     child:Icon(Icons.arrow_back,color: Color(0xFF777777),)
//                                 ),
//                               ),
//                             ),
              
//                             Padding(
//                               padding:  EdgeInsets.only(bottom: 5),
//                               child: Container(
//                                 width: width / 1.5, // Adjust width as needed
//                                 child: Text(
//                             'Cooking class e show cooking',
//                                   textAlign: TextAlign.center,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.clip,
//                                   // Add overflow property
//                                   style: GoogleFonts.montserrat(
//                                     fontWeight: FontWeight.w600, // Semi-bold style
//                                     fontSize: 14,
//                                     color: Color(0xFF777777),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             /*Text(
//                                               language == true
//                                                   ? widget.data["name"]
//                                                   : widget.data["nameI"],
//                                               style: GoogleFonts.montserrat(
//                                                 fontWeight:
//                                                     FontWeight.w600, // Semi-bold style
//                                                 fontSize: 20,
//                                                 color: Color(0xFF777777),
//                                               ),
//                                             ),*/
//                             Padding(
//                               padding:  EdgeInsets.only(right: width/25,bottom: 10),
//                               child: InkWell(
//                                 onTap: (){
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(builder: (context) => const LanguageScreen()),
//                                   );
//                                 },
//                                 child: Container(
//                                   height: height / 25,
//                                   width: width / 9,
//                                   decoration: BoxDecoration(
//                                     // Box decoration with image
//                                     image: DecorationImage(
//                                       image: AssetImage(
//                                           language == true ?"assets/images/it flag.png":"assets/images/uk.png"),
//                                       // Provide your image path here
//                                       fit: BoxFit
//                                           .cover, // This will contain (cover) the image within the container
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   SizedBox(height: 16),
                  
              
//                   // Days and Hours section
//           ],
//               ),
//           Align(
//             alignment: Alignment.topCenter,
//           child: Padding(
//             padding:  EdgeInsets.only(top: height/16),
//             child: Container(width: double.infinity,
//             height: height/6,
            
//             decoration: BoxDecoration(
//               color: Color(0xFF001378),
            
//             ),
            
//             ),
//           ),
//           ),
//            Align(
//             alignment: Alignment.center,
//              child: Column(
//                children: [
//                 SizedBox(height: height/10,),
//                  Container(
//                   height: height/2.2,
//                   decoration: BoxDecoration(
                                
//                         boxShadow: [ 
                    
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1), // Subtle shadow color
//                       spreadRadius: 1, // How much the shadow spreads
//                       blurRadius: 3, // How blurry the shadow is
//                       offset: Offset(0, 2), // The position of the shadow
//                     ),
//                   ],
//                       color: Colors.white,
//                     borderRadius: BorderRadius.all(Radius.circular(20))
//                   ),
                         
//                   width: width/1.1,
//                   child:    
//                      Padding(
//                        padding: const EdgeInsets.only(left: 20,top: 20,bottom: 10),
//                        child:Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   mainAxisSize: MainAxisSize.min,
//   children: [
//     Text(
//       'Nome:',
//       style: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w600, // Set weight to 600
//         fontSize: 16,
//         color: Color(0xFFB5B5B5), // Set color to 0xFFB5B5B5
//       ),
//     ),
//     Text(
//       'Mario Rossi',
//       style: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w600, // Set weight to 600
//         fontSize: 16,
//         color: Color(0xFFB5B5B5), // Set color to 0xFFB5B5B5
//       ),
//     ),
//     SizedBox(height: 10),
//     Text(
//       'Email:',
//       style: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w600, // Set weight to 600
//         fontSize: 16,
//         color: Color(0xFFB5B5B5), // Set color to 0xFFB5B5B5
//       ),
//     ),
//     Text(
//       'mariorossi@gmail.com',
//       style: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w600, // Set weight to 600
//         fontSize: 16,
//         color: Color(0xFFB5B5B5), // Set color to 0xFFB5B5B5
//       ),
//     ),
//     SizedBox(height: 10),
//     Text(
//       'Telefono:',
//       style: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w600, // Set weight to 600
//         fontSize: 16,
//         color: Color(0xFFB5B5B5), // Set color to 0xFFB5B5B5
//       ),
//     ),
//     Text(
//       '123123123123',
//       style: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w600, // Set weight to 600
//         fontSize: 16,
//         color: Color(0xFFB5B5B5), // Set color to 0xFFB5B5B5
//       ),
//     ),
//     SizedBox(height: 10),
//     Text(
//       'Codice di prenotazione:',
//       style: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w600, // Set weight to 600
//         fontSize: 16,
//         color: Color(0xFFB5B5B5), // Set color to 0xFFB5B5B5
//       ),
//     ),
//     Text(
//       '123123123',
//       style: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w600, // Set weight to 600
//         fontSize: 16,
//         color: Color(0xFFB5B5B5), // Set color to 0xFFB5B5B5
//       ),
//     ),
//     SizedBox(height: 10),
//     Text(
//       'Data di arrivo:',
//       style: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w600, // Set weight to 600
//         fontSize: 16,
//         color: Color(0xFFB5B5B5), // Set color to 0xFFB5B5B5
//       ),
//     ),
//     Text(
//       '01 Aug 2024',
//       style: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w600, // Set weight to 600
//         fontSize: 16,
//         color: Color(0xFFB5B5B5), // Set color to 0xFFB5B5B5
//       ),
//     ),
//     SizedBox(height: 10),
//     Text(
//       'Data di partenza:',
//       style: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w600, // Set weight to 600
//         fontSize: 16,
//         color: Color(0xFFB5B5B5), // Set color to 0xFFB5B5B5
//       ),
//     ),
//     Text(
//       '05 Aug 2024',
//       style: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w600, // Set weight to 600
//         fontSize: 16,
//         color: Color(0xFFB5B5B5), // Set color to 0xFFB5B5B5
//       ),
//     ),
//     SizedBox(height: 20),
//   ],
// )
//   ),
                
//                    ),
//             SizedBox(
//                       height: height/20,
//                     ),
//                     Container(
//                       width: double.infinity,
//                       height: height/7,
//                       color: Colors.grey.withOpacity(0.3),
//                       child: Column(
//                         mainAxisAlignment:MainAxisAlignment.center,
//                         children: [
//                           Image.asset('assets/images/hats_1.png',scale: 2,),
//                           SizedBox(height: 5,),
//                           Text("Extra acquistati",style: TextStyle(color: Color(0xFF707070),fontSize: 14), )
//                         ],
//                       ),

//                     ),

//              Container(
//           padding: EdgeInsets.all(16),
//           // Align to the right side
//           width: MediaQuery.of(context).size.width, // Adjust width as needed
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.3),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//                 offset: Offset(0, 3), // changes position of shadow
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Hai speso',
//                 style: GoogleFonts.montserrat(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black54,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 '€ 1422,00',
//                 style: GoogleFonts.montserrat(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue,
//                 ),
//               ),
//               Divider(color: Colors.grey[300]),
//               SizedBox(height: 10),
//               _buildExpenseItem('1 x Caffè', '€ 2,00', '06/04/2024 - 12:30',context),
//               SizedBox(height: 10),
//               _buildExpenseItem('2 x Gelato', '€ 6,00', '06/04/2024 - 14:55',context),
//               SizedBox(height: 10),
//               _buildExpenseItem('2 x Snorkeling', '€ 100,00', '07/04/2024 - 10:55',context),
//               SizedBox(height: 20),
//               Text(
//                 'Il totale speso sarà pagato in reception al saldo della tua vacanza.',
//                 style: GoogleFonts.montserrat(
//                   fontSize: 14,
//                   color: Colors.black54,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 20,),
              
//             ],
//           ),
//         ),    
//           Divider(color: Colors.grey,height: 1,),
//           SizedBox(height: height/20,),
//                     // Button section
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: SizedBox(
//                                             height: height/20,
//                                                                 width: double.infinity,
//                                                                 child: ElevatedButton(
//                                                                   onPressed: () {
//                                                                     // Handle button press
//                                                                   },
//                                                                   style: ElevatedButton.styleFrom(
//                                                                     backgroundColor: Color(0xFF289DD1),
//                                                                     padding: EdgeInsets.symmetric(vertical: 4.0),
//                                                                     shape: RoundedRectangleBorder(
//                                                                       borderRadius: BorderRadius.circular(30.0),
//                                                                     ),
//                                                                   ),
//                                                                   child: Text(
//                                                                     'CHATTA CON IL TUO CONCIERGE',
//                                                                     style: GoogleFonts.montserrat(
//                                                                       fontSize: 14,
//                                                                       color: Colors.white,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                           ),
//                                         ),
                                   
//            ],
//              ),
//            ),
            
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   Widget _buildExpenseItem(String title, String price, String date,var context) {
//     return Container(
//       height: MediaQuery.of(context).size.height/8,
//       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title,
//                 style: GoogleFonts.montserrat(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xFF777777),
//                 ),
//               ),
//               Text(
//                 price,
//                 style: GoogleFonts.montserrat(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xFF6478AF),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 4),
//           Text(
//             date,
//             style: GoogleFonts.montserrat(
//               fontSize: 14,
//               color: Color(0xFF6478AF),
//             ),
//           ),
        
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pagoda/views/language.dart';

class OrdersScreen1 extends StatefulWidget {
  @override
  _OrdersScreen1State createState() => _OrdersScreen1State();
}

class _OrdersScreen1State extends State<OrdersScreen1> {
  List<dynamic> orders = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    const String apiUrl = 'http://85.31.236.78:3000/get-orders-of-user';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': '66a4255e58762b31982d4f23'}),
    );

    if (response.statusCode == 200) {
      setState(() {
        orders = jsonDecode(response.body);
      });
    } else {
      // Handle error here
      print('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  // Header section
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: width / 25, top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Container(
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Color(0xFF777777),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Container(
                              width: width / 1.5,
                              child: Text(
                                'Cooking class e show cooking',
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF777777),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: width / 25, bottom: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LanguageScreen()),
                                );
                              },
                              child: Container(
                                height: height / 25,
                                width: width / 9,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/uk.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: height / 16),
                  child: Container(
                    width: double.infinity,
                    height: height / 6,
                    decoration: BoxDecoration(
                      color: Color(0xFF001378),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 10,
                    ),
                    Container(
                      height: height / 2.2,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      width: width / 1.1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 20, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Nome:',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFFB5B5B5),
                              ),
                            ),
                            Text(
                              'Mario Rossi',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFFB5B5B5),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Email:',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFFB5B5B5),
                              ),
                            ),
                            Text(
                              'mariorossi@gmail.com',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFFB5B5B5),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Telefono:',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFFB5B5B5),
                              ),
                            ),
                            Text(
                              '123123123123',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFFB5B5B5),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Codice di prenotazione:',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFFB5B5B5),
                              ),
                            ),
                            Text(
                              '123123123',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFFB5B5B5),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Data di arrivo:',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFFB5B5B5),
                              ),
                            ),
                            Text(
                              '01 Aug 2024',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFFB5B5B5),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Data di partenza:',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFFB5B5B5),
                              ),
                            ),
                            Text(
                              '05 Aug 2024',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFFB5B5B5),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: height / 7,
                      color: Colors.grey.withOpacity(0.3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/hats_1.png',
                            scale: 2,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Extra acquistati",
                            style: TextStyle(
                                color: Color(0xFF707070), fontSize: 14),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          for (var order in orders)
                            for (var product in order['productsIds'])
                              _buildExpenseItem(
                                product['name'] ?? 'Unknown Product',
                                '\$${product['price'] ?? '0.00'}',
                                '01 Aug 2024',  // Static date, adjust as needed
                                context,
                              ),
                                SizedBox(height: height/20,),
                                               Text(
                'Il totale speso sarà pagato in reception al saldo della tua vacanza.',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: height/20,
                                                                width: double.infinity,
                                                                child: ElevatedButton(
                                                                  onPressed: () {
                                                                    // Handle button press
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                    backgroundColor: Color(0xFF289DD1),
                                                                    padding: EdgeInsets.symmetric(vertical: 4.0),
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(30.0),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                    'CHATTA CON IL TUO CONCIERGE',
                                                                    style: GoogleFonts.montserrat(
                                                                      fontSize: 14,
                                                                      color: Colors.white,
                                                                    ),
                                                                  ),
                                                                ),
                                          ),
                                        ),
             
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 Widget _buildExpenseItem(String title, String price, String date, BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height / 8,
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1), // Light shadow color
          spreadRadius: 1, // How much the shadow spreads
          blurRadius: 3, // Blur radius of the shadow
          offset: Offset(0, 2), // Shadow position
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF777777),
              ),
            ),
            Text(
              price,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6478AF),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          date,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: Color(0xFF6478AF),
          ),
        ),
      ],
    ),
  );
}

}

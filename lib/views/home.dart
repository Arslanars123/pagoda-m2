import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/other_pages.dart';
import 'package:pagoda/providers/roms_provider.dart';
import 'package:pagoda/providers/services_provider.dart';
import 'package:pagoda/topics.dart';
import 'package:pagoda/views/example.dart';
import 'package:pagoda/views/online_check.dart';
import 'package:pagoda/views/rooms_list.dart';
import 'package:pagoda/views/screens/experience_screen.dart';
import 'package:pagoda/views/screens/product_screen.dart';
import 'package:pagoda/views/screens/product_services.dart';
import 'package:pagoda/views/screens/serve_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../providers/hotel_info_provider.dart';
import '../utils/global.dart';
import 'check_in_two.dart';
import 'language.dart';

class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _screens = [
    PlaceholderScreen(),
    RoomsListNew(),
        MessageScreen(),
    // OnlineCheckInTwo(),

    // OtherPages(),
    // ExperiencesScreen(),
    // ProductScreen(),
    ProductServicesScreen(),
    // ServeScreen()
    ExperiencesScreen(),
  ];

  load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    language = prefs.getBool("language") ?? true;
    setState(() {
      print(language);
    });
  }

  @override
  void initState() {
    load();
    // TODO: implement initState
    super.initState();
  }

  Future<void> launchUrlData() async {
    if (language == true) {
      print(language);
      if (!await launchUrl(Uri.parse(
          "https://reservations.verticalbooking.com/premium/index.html?id_albergo=22576&dc=6945&id_stile=16986&lingua_int=ita"))) {
        throw Exception('Could not launch');
      }
    } else {
      if (!await launchUrl(Uri.parse(
          "https://reservations.verticalbooking.com/premium/index.html?id_albergo=22576&dc=6945&id_stile=16986&lingua_int=eng"))) {
        throw Exception('Could not launch');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
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
      
         body: Column(
          children: [
            _selectedIndex == 0
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    height: height / 13,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      InkWell(
                        onTap:(){
                          _scaffoldKey.currentState?.openDrawer();

                    },
                        child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 10,
                            child: Image.asset("assets/images/menu.png",scale: 1.7,)),
                      ),
                          Container(
                              child: Image.asset("assets/images/logo.png")),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LanguageScreen()),
                              );
                            },
                            child: Image.asset(
                              language == true
                                  ? language == true
                                      ? "assets/images/it flag.png"
                                      : "assets/images/uk.png"
                                  : "assets/images/uk.png",
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : _selectedIndex == 1
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        height: height / 13,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap:(){
                                  _scaffoldKey.currentState?.openDrawer();

                                },
                                child: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 10,
                                    child: Image.asset("assets/images/menu.png",scale: 1.7,)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height / 110, right: width / 80),
                                child: Text(
                                  language == true
                                      ? "Camere & Suite"
                                      : 'Rooms & Suites',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Color(0xFF777777),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LanguageScreen()),
                                  );
                                },
                                child: Image.asset(
                                  language == true
                                      ? language == true
                                          ? "assets/images/it flag.png"
                                          : "assets/images/uk.png"
                                      : "assets/images/uk.png",
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : _selectedIndex == 2
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            height: height / 13,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap:(){
                                      _scaffoldKey.currentState?.openDrawer();

                                    },
                                    child: Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 10,
                                        child: Image.asset("assets/images/menu.png",scale: 1.7,)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: height / 110),
                                    child: Text(
                                     language == true ? 'Message' : "Message",
                                      style: GoogleFonts.montserrat(
                                        fontWeight:
                                            FontWeight.w600, // Semi-bold style
                                        fontSize: 20,
                                        color: Color(0xFF777777),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LanguageScreen()),
                                      );
                                    },
                                    child: Image.asset(language == true
                                        ? "assets/images/it flag.png"
                                        : "assets/images/uk.png"),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : _selectedIndex == 3
                            ?  Padding(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            height: height / 13,
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap:(){
                                                      _scaffoldKey.currentState?.openDrawer();
                              
                                                    },
                                                    child: Container(
                                                      
                                                        width: MediaQuery
                                .of(context)
                                .size
                                .width / 10,
                                                        child: 
                                                        Padding(padding: EdgeInsets.only(top: 10),child:  Image.asset("assets/images/menu.png",scale: 1.7,),)
                                                       ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.only(top: height / 110),
                                                    child: Text(
                                                 language == true ? 'Product and Services' : "Products and Services",
                                                      style: GoogleFonts.montserrat(
                                                        fontWeight: FontWeight
                                .w600, // Semi-bold style
                                                        fontSize: 20,
                                                        color: Color(0xFF777777),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                builder: (context) =>
                                    LanguageScreen()),
                                                      );
                                                    },
                                                    child: Image.asset(language == true
                                                        ? "assets/images/it flag.png"
                                                        : "assets/images/uk.png"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                            ) : _selectedIndex == 4 ?
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              height: height / 13,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap:(){
                        _scaffoldKey.currentState?.openDrawer();

                      },
                      child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 10,
                          child: Image.asset("assets/images/menu.png",scale: 1.7,)),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(top: height / 110),
                      child: Text(
                        language == true ? 'Experiences' : "Experiences",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight
                              .w600, // Semi-bold style
                          fontSize: 20,
                          color: Color(0xFF777777),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LanguageScreen()),
                        );
                      },
                      child: Image.asset(language == true
                          ? "assets/images/it flag.png"
                          : "assets/images/uk.png"),
                    ),
                  ],
                ),
              ),
            ):_selectedIndex == 5 ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              height: height / 13,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap:(){
                        _scaffoldKey.currentState?.openDrawer();

                      },
                      child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 10,
                          child: Image.asset("assets/images/menu.png",scale: 1.7,)),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(top: height / 110),
                      child: Text(
                        language == true ? 'Experiences' : "Experiences",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight
                              .w600, // Semi-bold style
                          fontSize: 20,
                          color: Color(0xFF777777),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LanguageScreen()),
                        );
                      },
                      child: Image.asset(language == true
                          ? "assets/images/it flag.png"
                          : "assets/images/uk.png"),
                    ),
                  ],
                ),
              ),
            )   : SizedBox(),
           _selectedIndex == 30 ? OnlineCheckInTwo(): _screens[_selectedIndex],
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          height: MediaQuery.of(context).size.height * 0.075,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
              bottomRight: Radius.circular(24.0),
              bottomLeft: Radius.circular(24.0),
            ),
            child: BottomAppBar(
              padding: EdgeInsets.zero,
              color: Color(0xFF001378),
              elevation: 10.0,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => _onItemTapped(0),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SvgPicture.asset(
                          'assets/images/one.svg',
                          color: _selectedIndex == 0
                              ? Colors.white
                              : Color(0xFF88A8FF),
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => _onItemTapped(1),
                      child: SvgPicture.asset(
                        'assets/images/two.svg',
                        color: _selectedIndex == 1
                            ? Colors.white
                            : Color(0xFF88A8FF),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => _onItemTapped(2),
                      child: SvgPicture.asset(
                        'assets/images/three.svg',
                        color: _selectedIndex == 2
                            ? Colors.white
                            : Color(0xFF88A8FF),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => _onItemTapped(3),
                      child: Padding(
                        padding: const EdgeInsets.only(right:2),
                        child: SvgPicture.asset(
                          'assets/images/four.svg',
                          color: _selectedIndex == 3
                              ? Colors.white
                              : Color(0xFF88A8FF),
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => _onItemTapped(4),
                      child: SvgPicture.asset(
                        'assets/images/Icon.svg',
                        color: _selectedIndex == 4
                            ? Colors.white
                            : Color(0xFF88A8FF),
                      ),
                    ),
              
                  
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class PlaceholderScreen extends StatefulWidget {
  VoidCallback? nextPage;
  VoidCallback? prev;

  PlaceholderScreen({this.nextPage, this.prev});

  @override
  State<PlaceholderScreen> createState() => _State();
}

class _State extends State<PlaceholderScreen> {
  List<String> services = [
    "Ristorante",
    "Servizio in Camera",
    "Altro servizio",
    "Piscina"
  ];

  @override
  void initState() {
    print("init me h");
    print(indexRoom);
    indexRoom == 1 ? widget.prev!() : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final dataProvider = Provider.of<HotelInfoProvider>(context, listen: false);
    final roomsProvider = Provider.of<RoomsProvider>(context, listen: false);
    final servicesProvider =
        Provider.of<ServicesProvider>(context, listen: false);
        print("here place");
    return FutureBuilder(
      future: dataProvider.fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi,
                  size: height / 7,
                  color: Color(0xFF001378),
                ),
                Text(
                  language == true ? "Qualcosa non va" : 'Something is wrong',
                  style: GoogleFonts.montserrat(
                    textStyle:
                        TextStyle(color: Color(0xFF777777), fontSize: 14),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {});
                      },
                      child: Text(
                        language == true ? "Riprova" : 'Retry',
                        style: GoogleFonts.montserrat(
                          textStyle:
                              TextStyle(color: Color(0xFF777777), fontSize: 14),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )),
              ],
            ),
          );
        } else {
          if (dataProvider.data == null) {
            // No data available
            if (dataProvider.internet == "no") {
              // No internet connection

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height / 4,
                    ),
                    Icon(
                      Icons.wifi,
                      size: height / 7,
                      color: Color(0xFF001378),
                    ),
                    Text(
                      language == true
                          ? "Per favore, controlla la tua connessione dati"
                          : 'No internet connection',
                      style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(color: Color(0xFF777777), fontSize: 14),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {});
                          },
                          child: Text(
                            language == true ? "Riprova" : 'Retry',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Color(0xFF777777), fontSize: 14),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )),
                  ],
                ),
              );
            } else {
              // Internet connection available but no data
              return Expanded(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_copy_outlined,
                        size: height / 7,
                        color: Color(0xFF001378),
                      ),
                      Text(
                        language == true
                            ? "nessun dato disponibile"
                            : 'No Data Available',
                        style: GoogleFonts.montserrat(
                          textStyle:
                              TextStyle(color: Color(0xFF777777), fontSize: 14),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {});
                            },
                            child: Text(
                              language == true ? "Riprova" : 'Retry',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Color(0xFF777777), fontSize: 14),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              );
            }
          } else {
            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: height / 50,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: width / 20, right: width / 20),
                      child: dataProvider.data["images"] != null
                          ? Container(
                              width:
                                  double.infinity, // Set width of the container
                              height:
                                  height / 5.3, // Set height of the container
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // Box decoration with image
                                image: dataProvider.data["coverImage"] != null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            "http://85.31.236.78:3000/" +
                                                dataProvider
                                                    .data["coverImage"]!),
                                        // Provide your image path here
                                        fit: BoxFit
                                            .cover, // This will contain (cover) the image within the container
                                      )
                                    : DecorationImage(
                                        image:
                                            AssetImage("assets/images/no.jpg"),
                                        // Provide your image path here
                                        fit: BoxFit
                                            .cover, // This will contain (cover) the image within the container
                                      ),
                              ),
                            )
                          : Container(
                              width:
                                  double.infinity, // Set width of the container
                              height:
                                  height / 5.3, // Set height of the container
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
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: width / 20, right: width / 20),
                      child: HtmlWidget(
                        // the first parameter (`html`) is required
                        language == true
                            ? dataProvider.data["descriptionI"]
                            : dataProvider.data["description"],

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

                      /*Html(
                            data: language == true
                                ? dataProvider.data["descriptionI"]
                                : dataProvider.data["description"],
                            style: {
                              '#': Style(
                                maxLines: 5,
                                textOverflow: TextOverflow.ellipsis,
                                color: Color(0xFFB5B5B5),
                                fontSize: FontSize(14),
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts
                                    .montserrat()
                                    .fontFamily,
                              ),
                            },
                          )*/
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text(
                      language == true ? 'Camere & Suite' : "Rooms & Suites",
                      style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(color: Color(0xFF777777), fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                    FutureBuilder(
                        future: roomsProvider.fetchRooms(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: width / 20, bottom: height / 40),
                              child: Container(
                                height: height / 6,
                                width: double.infinity,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  // Set the scroll direction to horizontal
                                  itemCount: roomsProvider.data.length,
                                  // Set the number of items in the list
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    print(roomsProvider.data.length);
                                    return Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  /*  setState(() {
                                                    room = roomsProvider
                                                        .data[index];
                                                    indexRoom = 1;
                                                  });
                                                  widget.nextPage!();*/
                                                  Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder:
                                                          (_, __, ___) =>
                                                              RoomDetail(
                                                        data: roomsProvider
                                                            .data[index],
                                                      ),
                                                      transitionsBuilder: (_,
                                                          animation,
                                                          __,
                                                          child) {
                                                        return SlideTransition(
                                                          position:
                                                              Tween<Offset>(
                                                            begin: Offset(
                                                                1.0, 0.0),
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

                                                  /*  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                                RoomDetail(
                                                                  data: roomsProvider
                                                                      .data[index],
                                                                )),
                                                  );*/
                                                },
                                                child: roomsProvider
                                                            .data[index]
                                                                ["images"]
                                                            .length !=
                                                        0
                                                    ? Container(
                                                        height: height / 6.5,
                                                        width: width / 2,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.3),
                                                              spreadRadius: 1,
                                                              blurRadius: 5,
                                                              offset:
                                                                  Offset(0, 2),
                                                            ),
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: "http://85.31.236.78:3000/" +
                                                                roomsProvider
                                                                    .data[index]
                                                                        [
                                                                        "images"]
                                                                        [0]
                                                                    .toString(),
                                                            placeholder: (context,
                                                                    url) =>
                                                                Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ),
                                              SizedBox(
                                                height: height / 80,
                                              ),
                                            ],
                                          ),
                                          Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: width / 30,
                                                  bottom: height / 70,
                                                ),
                                                child: Container(
                                                  width: width / 2.7,
                                                  child: Text(
                                                    language == true
                                                        ? roomsProvider
                                                            .data[index]
                                                                ["nameI"]
                                                            .toString()
                                                        : roomsProvider
                                                            .data[index]["name"]
                                                            .toString(),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      // Semi-bold
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          roomsProvider.data[index]["price"]
                                                      .toString()
                                                      .isEmpty ||
                                                  roomsProvider.data[index]
                                                              ["price"]
                                                          .toString() ==
                                                      "no" ||
                                                  roomsProvider.data[index]
                                                          ["price"] ==
                                                      null
                                              ? SizedBox()
                                              : Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: width / 3,
                                                        bottom: 0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFF8089BC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      height: height / 15,
                                                      width: width / 7,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            maxLines: 1,
                                                            "\$ " +
                                                                roomsProvider
                                                                    .data[index]
                                                                        [
                                                                        "price"]
                                                                    .toString(),
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              // Semi-bold

                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Night',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              // Semi-bold

                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                        }),
                    SizedBox(
                      height: height / 40,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: width / 20, right: width / 20),
                      child: HtmlWidget(
                        // the first parameter (`html`) is required
                        language == true
                            ? dataProvider.data["description2I"]
                            : dataProvider.data["description2"],

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
                    SizedBox(
                      height: height / 40,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: width / 20, right: width / 20),
                      child: HtmlWidget(
                        // the first parameter (`html`) is required
                        language == true
                            ? dataProvider.data["description3I"]
                            : dataProvider.data["description3"],

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
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    dataProvider.data["checkin"] == "yes"
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: width / 20, right: width / 20),
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

                                  /*   Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomBarScreenFirst()),
                                  );*/
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
                                      horizontal: 20, vertical: 12),
                                  child: Text(
                                    language == true
                                        ? "Vai al check-in"
                                        : "Go to check-in",
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
                          )
                        : SizedBox(),
                    dataProvider.data["checkin"] == "yes "
                        ? SizedBox(
                            height: height / 30,
                          )
                        : SizedBox(),
                    dataProvider.data["availability"] == "yes"
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: width / 20, right: width / 20),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          language == false
                                              ? "By proceeding, you will be redirected to our platform to check availability. Are you sure you want to continue?"
                                              : "Proseguendo, verrai reindirizzato alla nostra piattaforma per verificare la disponibilità. Sei sicuro di voler continuare?",
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17,
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
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
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
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: Color(0xFF8089BC),
                                                )),
                                          ),
                                        ],
                                      );
                                    },
                                  );
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
                                      horizontal: 20, vertical: 12),
                                  child: Text(
                                    language == true
                                        ? "Verifica disponibilità"
                                        : "Check Availability",
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
                          )
                        : SizedBox(),
                    SizedBox(
                      height: height / 30,
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );

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
  }
}

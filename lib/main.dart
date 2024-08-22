import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pagoda/chat_example.dart';
import 'package:pagoda/providers/check-in-provider.dart';
import 'package:pagoda/providers/checkin_providers.dart';
import 'package:pagoda/providers/hotel_info_provider.dart';
import 'package:pagoda/providers/orders.dart';
import 'package:pagoda/providers/page_provider.dart';
import 'package:pagoda/providers/product_of_provider.dart';
import 'package:pagoda/providers/roms_provider.dart';
import 'package:pagoda/providers/send_email_provider.dart';
import 'package:pagoda/providers/services_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pagoda/topics.dart';
import 'package:pagoda/user_orders.dart';
import 'package:pagoda/views/check_in_two.dart';
import 'package:pagoda/views/experienc_details.dart';
import 'package:pagoda/views/forget_pasword.dart';
import 'package:pagoda/views/home.dart';
import 'package:pagoda/views/language.dart';
import 'package:pagoda/views/loginscreen.dart';
import 'package:pagoda/views/otp_screen.dart';
import 'package:pagoda/views/signup.dart';
import 'package:pagoda/views/splash_view.dart';
import 'package:http/http.dart' as http;



import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  initializeDateFormatting('en', null); // Initialize English date formatting
  initializeDateFormatting('it', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HotelInfoProvider()),
        ChangeNotifierProvider(create: (_) => RoomsProvider()),
        ChangeNotifierProvider(create: (_) => ServicesProvider()),
        ChangeNotifierProvider(create: (_) => CheckInProvider()),
        ChangeNotifierProvider(create: (_) => PageProvider()),
        ChangeNotifierProvider(create: (_) => PolicyData()),
        ChangeNotifierProvider(create: (_) => SendEmailProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),

        // Add your other providers here
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Your App',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        supportedLocales: [
          const Locale('en'), // English
          const Locale('it'), // Italian
        ],
    home: SplashScreen(),
    /*    initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,*/
      ),
    );
  }
}
class NestedNavigationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => SingleChildScrollView(child: PlaceholderScreen()),
        );
      },
    );
  }
}


class PostRequestScreen extends StatefulWidget {
  @override
  _PostRequestScreenState createState() => _PostRequestScreenState();
}

class _PostRequestScreenState extends State<PostRequestScreen> {
  bool isLoading = false;
  bool hasError = false;
  Map<String, dynamic>? responseData;

  Future<void> postUserId(String userId) async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    final url = 'http://85.31.236.78:3000/get-check-info';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'userId': userId,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          responseData = data.firstWhere(
            (item) => item['userId'] == userId,
            orElse: () => null,
          );
        });
      } else {
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
    postUserId('66bef7408edacc29d1e4ca75');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : hasError
                ? Text('Something went wrong or no data available.')
                : responseData == null
                    ? Text('No reservation found for this user.')
                    : ReservationWidget(responseData!),
      ),
    );
  }
}

class ReservationWidget extends StatelessWidget {
  final Map<String, dynamic> reservationData;

  ReservationWidget(this.reservationData);

  @override
  Widget build(BuildContext context) {
    final String dateDepartureString = reservationData['dateDeparture'];
    final DateTime dateDeparture = _parseDate(dateDepartureString);
    final DateTime currentDate = DateTime.now();
    final bool hasDeparturePassed = currentDate.isAfter(dateDeparture);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return   hasDeparturePassed == true && reservationData["status"] != "rejected"? Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
                    
       
           
          ReservationDetails(reservationData),
          SizedBox(height: 20),
        
        ],
      )):OnlineCheckInTwo();
  }

  DateTime _parseDate(String dateString) {
    try {
      return DateFormat('yyyy-M-d').parse(dateString);
    } catch (e) {
      return DateTime.now(); // Default to current date if parsing fails
    }
  }
}

class ReservationDetails extends StatelessWidget {
  final Map<String, dynamic> reservationData;

  ReservationDetails(this.reservationData);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reservation Details',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildDetailRow('Name', reservationData['name']),
            _buildDetailRow('Phone', reservationData['phone']),
            _buildDetailRow('Email', reservationData['email']),
            _buildDetailRow('Reservation Code', reservationData['reservationCode']),
            _buildDetailRow('Status', reservationData['status']),
            _buildDetailRow('Arrival Date', reservationData['dateArrive']),
            _buildDetailRow('Departure Date', reservationData['dateDeparture']),
           
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Image:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Image.network(
            'http://85.31.236.78:3000/images/$imageUrl',
            height: 150,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}



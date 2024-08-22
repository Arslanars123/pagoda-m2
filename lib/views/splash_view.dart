import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pagoda/views/home.dart';
import 'package:pagoda/views/loginscreen.dart';



class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });


    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,

            child:Image.asset("assets/images/splash.png",fit: BoxFit.cover,),


          ),
          Container(
            height: height,
            width: width,

          decoration: BoxDecoration(
           /* color: Colors.grey.withOpacity(0.5),*/
          ),


          ),
          Center(child: Image.asset("assets/images/logo.png",scale: 1.5,)),

          /*Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/splash_background.png")
          ),


        ),
        child: Stack(

          children: [

            Center(child: Padding(
              padding:  EdgeInsets.only(bottom: height/15),
              child: InkWell(
                onTap: (){
                  Navigator.pushReplacementNamed(context, '/home');
                },
                  child: Image.asset("assets/images/logo.png",scale: 1.5,)),
            )),

          ],
        ),
      )*/
        ],
      ),
    );
  }
}

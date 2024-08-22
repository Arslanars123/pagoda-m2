/*
import 'package:flutter/material.dart';
import 'package:pagoda/views/example.dart';
import 'package:pagoda/views/home.dart';
class SwitchOne extends StatefulWidget {
  const SwitchOne({super.key});

  @override
  State<SwitchOne> createState() => _SwitchOneState();
}

class _SwitchOneState extends State<SwitchOne> {
  List<Widget> screens = [
    PlaceholderScreen(),
    Text(""),
  ];
  var controller = PageController();
  nextPage(){
    controller.jumpToPage(2)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: 2, // Number of screens
        itemBuilder: (context, index) {
          // List of screens


          // Ensure the index is within the range of screens
          if (index >= 0 && index < screens.length) {
            return screens[index];
          } else {
            return Container(); // Placeholder if index is out of range
          }
        },
      ),

    );
  }
}
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/utils/global.dart';


class MyPageView extends StatefulWidget {
  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  PageController _pageController = PageController(initialPage: 0);
  bool check = false;

  void nextPage() {
    setState(() {
      indexRoom = 1;
    });

    _pageController.nextPage(
        duration: Duration(milliseconds: 600), curve: Curves.ease);
    print(indexRoom);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<Widget> screens = [
      Screen1(
        nextPage: () => nextPage(),
      ),
      Screen2(),
    ];
    return Scaffold(
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: 2, // Number of screens
        itemBuilder: (context, index) {
          print(index);
          if(index != 0){
          if (index >= 0 && index < screens.length) {
            return screens[index];
          } else {
            return Text("here"); // Placeholder if index is out of range
          }}else {
            return screens[0];
          }
        },
      ),
    );
  }
}

class Screen1 extends StatelessWidget {
  final VoidCallback nextPage;

  const Screen1({required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Screen 1',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: nextPage,
              child: Text('Go to Screen 2'),
            ),
          ],
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Text(
          'Screen 2',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

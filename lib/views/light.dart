import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class BlackScreenWithImage extends StatefulWidget {

  var data;
  BlackScreenWithImage({required this.data});
  @override
  State<BlackScreenWithImage> createState() => _BlackScreenWithImageState();
}

class _BlackScreenWithImageState extends State<BlackScreenWithImage> with SingleTickerProviderStateMixin {

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: double.infinity,
          width: double.infinity,

          child: Hero(

            tag: 'service_${widget.data[0]}',
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20,right: 20),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            size: 30,
                            Icons.cancel,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )

                  ),
                ),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,

                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return /*Image.network(
                          "http://85.31.236.78:3000/" + widget.data[index].toString(),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 4,
                          fit: BoxFit.cover,
                        );*/
                          PhotoView(
                            imageProvider: NetworkImage("http://85.31.236.78:3000/" + widget.data[index].toString(),),
                          );
                      },
                    ),
                  ),
                ),


                // Cross Icon

              ],
            ),
          ),
        ),
      ),
    );
  }
}

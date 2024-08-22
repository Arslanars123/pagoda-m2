import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/models/serve.dart';
import 'package:pagoda/utils/global.dart';

class TabList extends StatefulWidget {
  const TabList({super.key, required this.categories});

  final List<Category> categories;

  @override
  State<TabList> createState() => _TabListState();
}

class _TabListState extends State<TabList> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: widget.categories.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                dividerColor: Colors.transparent,
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.white,
                labelStyle: TextStyle(fontSize: 17),
                unselectedLabelColor: Colors.grey,
                indicator: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.transparent, // Remove the box shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0XFF8089BC),
                ),
                tabs: widget.categories.map((category) {
                  return Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        category.title,
                        style: GoogleFonts.lato(fontSize: 18),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 400, // Adjust height as needed
                child: TabBarView(
                  controller: _tabController,
                  children: widget.categories.map((category) {
                    print(widget.categories[2].image);
                    return SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: _buildFoodTile(category, height, width),
                    );
                  }).toList(),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LISTA ALLERGENI',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFoodTile(Category category, var height, var width) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          Container(
            width: width / 1.2,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: height / 4.6,
                    width: width / 1.3,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(
                              0.2), // Shadow color with low opacity
                          spreadRadius: 1, // How much the shadow spreads
                          blurRadius: 5, // How much the shadow is blurred
                          offset: Offset(2, 2), // The position of the shadow
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: width / 4,
                          right: width / 30,
                          top: height / 30,
                          bottom: height / 30),
                      child: Text(
                        language == true ? category.titleI : category.titleI,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: const Color(0xFF777777),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: height / 8,
                  width: width / 3.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blue,
                    image: DecorationImage(
                      image: NetworkImage(
                        "http://85.31.236.78:3000/" + category.image,
                      ),
                      fit: BoxFit
                          .cover, // Ensures the image covers the container while maintaining aspect ratio
                    ),
                  ),
                ),
              ],
            ),
          )
          //   Stack(
          //     clipBehavior: Clip.none,
          //     children: [
          //       Container(
          //         width: MediaQuery.of(context).size.width * 0.82,
          //         decoration: BoxDecoration(
          //           color: const Color(0XFFFFFFFF),
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             const Column(
          //               children: [SizedBox(height: 75, width: 115)],
          //             ),
          //             const SizedBox(width: 10),
          //             Expanded(

          //               child: Container(
          //                 color: Colors.blue,
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: Column(
          //                     children: [
          //                       Text(
          //                         category.title,
          //                         style: GoogleFonts.montserrat(
          //                           fontWeight: FontWeight.w600,
          //                           fontSize: 16,
          //                           color: const Color(0xFF777777),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       Positioned(
          //         left: -20,
          //         child: Container(
          //           height: 120,
          //           width: 120,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(8),
          //           ),
          //           child: ClipRRect(
          //             borderRadius: BorderRadius.circular(8),
          //             child: Image.network(
          //               'https://cxgveiouca.cloudimg.io/familyhotelfinder.com/wp-content/uploads/Traditional-Italian-foods-to-try-in-Italy-SH-Gnocchi-Con-Sugo-Di-Carne.jpg?w=350&h=220&func=cover',
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // const Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //             'LISTA ALLERGENI',
          //             style: TextStyle(decoration: TextDecoration.underline),
          //           ),
          //         ],
          //       ),
          //       const SizedBox(height: 30),
        ],
      ),
    );
  }
}

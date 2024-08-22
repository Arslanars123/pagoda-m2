import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/models/product.dart';
import 'package:pagoda/views/products_of_category.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final String BASE_URL = 'http://85.31.236.78:3000';

  late Future<List<Product>> _futureExperiencesList;

  Future<List<Product>> _fetchExperiences() async {
    Uri uriObject = Uri.parse('$BASE_URL/get-products-with-category');

    final response = await http.get(uriObject);

    if (response.statusCode == 200) {
      List<dynamic> parsedListJson = jsonDecode(response.body);

      List<Product> experiencesList = parsedListJson
          .map<Product>((dynamic product) => Product.fromJson(product))
          .toList();

      return experiencesList;
    } else {
      throw Exception('Failed to load experiences');
    }
  }

  @override
  void initState() {
    super.initState();

    _futureExperiencesList = _fetchExperiences();
  }

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: FutureBuilder(
        future: _futureExperiencesList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: ListView.builder(

                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                 var product = snapshot.data![index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: InkWell(
                      onTap: (){
                             Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  BuyScreen(id:snapshot.data![index].id)),
                      );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                              boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2), // Shadow color with low opacity
                              spreadRadius: 1, // How much the shadow spreads
                              blurRadius: 5, // How much the shadow is blurred
                              offset: Offset(2, 2), // The position of the shadow
                            ),
                          ],
                        ),
                      
                        child: Column(
                          children: [
                            Container(
                      
                              height: MediaQuery.of(context).size.height / 4.5,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      
                                image: DecorationImage(
                                  image: NetworkImage(      '$BASE_URL/${product.image}',),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0XFFFFFFFF),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05), // Shadow color
                                    spreadRadius: 2, // How much the shadow spreads
                                    blurRadius: 6, // How blurry the shadow is
                                    offset: Offset(0, 4), // Position of the shadow
                                  ),
                                ],
                              ),
                      
                              padding: const EdgeInsets.only(
                                left: 18,
                                top: 14,
                                right: 0,
                                bottom: 14,
                              ),
                              width: MediaQuery.of(context).size.width,
                      
                              child: Text(
                                 product.title,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: const Color(0xFF777777),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                  
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

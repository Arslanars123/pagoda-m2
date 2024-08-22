import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pagoda/utils/global.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/orders.dart';
import '../providers/product_of_provider.dart';
import '../utils/product_card.dart';

class BuyScreen extends StatefulWidget {
  final String id;

  BuyScreen({required this.id});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  @override
  void initState() {
    super.initState();
    // Call the fetchProducts method when the screen initializes
    Provider.of<ProductProvider>(context, listen: false).fetchProducts(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Beach bar',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: const Color(0xFF777777),
          ),
        ),
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xFF777777),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            height: 35,
            width: 35,
            child: ClipOval(
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/en/thumb/0/03/Flag_of_Italy.svg/1500px-Flag_of_Italy.svg.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, _) {
          if (productProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (productProvider.error != null) {
            return Center(child: Text(productProvider.error!));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: productProvider.products.length,
                      itemBuilder: (context, index) {
                        final product = productProvider.products[index];
                        print(product);
                        return Column(
                          children: [
                            ProductCard(
                              productId: productProvider.products[index]['_id'],
                              imageUrl: product['image']?? "",
                              category: product['category']?? "data",
                              title: product[language == true?'nameI':'name'],
                              price: double.parse(product['price'])
                            ),

                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                  ),
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 20),
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                await cartProvider.sendData();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[400],
                                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'Now',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          if (cartProvider.isLoading)
                            const CircularProgressIndicator(),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

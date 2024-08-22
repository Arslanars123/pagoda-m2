import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'global.dart';

class ProductCard extends StatefulWidget {
  final String imageUrl;
  final String category;
  final String title;
  final double price;
  final String productId; // Add this line

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.price,
    required this.productId, // Add this line
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _quantity = 1;
   // Initialize a cart list

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _addToCart() {
    setState(() {
      // Find the existing product in the cart
      final existingProduct = cart.firstWhere(
            (item) => item['productId'] == widget.productId,
        orElse: () => <String, dynamic>{}, // Return an empty map to avoid null
      );

      if (existingProduct.isNotEmpty) {
        // If the product already exists, update its quantity
        existingProduct['quantity'] = _quantity;
      } else {
        // If the product doesn't exist, add it to the cart
        cart.add({
          "serviceId":null,
          'productId': widget.productId,
          'quantity': _quantity,
        });
      }
    });

    print(cart); // Print cart for debugging
  }


  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.price * _quantity;

    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.82,
            decoration: BoxDecoration(
              color: const Color(0XFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                //
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // space on left of card
                    const SizedBox(height: 120, width: 120),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //
                            Text(
                              widget.category,
                              maxLines: 1,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: const Color(0xFF777777),
                              ),
                            ),

                            Text(
                              widget.title,
                              maxLines: 3,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: const Color.fromARGB(255, 38, 132, 219),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // price + qty counter
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          '€ ${totalPrice.toStringAsFixed(2)}',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: const Color.fromARGB(255, 38, 132, 219),
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          //
                          IconButton(
                            highlightColor: Colors.blue,
                            visualDensity: VisualDensity.compact,
                            icon: const Icon(Icons.remove_circle_outline),
                            color: Colors.blue,
                            onPressed:(){
                              _decrementQuantity();
                              _addToCart();
                            }
                          ),

                          Text(
                            '$_quantity',
                            style: const TextStyle(fontSize: 16),
                          ),

                          IconButton(
                            visualDensity: VisualDensity.compact,
                            icon: const Icon(Icons.add_circle_outline),
                            color: Colors.blue,
                            onPressed: () {
                              _incrementQuantity();
                              _addToCart(); // Call _addToCart when add button is pressed
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: -20,
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "http://85.31.236.78:3000/" + widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

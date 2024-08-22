class Product {
  final String id;
  final String title;
  final String titleI;
  final String image;
  final List<dynamic> products;

  Product({
    required this.id,
    required this.title,
    required this.titleI,
    required this.image,
    required this.products,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] as String,
      title: json['title'] as String,
      titleI: json['titleI'] as String,
      image: json['image'] as String,
      products: json['products'] as List<dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'titleI': titleI,
      'image': image,
      'products': products,
    };
  }
}

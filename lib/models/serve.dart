class Serve {
  final String id;
  final String name;
  final String nameI;
  final String openTime;
  final String closeTime;
  final String description;
  final String descriptionI;
  final String image;
  final List<dynamic> images;
  final List<Category> pcatsIds;

  Serve({
    required this.id,
    required this.name,
    required this.nameI,
    required this.openTime,
    required this.closeTime,
    required this.description,
    required this.descriptionI,
    required this.image,
    required this.images,
    required this.pcatsIds,
  });

  factory Serve.fromJson(Map<String, dynamic> json) {
    var list = json['pcatsIds'] as List;
    List<Category> pcatsIdsList =
        list.map((i) => Category.fromJson(i)).toList();

    return Serve(
      id: json['_id'] as String,
      name: json['name'] as String,
      nameI: json['nameI'] as String,
      openTime: json['openTime'] as String,
      closeTime: json['closeTime'] as String,
      description: json['description'] as String,
      descriptionI: json['descriptionI'] as String,
      image: json['image'] as String,
      images: json['images'] as List<dynamic>,
      pcatsIds: pcatsIdsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'nameI': nameI,
      'openTime': openTime,
      'closeTime': closeTime,
      'description': description,
      'descriptionI': descriptionI,
      'image': image,
      'images': images,
      'pcatsIds': pcatsIds.map((e) => e.toJson()).toList(),
    };
  }
}

class Category {
  final String id;
  final String title;
  final String titleI;
  final String image;

  Category({
    required this.id,
    required this.title,
    required this.titleI,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] as String,
      title: json['title'] as String,
      titleI: json['titleI'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'titleI': titleI,
      'image': image,
    };
  }
}

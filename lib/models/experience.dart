class Experience {
  final String id;
  final String name;
  final String nameI;
  final String description;
  final String descriptionI;
  final String availableDays;
  final String minimumPerson;
  final String preavviso;
  final String toggle;
  final String image;
  final int version;

  Experience({
    required this.id,
    required this.name,
    required this.nameI,
    required this.description,
    required this.descriptionI,
    required this.availableDays,
    required this.minimumPerson,
    required this.preavviso,
    required this.toggle,
    required this.image,
    required this.version,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['_id'],
      name: json['name'],
      nameI: json['nameI'],
      description: json['description'],
      descriptionI: json['descriptionI'],
      availableDays: json['availableDays'],
      minimumPerson: json['minimumPerson'],
      preavviso: json['preavviso'],
      toggle: json['toggle'],
      image: json['image'],
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'nameI': nameI,
      'description': description,
      'descriptionI': descriptionI,
      'availableDays': availableDays,
      'minimumPerson': minimumPerson,
      'preavviso': preavviso,
      'toggle': toggle,
      'image': image,
      '__v': version,
    };
  }
}

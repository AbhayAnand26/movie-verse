class Show {
  final int id;
  final String name;
  final List<String> genres;
  final double? rating;
  final String? summary;
  final String? imageUrl;

  Show({
    required this.id,
    required this.name,
    this.genres = const [],
    this.rating,
    this.summary,
    this.imageUrl,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'],
      name: json['name'],
      genres: List<String>.from(json['genres'] ?? []),
      rating: json['rating'] != null ? (json['rating']['average']?.toDouble()) : null,
      summary: json['summary'],
      imageUrl:  json['image']?['medium'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'genres': genres,
      'rating': rating,
      'summary': summary,
      'imageUrl': imageUrl,
    };
  }

  factory Show.fromMap(Map<dynamic, dynamic> map) {
    return Show(
      id: map['id'],
      name: map['name'],
      genres: List<String>.from(map['genres'] ?? []),
      rating: map['rating']?.toDouble(),
      summary: map['summary'],
      imageUrl: map['imageUrl'],
    );
  }
}

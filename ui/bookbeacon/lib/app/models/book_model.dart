import 'dart:convert';

class BookModel {
  final int id;
  final String isbn13;
  final String isbn10;
  final String title;
  final String subtitle;
  final String authors;
  final String categories;
  final String thumbnail;
  final String description;
  final String publishedYear;
  final String averageRating;
  final String numPages;
  final String ratingsCount;
  BookModel({
    this.id = 0,
    required this.isbn13,
    required this.isbn10,
    required this.title,
    required this.subtitle,
    required this.authors,
    required this.categories,
    required this.thumbnail,
    required this.description,
    required this.publishedYear,
    required this.averageRating,
    required this.numPages,
    required this.ratingsCount,
  });

  BookModel copyWith({
    int? id,
    String? isbn13,
    String? isbn10,
    String? title,
    String? subtitle,
    String? authors,
    String? categories,
    String? thumbnail,
    String? description,
    String? publishedYear,
    String? averageRating,
    String? numPages,
    String? ratingsCount,
  }) {
    return BookModel(
      id: id ?? this.id,
      isbn13: isbn13 ?? this.isbn13,
      isbn10: isbn10 ?? this.isbn10,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      authors: authors ?? this.authors,
      categories: categories ?? this.categories,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
      publishedYear: publishedYear ?? this.publishedYear,
      averageRating: averageRating ?? this.averageRating,
      numPages: numPages ?? this.numPages,
      ratingsCount: ratingsCount ?? this.ratingsCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isbn13': isbn13,
      'isbn10': isbn10,
      'title': title,
      'subtitle': subtitle,
      'authors': authors,
      'categories': categories,
      'thumbnail': thumbnail,
      'description': description,
      'published_year': publishedYear,
      'average_rating': averageRating,
      'num_pages': numPages,
      'ratings_count': ratingsCount,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      isbn13: map['isbn13'] ?? '',
      isbn10: map['isbn10'] ?? '',
      title: map['title'] ?? '',
      subtitle: map['authors'] ?? '',
      authors: map['authors'] ?? '',
      categories: map['categories'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      description: map['description'] ?? '',
      publishedYear: map['published_year'] ?? '',
      averageRating: map['average_rating'] ?? '',
      numPages: map['num_pages'] ?? '',
      ratingsCount: map['ratings_count'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) => BookModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookModel(id: $id, isbn13: $isbn13, isbn10: $isbn10, title: $title, subtitle: $subtitle, authors: $authors, categories: $categories, thumbnail: $thumbnail, description: $description, published_year: $publishedYear, average_rating: $averageRating, num_pages: $numPages, ratings_count: $ratingsCount)';
  }

  @override
  bool operator ==(covariant BookModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.isbn13 == isbn13 &&
      other.isbn10 == isbn10 &&
      other.title == title &&
      other.subtitle == subtitle &&
      other.authors == authors &&
      other.categories == categories &&
      other.thumbnail == thumbnail &&
      other.description == description &&
      other.publishedYear == publishedYear &&
      other.averageRating == averageRating &&
      other.numPages == numPages &&
      other.ratingsCount == ratingsCount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      isbn13.hashCode ^
      isbn10.hashCode ^
      title.hashCode ^
      subtitle.hashCode ^
      authors.hashCode ^
      categories.hashCode ^
      thumbnail.hashCode ^
      description.hashCode ^
      publishedYear.hashCode ^
      averageRating.hashCode ^
      numPages.hashCode ^
      ratingsCount.hashCode;
  }
}

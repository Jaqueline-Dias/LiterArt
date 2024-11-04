import 'models.dart';

class VolumeInfo {
  String title;
  List<String> authors;
  String publishedDate;
  List<String>? categories; // Para categorias
  int? pageCount; // Para número de páginas
  String? language; // Para idioma
  String description;
  ImageLinks imageLinks;

  VolumeInfo({
    required this.title,
    required this.authors,
    required this.publishedDate,
    required this.description,
    required this.imageLinks,
    required this.categories,
    required this.language,
    required this.pageCount,
  });

  factory VolumeInfo.fromApiJson(Map<String, dynamic> json) {
    return VolumeInfo(
      title: json['title'] ?? '',
      authors: json['authors'] == null
          ? []
          : List<String>.from(json['authors'].map((x) => x)),
      publishedDate: json['publishedDate'] ?? '',
      categories: List<String>.from(json['categories'] ?? []),
      pageCount: json['pageCount'],
      language: json['language'],
      description: json['description'] ?? '',
      imageLinks: ImageLinks.fromApiJson(json['imageLinks'] ??
          {
            'thumbnail':
                "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
          }),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'authors': authors,
      'publishedDate': publishedDate,
      'categories': categories,
      'pageCount': pageCount,
      'language': language,
      'description': description,
      'imageLinks': imageLinks.toJson(),
    };
  }
}

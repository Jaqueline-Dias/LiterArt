class ImageLinks {
  final String? thumbnail; // Permite que thumbnail seja null

  ImageLinks({this.thumbnail});

  factory ImageLinks.fromApiJson(Map<String, dynamic> json) {
    return ImageLinks(
      thumbnail: json['thumbnail']
          as String?, // Define como null se não estiver presente
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (thumbnail != null) 'thumbnail': thumbnail,
    };
  }
}

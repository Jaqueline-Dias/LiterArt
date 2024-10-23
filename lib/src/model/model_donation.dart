import 'package:cloud_firestore/cloud_firestore.dart';

class ModelDonation {
  String? donationUid;
  String? userUid;
  String? bookCover;
  String? title;
  String? author;
  String? category;
  int? pageNumber;
  String? language;
  String? synopsis;
  Timestamp? publicationDate;
  bool? conservation;
  List<dynamic>? photos;
  String? address;
  String? profilePicture;

  ModelDonation({
    this.donationUid,
    this.userUid,
    this.bookCover,
    this.title,
    this.author,
    this.category,
    this.pageNumber,
    this.language,
    this.synopsis,
    this.publicationDate,
    this.conservation,
    this.photos,
    this.address,
    this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return {
      if (donationUid != null) 'donationUid': donationUid,
      if (userUid != null) 'userUid': userUid,
      if (bookCover != null) 'bookCover': bookCover,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (category != null) 'category': category,
      if (pageNumber != null) 'pageNumber': pageNumber,
      if (language != null) 'language': language,
      if (synopsis != null) 'synopsis': synopsis,
      if (publicationDate != null) 'publicationDate': publicationDate,
      if (conservation != null) 'conservation': conservation,
      if (photos != null) 'photos': photos,
      if (address != null) 'address': address,
      if (profilePicture != null) 'profile': profilePicture,
    };
  }

  ModelDonation.fromJson(Map<String, dynamic> json)
      : donationUid = json['donationUid'],
        userUid = json['userUid'],
        bookCover = json['bookCover'],
        title = json['title'],
        author = json['author'],
        category = json['category'],
        pageNumber = json['pageNumber'],
        language = json['language'],
        synopsis = json['synopsis'],
        publicationDate = json['publicationDate'],
        conservation = json['conservation'],
        photos = json['photos'],
        address = json['address'],
        profilePicture = json['profile'];

  factory ModelDonation.fromDocument(DocumentSnapshot doc) {
    final dados = doc.data()! as Map<String, dynamic>;
    return ModelDonation.fromJson(dados);
  }

  @override
  String toString() {
    return "Doação: $donationUid\n Autor: $author";
  }
}

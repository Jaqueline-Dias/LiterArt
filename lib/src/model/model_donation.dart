import 'package:cloud_firestore/cloud_firestore.dart';

class ModelDonation {
  String? donationUid;
  String? userUid;
  String? title;
  String? authors;
  String? bookCover;
  String? category;
  int? pageNumber;
  String? language;
  String? synopsis;
  Timestamp? publicationDate;
  String? conservation;
  List<dynamic>? photos;
  String? address;
  String? profilePicture;

  ModelDonation({
    this.donationUid,
    this.userUid,
    this.title,
    this.authors,
    this.bookCover,
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
      if (title != null) 'title': title,
      if (authors != null) 'authors': authors,
      if (bookCover != null) 'bookCover': bookCover,
      if (category != null) 'category': category,
      if (pageNumber != null) 'pageNumber': pageNumber,
      if (language != null) 'language': language,
      if (synopsis != null) 'synopsis': synopsis,
      if (publicationDate != null) 'publicationDate': publicationDate,
      if (conservation != null) 'conservation': conservation,
      if (photos != null) 'photos': photos,
      if (address != null) 'address': address,
      if (profilePicture != null) 'profilePicture': profilePicture
    };
  }

  ModelDonation.fromJson(Map<String, dynamic> json)
      : donationUid = json['donationUid'],
        userUid = json['userUid'],
        bookCover = json['bookCover'],
        title = json['title'],
        authors = json['authors'],
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
    return 'ModelDonation(donationUid: $donationUid, userUid: $userUid, title: $title, bookCover: $bookCover, authors: $authors, category: $category, pageNumber: $pageNumber, language: $language, synopsis: $synopsis, publicationDate: $publicationDate, conservation: $conservation, photos: $photos, address: $address, profilePicture: $profilePicture)';
  }
}

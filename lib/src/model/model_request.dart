import 'package:cloud_firestore/cloud_firestore.dart';

class ModelRequest {
  String? requestUid;
  String? userUid;
  String? bookCover;
  String? title;
  String? author;
  String? category;
  int? pageNumber;
  Timestamp? publicationDate;
  String? description;
  String? profilePicture;

  ModelRequest({
    this.requestUid,
    this.userUid,
    this.bookCover,
    this.title,
    this.author,
    this.category,
    this.pageNumber,
    this.publicationDate,
    this.description,
    this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return {
      if (requestUid != null) 'requestUid': requestUid,
      if (userUid != null) 'userUid': userUid,
      if (bookCover != null) 'bookCover': bookCover,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (category != null) 'category': category,
      if (pageNumber != null) 'pageNumber': pageNumber,
      if (publicationDate != null) 'publicationDate': publicationDate,
      if (description != null) 'description': description,
      if (profilePicture != null) 'profilePicture': profilePicture,
    };
  }

  ModelRequest.fromJson(Map<String, dynamic> json)
      : requestUid = json['requestUid'],
        userUid = json['userUid'],
        bookCover = json['bookCover'],
        title = json['title'],
        author = json['author'],
        category = json['category'],
        pageNumber = json['pageNumber'],
        publicationDate = json['publicationDate'],
        description = json['description'],
        profilePicture = json['profilePicture'];

  factory ModelRequest.fromDocument(DocumentSnapshot doc) {
    final dados = doc.data()! as Map<String, dynamic>;
    return ModelRequest.fromJson(dados);
  }

  @override
  String toString() {
    return "Solicitação: $requestUid\n Autor: $author";
  }
}

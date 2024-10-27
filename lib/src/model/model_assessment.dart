import 'package:cloud_firestore/cloud_firestore.dart';

class ModelAssessment {
  String? assessmentUid;
  String? userUid;
  String? bookCover;
  String? title;
  String? author;
  String? category;
  int? pageNumber;
  Timestamp? publicationDate;
  int? pagesRead;
  String? comment;
  int? note;
  String? profilePicture;

  ModelAssessment({
    this.assessmentUid,
    this.userUid,
    this.bookCover,
    this.title,
    this.author,
    this.category,
    this.pageNumber,
    this.publicationDate,
    this.pagesRead,
    this.comment,
    this.note,
    this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return {
      if (assessmentUid != null) 'assessmentUid': assessmentUid,
      if (userUid != null) 'userUid': userUid,
      if (bookCover != null) 'bookCover': bookCover,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (category != null) 'category': category,
      if (pageNumber != null) 'pageNumber': pageNumber,
      if (publicationDate != null) 'publicationDate': publicationDate,
      if (pagesRead != null) 'pagesRead': pagesRead,
      if (comment != null) 'comment': comment,
      if (note != null) 'note': note,
      if (profilePicture != null) 'profilePicture': profilePicture,
    };
  }

  ModelAssessment.fromJson(Map<String, dynamic> json)
      : assessmentUid = json['assessmentUid'],
        userUid = json['userUid'],
        bookCover = json['bookCover'],
        title = json['title'],
        author = json['author'],
        category = json['category'],
        pageNumber = json['pageNumber'],
        publicationDate = json['publicationDate'],
        pagesRead = json['pagesRead'],
        comment = json['comment'],
        profilePicture = json['profilePicture'],
        note = json['note'];

  factory ModelAssessment.fromDocument(DocumentSnapshot doc) {
    final dados = doc.data()! as Map<String, dynamic>;
    return ModelAssessment.fromJson(dados);
  }

  @override
  String toString() {
    return "Solicitação: $assessmentUid\n Autor: $author";
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class ModelAssessment {
  String? assessmentUid;
  String? userUid;
  String? bookCover;
  String? title;
  String? authors;
  String? category;
  int? pageNumber;
  Timestamp? publicationDate;
  int? pagesRead;
  String? comment;
  double? note;

  ModelAssessment({
    this.assessmentUid,
    this.userUid,
    this.bookCover,
    this.title,
    this.authors,
    this.category,
    this.pageNumber,
    this.publicationDate,
    this.pagesRead,
    this.comment,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      if (assessmentUid != null) 'assessmentUid': assessmentUid,
      if (userUid != null) 'userUid': userUid,
      if (bookCover != null) 'bookCover': bookCover,
      if (title != null) 'title': title,
      if (authors != null) 'authors': authors,
      if (category != null) 'category': category,
      if (pageNumber != null) 'pageNumber': pageNumber,
      if (publicationDate != null) 'publicationDate': publicationDate,
      if (pagesRead != null) 'pagesRead': pagesRead,
      if (comment != null) 'comment': comment,
      if (note != null) 'note': note,
    };
  }

  ModelAssessment.fromJson(Map<String, dynamic> json)
      : assessmentUid = json['assessmentUid'],
        userUid = json['userUid'],
        bookCover = json['bookCover'],
        title = json['title'],
        authors = json['authors'],
        category = json['category'],
        pageNumber = json['pageNumber'],
        publicationDate = json['publicationDate'],
        pagesRead = json['pagesRead'],
        comment = json['comment'],
        note = json['note'];

  factory ModelAssessment.fromDocument(DocumentSnapshot doc) {
    final dados = doc.data()! as Map<String, dynamic>;
    return ModelAssessment.fromJson(dados);
  }

  @override
  String toString() {
    return "Solicitação: $assessmentUid\n Autor: $authors";
  }
}

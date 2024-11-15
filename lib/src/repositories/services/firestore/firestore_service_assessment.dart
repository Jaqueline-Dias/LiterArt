import 'package:app_liter_art/src/model/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServiceAssessment {
  final CollectionReference assessments =
      FirebaseFirestore.instance.collection('assessments');

  Future<void> createAssessment({
    String? userUid,
    String? title,
    String? authors,
    String? bookCover,
    String? category,
    int? pagesRead,
    String? comment,
    int? pageNumber,
    double? note,
  }) async {
    final assessment = ModelAssessment(
      // donationUid: donations.doc().id,
      userUid: userUid,
      title: title,
      authors: authors,
      bookCover: bookCover,
      category: category,
      pageNumber: pageNumber,
      pagesRead: pagesRead,
      publicationDate: Timestamp.now(),
      comment: comment,
      note: note,
    );

    await assessments.add(assessment.toMap());
  }
}

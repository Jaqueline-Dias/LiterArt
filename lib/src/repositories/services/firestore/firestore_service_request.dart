import 'package:app_liter_art/src/model/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServiceRequest {
  final CollectionReference donations =
      FirebaseFirestore.instance.collection('requests');

  Future<void> createRequest({
    String? userUid,
    String? title,
    String? authors,
    String? bookCover,
    String? category,
    int? pageNumber,
    String? language,
    String? description,
  }) async {
    final donation = ModelRequest(
      // donationUid: donations.doc().id,
      userUid: userUid,
      title: title,
      authors: authors,
      bookCover: bookCover,
      category: category,
      pageNumber: pageNumber,

      publicationDate: Timestamp.now(),
      description: description,
    );

    await donations.add(donation.toMap());
  }
}

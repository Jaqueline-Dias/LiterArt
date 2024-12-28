import 'package:app_liter_art/src/model/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServiceDonation {
  final CollectionReference donations =
      FirebaseFirestore.instance.collection('donations');

  Future<void> createDonation({
    String? userUid,
    String? title,
    String? authors,
    String? bookCover,
    String? category,
    int? pageNumber,
    String? language,
    String? synopsis,
    String? conservation,
    List<dynamic>? photos,
    String? address,
    bool? status,
  }) async {
    final donation = ModelDonation(
      // donationUid: donations.doc().id,
      userUid: userUid,
      title: title,
      authors: authors,
      bookCover: bookCover,
      category: category,
      pageNumber: pageNumber,
      language: language,
      synopsis: synopsis,
      publicationDate: Timestamp.now(),
      conservation: conservation ?? 'Usado',
      photos: photos ?? [],
      address: address,
      status: status = false,
    );

    await donations.add(donation.toMap());
  }
}

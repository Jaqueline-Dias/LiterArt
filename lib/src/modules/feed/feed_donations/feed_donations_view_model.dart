import 'package:app_liter_art/src/core/utils/utils.dart';
import 'package:app_liter_art/src/model/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signals_flutter/signals_flutter.dart';

class FeedDonationsViewModel {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final LAUtils utils = LAUtils();

  // Estado de carregamento das doações
  final Signal<List<Map<String, dynamic>>> donations = signal([]);
  final Signal<bool> isLoading = signal(true);
  final Signal<String?> errorMessage = signal(null);

  int getDonationCountByCategory(String category) {
    return donations.value
        .where((donation) =>
            (donation['post'] as ModelDonation).category == category)
        .length;
  }

  FeedDonationsViewModel() {
    fetchDonationsWithUserDetails();
  }

  Future<void> fetchDonationsWithUserDetails() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      QuerySnapshot snapshot = await db
          .collection('donations')
          .orderBy('publicationDate', descending: true)
          .get();

      List<Map<String, dynamic>> donationDataList = [];

      for (var document in snapshot.docs) {
        ModelDonation docs = ModelDonation.fromDocument(document);
        Map<String, dynamic> userDetails =
            await utils.getUserDetails(docs.userUid!);
        donationDataList.add({'post': docs, 'user': userDetails});
      }
      donations.value = donationDataList;
    } catch (e, stacktrace) {
      print("Erro ao recuperar os dados: $e");
      print("Stacktrace: $stacktrace");
      errorMessage.value = "Erro ao recuperar os dados";
    } finally {
      isLoading.value = false;
    }
  }
}

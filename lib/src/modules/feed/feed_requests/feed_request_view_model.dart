import 'package:app_liter_art/src/core/utils.dart';
import 'package:app_liter_art/src/model/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signals_flutter/signals_flutter.dart';

class FeedRequestViewModel {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final Utils utils = Utils();

  // Estado de carregamento das doações
  final Signal<List<Map<String, dynamic>>> requests = signal([]);
  final Signal<bool> isLoading = signal(true);
  final Signal<String?> errorMessage = signal(null);

  FeedRequestViewModel() {
    fetchRequestsWithUserDetails();
  }

  Future<void> fetchRequestsWithUserDetails() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      QuerySnapshot snapshot = await db
          .collection('requests')
          .orderBy('publicationDate', descending: true)
          .get();

      List<Map<String, dynamic>> requestDataList = [];

      for (var document in snapshot.docs) {
        ModelRequest docs = ModelRequest.fromDocument(document);
        Map<String, dynamic> userDetails =
            await utils.getUserDetails(docs.userUid!);
        requestDataList.add({'post': docs, 'user': userDetails});
      }
      requests.value = requestDataList;
    } catch (e, stacktrace) {
      print("Erro ao recuperar os dados: $e");
      print("Stacktrace: $stacktrace");
      errorMessage.value = "Erro ao recuperar os dados";
    } finally {
      isLoading.value = false;
    }
  }
}

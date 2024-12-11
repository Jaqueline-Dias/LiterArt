import 'package:app_liter_art/src/core/utils/utils.dart';
import 'package:app_liter_art/src/model/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signals_flutter/signals_flutter.dart';

class FeedAssessmentViewModel {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final LAUtils utils = LAUtils();

  // Estado de carregamento das avaliações
  final Signal<List<Map<String, dynamic>>> assessments = signal([]);
  final Signal<bool> isLoading = signal(true);
  final Signal<String?> errorMessage = signal(null);

  FeedAssessmentViewModel() {
    fetchAssessmentsWithUserDetails();
  }

  Future<void> fetchAssessmentsWithUserDetails() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      QuerySnapshot snapshot = await db
          .collection('assessments')
          .orderBy('publicationDate', descending: true)
          .get();

      List<Map<String, dynamic>> assessmentDataList = [];

      for (var document in snapshot.docs) {
        ModelAssessment docs = ModelAssessment.fromDocument(document);
        Map<String, dynamic> userDetails =
            await utils.getUserDetails(docs.userUid!);
        assessmentDataList.add({'post': docs, 'user': userDetails});
      }
      assessments.value = assessmentDataList;
    } catch (e, stacktrace) {
      print("Erro ao recuperar os dados: $e");
      print("Stacktrace: $stacktrace");
      errorMessage.value = "Erro ao recuperar os dados";
    } finally {
      isLoading.value = false;
    }
  }
}

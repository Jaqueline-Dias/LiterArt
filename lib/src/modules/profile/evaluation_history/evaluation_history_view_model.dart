import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EvaluationHistoryViewModel {
  final String collectionEvaluations = 'assessments';

  Future<void> deletePost(String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionEvaluations)
          .doc(postId)
          .delete();
    } catch (e) {
      debugPrint("Erro ao excluir relato: $e");
    }
  }
}

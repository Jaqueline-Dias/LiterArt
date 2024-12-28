import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserViewModel {
  Future<Map<String, int>> getUserContributions(String userUid) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Contando as doações do usuário
      final donationsQuery = await firestore
          .collection('donations')
          .where('userUid', isEqualTo: userUid)
          .get();
      final int donationsCount = donationsQuery.docs.length;

      // Contando as avaliações do usuário
      final assessmentsQuery = await firestore
          .collection('assessments')
          .where('userUid', isEqualTo: userUid)
          .get();
      final int assessmentsCount = assessmentsQuery.docs.length;

      return {
        'donations': donationsCount,
        'assessments': assessmentsCount,
      };
    } catch (e) {
      debugPrint('Erro ao obter contribuições do usuário: $e');
      return {
        'donations': 0,
        'assessments': 0,
      };
    }
  }
}

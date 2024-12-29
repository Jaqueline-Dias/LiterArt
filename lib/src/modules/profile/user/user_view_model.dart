import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserViewModel {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, int>> getUserContributions(String userUid) async {
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

      // Contando as solicitações do usuário
      final requestsQuery = await firestore
          .collection('requests')
          .where('userUid', isEqualTo: userUid)
          .get();
      final int requestesCount = requestsQuery.docs.length;

      return {
        'donations': donationsCount,
        'assessments': assessmentsCount,
        'requests': requestesCount,
      };
    } catch (e) {
      debugPrint('Erro ao obter contribuições do usuário: $e');
      return {
        'donations': 0,
        'assessments': 0,
        'requests': 0,
      };
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(user.uid).get();
      return snapshot.data() as Map<String, dynamic>?;
    }
    return null;
  }
}

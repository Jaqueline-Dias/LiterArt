import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DonationHistoryViewModel {
  final String collectionDonations = 'donations';

  Future<void> deletePost(String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionDonations)
          .doc(postId)
          .delete();
    } catch (e) {
      debugPrint("Erro ao excluir relato: $e");
    }
  }
}

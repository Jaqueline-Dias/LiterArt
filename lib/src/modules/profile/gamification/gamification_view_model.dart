import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GamificationViewModel {
  int selectedTabIndex = 0;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<int> getPointsStream(String userUid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      return data != null && data['points'] is int ? data['points'] as int : 0;
    });
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

  // Função para retornar o título com base nos pontos
  String getTitle(int points) {
    if (points >= 650) {
      return LATexts.titleMedal8;
    } else if (points >= 550) {
      return LATexts.titleMedal7;
    } else if (points >= 450) {
      return LATexts.titleMedal5;
    } else if (points >= 350) {
      return LATexts.titleMedal6;
    } else if (points >= 250) {
      return LATexts.titleMedal4;
    } else if (points >= 150) {
      return LATexts.titleMedal3;
    } else if (points >= 100) {
      return LATexts.titleMedal2;
    } else if (points >= 50) {
      return LATexts.titleMedal1;
    } else {
      return LATexts.titleMedalDefault;
    }
  }

  // Função para retornar o caminho da medalha com base no título
  String getMedalAsset(String title) {
    switch (title) {
      case LATexts.titleMedal8:
        return LAImages.medalImage8;
      case LATexts.titleMedal7:
        return LAImages.medalImage7;
      case LATexts.titleMedal5:
        return LAImages.medalImage6;
      case LATexts.titleMedal6:
        return LAImages.medalImage5;
      case LATexts.titleMedal4:
        return LAImages.medalImage4;
      case LATexts.titleMedal3:
        return LAImages.medalImage3;
      case LATexts.titleMedal2:
        return LAImages.medalImage2;
      case LATexts.titleMedal1:
        return LAImages.medalImage1;
      default:
        return LAImages.medalImageDefault;
    }
  }
}

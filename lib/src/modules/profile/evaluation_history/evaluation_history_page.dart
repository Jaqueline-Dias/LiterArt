import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/modules/profile/evaluation_history/evaluation_history_view_model.dart';
import 'package:app_liter_art/src/modules/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EvaluationHistoryPage extends StatefulWidget {
  const EvaluationHistoryPage({
    super.key,
  });

  @override
  State<EvaluationHistoryPage> createState() => _EvaluationHistoryPageState();
}

class _EvaluationHistoryPageState extends State<EvaluationHistoryPage> {
  User? user = FirebaseAuth.instance.currentUser;
  EvaluationHistoryViewModel viewModel = EvaluationHistoryViewModel();

  void _confirmDelete(BuildContext context, String postId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmar Exclusão"),
          content: const Text("Tem certeza que deseja excluir?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                viewModel.deletePost(postId);
              },
              child: const Text(
                "Excluir",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: LAColors.buttonPrimary,
            size: 32,
          ),
        ),
        title: const Text(LATexts.evaluationsHistoryAppbar),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LAButtonHistorys(
              icon: LAImages.iconAssessment,
              title: LATexts.evaluationsHistoryTitle1,
              onTap: () {
                Navigator.of(context).pushNamed('/service/search');
              },
            ),
            const SizedBox(height: 24),
            const Text(
              LATexts.evaluationsHistoryTitle2,
              style: LAAppTheme.authorMobileDateStyle,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('assessments')
                    .where('userUid', isEqualTo: user?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text(LATexts.onBoardingTitle3));
                  }
                  final List<DocumentSnapshot> donations = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: donations.length,
                    itemBuilder: (context, index) {
                      final donation = donations[index];
                      final data = donation.data() as Map<String, dynamic>;
                      final docId = donation.id;
                      return LACardHistorys(
                        docId: docId,
                        date: data['publicationDate'],
                        imageBook: data['bookCover'],
                        title: data['title'],
                        authors: data['authors'],
                        category: data['category'],
                        assessment: true,
                        pagesRead: data['pagesRead'],
                        buttonStatus: false,
                        comment: data['comment'],
                        note: data['note'],
                        onTapDelete: () {
                          _confirmDelete(context, docId);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

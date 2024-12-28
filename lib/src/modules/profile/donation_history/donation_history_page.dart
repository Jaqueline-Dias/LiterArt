import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/modules/feed/feed_donations/widgets/book_details_page.dart';
import 'package:app_liter_art/src/modules/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'donation_history_view_model.dart';

class DonationHistoryPage extends StatefulWidget {
  const DonationHistoryPage({
    super.key,
  });

  @override
  State<DonationHistoryPage> createState() => _DonationHistoryPageState();
}

class _DonationHistoryPageState extends State<DonationHistoryPage> {
  User? user = FirebaseAuth.instance.currentUser;
  DonationHistoryViewModel viewModel = DonationHistoryViewModel();

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
        title: const Text(LATexts.donationsHistoryAppbar),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LAButtonHistorys(
                icon: LAImages.iconDonation,
                title: LATexts.donationsHistoryTitle1,
                onTap: () {
                  Navigator.of(context).pushNamed('/service/search');
                },
              ),
              const SizedBox(height: 24),
              const Text(
                LATexts.donationsHistoryTitle2,
                style: LAAppTheme.authorMobileDateStyle,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('donations')
                    .where('userUid', isEqualTo: user?.uid)
                    .where('status', isEqualTo: false)
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
                  return SizedBox(
                    height: MediaQuery.of(context).size.width * 0.65,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: donations.length,
                      itemBuilder: (context, index) {
                        final donation = donations[index];
                        final data = donation.data() as Map<String, dynamic>;
                        final docId = donation.id;
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.94,
                          child: LACardHistorys(
                            docId: docId,
                            date: data['publicationDate'],
                            imageBook: data['bookCover'],
                            title: data['title'],
                            authors: data['authors'],
                            category: data['category'],
                            onTap: () => _navigateToBookDetails(data),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
                child: Text(
                  "Livros que já foram doados",
                  style: LAAppTheme.authorMobileDateStyle,
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('donations')
                    .where('userUid', isEqualTo: user?.uid)
                    .where('status', isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text("Nenhuma doação realizada encontrada."));
                  }

                  final List<DocumentSnapshot> donations = snapshot.data!.docs;

                  return SizedBox(
                    height: MediaQuery.of(context).size.width * 0.65,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: donations.length,
                      itemBuilder: (context, index) {
                        // final data =
                        // donations[index].data() as Map<String, dynamic>;
                        final donation = donations[index];
                        final data = donation.data() as Map<String, dynamic>;
                        final docId = donation.id;

                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.94,
                          child: LACardHistorys(
                            buttonStatus: false,
                            docId: docId,
                            date: data['publicationDate'],
                            imageBook: data['bookCover'],
                            title: data['title'],
                            authors: data['authors'],
                            category: data['category'],
                            onTap: () => _navigateToBookDetails(data),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToBookDetails(Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(
          title: data['title'] ?? '',
          authors: data['authors'] ?? '',
          coverImage: data['bookCover'] ?? '',
          synopsis: data['synopsis'] ?? '',
          pageNumber: data['pageNumber'] ?? 0,
          category: data['category'] ?? '',
          language: data['language'] ?? '',
          publicationDate: data['publicationDate'],
          conservation: data['conservation'] ?? '',
          photos: data['photos'] ?? [],
          userUid: data['user'] ?? '',
          nickname: data['nickname'] ?? '',
          profilePicture: data['profilePicture'] ?? '',
        ),
      ),
    );
  }
}

import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:app_liter_art/src/core/utils/utils.dart';
import 'package:app_liter_art/src/model/model_donation.dart';
import 'package:app_liter_art/src/modules/feed/feed_donations/feed_donations_view_model.dart';
import 'package:app_liter_art/src/modules/feed/feed_donations/widgets/book_details_page.dart';
import 'package:app_liter_art/src/modules/feed/feed_donations/widgets/category_books.dart';
import 'package:app_liter_art/src/modules/feed/feed_donations/widgets/category_section.dart';
import 'package:app_liter_art/src/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:signals_flutter/signals_flutter.dart';

class FeedDonationPage extends StatefulWidget {
  const FeedDonationPage({super.key});

  @override
  State<FeedDonationPage> createState() => _FeedDonationPageState();
}

class _FeedDonationPageState extends State<FeedDonationPage> {
  //final viewModel = Injector.get<FeedDonationsViewModel>();
  final FeedDonationsViewModel _viewModel = FeedDonationsViewModel();
  final LAUtils _utils = LAUtils();

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        children: [
          const TextTitle(title: 'Vamos achar sua próxima leitura!'),
          const CategorySection(),
          const CategoryBooks(),
          const TextTitle(title: 'Últimos livros doados'),
          Expanded(
            child: Watch(
              (context) {
                if (_viewModel.isLoading.value) {
                  return const Center(
                    child: SpinKitFadingCircle(
                      color: LAColors.buttonPrimary,
                      size: 50.0,
                    ),
                  );
                }

                if (_viewModel.errorMessage.value != null) {
                  return Center(
                    child: Text(
                      _viewModel.errorMessage.value!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                final donationDataList = _viewModel.donations.value;
                return ListView.builder(
                  itemCount: donationDataList.length,
                  itemBuilder: (context, index) {
                    final docs =
                        donationDataList[index]['post'] as ModelDonation;
                    final userData =
                        donationDataList[index]['user'] as Map<String, dynamic>;
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      color: Colors.white,
                      elevation: 0.3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          userData['profilePicture']),
                                      radius: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(userData['nickname']),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        _utils.formatDate(
                                          docs.publicationDate,
                                        ),
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Image.network(
                                      docs.bookCover!,
                                      fit: BoxFit.fitWidth,
                                      height: 180,
                                      width: 125,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: SizedBox(
                                        width: sizeOf.width * .46,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              docs.title ?? '',
                                              style:
                                                  const TextStyle(fontSize: 16),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                            Text(
                                              docs.authors ?? '',
                                              style:
                                                  const TextStyle(fontSize: 14),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                            const SizedBox(height: 8),
                                            Chip(
                                              label: Text(
                                                docs.category ?? '',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: LAColors.primary,
                                                ),
                                              ),
                                              backgroundColor: LAColors.accent,
                                              side: const BorderSide(
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(height: 8),
                                            Chip(
                                              label: Text(
                                                'Pág. ${docs.pageNumber ?? ''}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: LAColors.primary,
                                                ),
                                              ),
                                              backgroundColor: LAColors.accent,
                                              side: const BorderSide(
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(height: 24),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookDetailPage(
                                      title: docs.title ?? '',
                                      authors: docs.authors ?? '',
                                      coverImage: docs.bookCover!,
                                      synopsis: docs.synopsis ?? '',
                                      pageNumber: docs.pageNumber ?? 0,
                                      category: docs.category ?? '',
                                      language: docs.language ?? '',
                                      publicationDate: docs.publicationDate!,
                                      conservation: docs.conservation ?? '',
                                      photos: docs.photos ?? '',
                                      userUid: docs.userUid ?? '',
                                      nickname: userData['nickname'],
                                      profilePicture:
                                          userData['profilePicture'],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                decoration: const BoxDecoration(
                                  color: LAColors.buttonPrimary,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(16),
                                    topLeft: Radius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  'Ver mais detalhes',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/service/search');
        },
        backgroundColor: LAColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation:
          EndFloatWithMargin(marginRight: 20, marginBottom: 20),
    );
  }
}

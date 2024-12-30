import 'package:app_liter_art/src/common/widgets/widgets.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/model/models.dart';
import 'package:app_liter_art/src/modules/feed/feed_donations/feed_donations_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:signals_flutter/signals_flutter.dart';

class OthersCategoryPage extends StatelessWidget {
  const OthersCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FeedDonationsViewModel viewModel = FeedDonationsViewModel();

    return Scaffold(
      appBar: AppBar(
        leading: const LAIconButtonAppBar(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // -- conteúdo
          Watch(
            (context) {
              return LACategoryHeader(
                value: viewModel.getDonationCountByCategory(LATexts.others),
                titleCategory: LATexts.titleOtherCategories,
              );
            },
          ),
          // -- Feed
          Expanded(
            child: Watch(
              (context) {
                if (viewModel.isLoading.value) {
                  return const Center(
                    child: SpinKitFadingCircle(
                      color: LAColors.buttonPrimary,
                      size: 50.0,
                    ),
                  );
                }
                if (viewModel.errorMessage.value != null) {
                  return Center(
                    child: Text(
                      viewModel.errorMessage.value!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                final donationDataList = viewModel.donations.value;
                return ListView.builder(
                  itemCount: donationDataList
                      .where(
                        (donation) =>
                            (donation['post'] as ModelDonation).category ==
                            LATexts.others,
                      )
                      .length,
                  itemBuilder: (context, index) {
                    final filteredList = donationDataList
                        .where((donation) =>
                            (donation['post'] as ModelDonation).category ==
                            LATexts.others)
                        .toList();

                    final docs = filteredList[index]['post'] as ModelDonation;
                    final userData =
                        filteredList[index]['user'] as Map<String, dynamic>;

                    return LACardFeed(
                      profilePicture: userData['profilePicture'],
                      nickname: userData['nickname'],
                      date: docs.publicationDate,
                      bookCover: docs.bookCover!,
                      titleBook: docs.title,
                      authors: docs.authors,
                      category: docs.category,
                      pageNumber: docs.pageNumber,
                      synopsis: docs.synopsis,
                      language: docs.language,
                      conservation: docs.conservation,
                      photos: docs.photos,
                      userUid: docs.userUid,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

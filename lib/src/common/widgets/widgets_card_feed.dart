import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/core/utils/utils.dart';
import 'package:app_liter_art/src/modules/feed/feed_donations/widgets/book_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LACardFeed extends StatelessWidget {
  const LACardFeed(
      {super.key,
      this.profilePicture,
      this.nickname,
      this.date,
      this.bookCover,
      this.titleBook,
      this.authors,
      this.category,
      this.pageNumber,
      this.synopsis,
      this.language,
      this.conservation,
      this.userUid,
      this.photos});

  final String? profilePicture;
  final String? nickname;
  final Timestamp? date;
  final String? bookCover;
  final String? titleBook;
  final String? authors;
  final String? category;
  final int? pageNumber;
  final String? synopsis;
  final String? language;
  final String? conservation;
  final String? userUid;
  final dynamic photos;

  @override
  Widget build(BuildContext context) {
    final LAUtils utils = LAUtils();
    final double sizeOf = MediaQuery.of(context).size.width;
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: LASizes.md,
        vertical: LASizes.xs,
      ),
      color: LAColors.white,
      elevation: 0.3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LASizes.borderRadiusLg),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(LASizes.md),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(profilePicture ?? LAImages.darkAppLogo),
                      radius: LASizes.md,
                    ),
                    const SizedBox(width: LASizes.sm),
                    Text(nickname ?? LATexts.onBoardingTitle2),
                    const Spacer(),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          utils.formatDate(
                            date,
                          ),
                          style: const TextStyle(fontSize: 11),
                        )),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Image.network(
                      bookCover ?? '',
                      fit: BoxFit.fitWidth,
                      height: 180,
                      width: 125,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: SizedBox(
                        width: sizeOf * .46,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              titleBook ?? LATexts.onBoardingTitle2,
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Text(
                              authors ?? LATexts.onBoardingTitle2,
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 8),
                            Chip(
                              label: Text(
                                category ?? LATexts.onBoardingTitle2,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: LAColors.primary,
                                ),
                              ),
                              backgroundColor: LAColors.accent,
                              side: const BorderSide(color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            Chip(
                              label: Text(
                                '${LATexts.pag} ${pageNumber ?? LATexts.onBoardingTitle2}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: LAColors.primary,
                                ),
                              ),
                              backgroundColor: LAColors.accent,
                              side: const BorderSide(color: Colors.white),
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
                      title: titleBook ?? '',
                      authors: authors ?? '',
                      coverImage: bookCover!,
                      synopsis: synopsis ?? '',
                      pageNumber: pageNumber ?? 0,
                      category: category ?? '',
                      language: language ?? '',
                      publicationDate: date!,
                      conservation: conservation ?? '',
                      photos: photos ?? '',
                      userUid: userUid ?? '',
                      nickname: nickname ?? '',
                      profilePicture: profilePicture ?? '',
                    ),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: const BoxDecoration(
                  color: LAColors.buttonPrimary,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                  ),
                ),
                child: const Text(
                  LATexts.details,
                  style: TextStyle(
                    color: LAColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils.dart';
import 'package:app_liter_art/src/model/models.dart';
import 'package:app_liter_art/src/modules/feed/feed_assessments/feed_assessment_view_model.dart';
import 'package:app_liter_art/src/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:signals_flutter/signals_flutter.dart';

class FeedAssessmentPage extends StatefulWidget {
  const FeedAssessmentPage({super.key});

  @override
  State<FeedAssessmentPage> createState() => _FeedAssessmentPageState();
}

class _FeedAssessmentPageState extends State<FeedAssessmentPage> {
  //final viewModel = Injector.get<FeedDonationsViewModel>();
  final FeedAssessmentViewModel _viewModel = FeedAssessmentViewModel();
  final Utils _utils = Utils();

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        children: [
          const TextTitle(title: 'Últimas obras avaliadas'),
          Expanded(
            child: Watch(
              (context) {
                if (_viewModel.isLoading.value) {
                  return const Center(
                    child: SpinKitFadingCircle(
                      color: AppLiterArtTheme.violetButton,
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

                final assessmentDataList = _viewModel.assessments.value;
                return ListView.builder(
                  itemCount: assessmentDataList.length,
                  itemBuilder: (context, index) {
                    final docs =
                        assessmentDataList[index]['post'] as ModelAssessment;
                    final userData = assessmentDataList[index]['user']
                        as Map<String, dynamic>;
                    int totalPages =
                        int.tryParse(docs.pageNumber.toString()) ?? 1;
                    int paginasLidas =
                        int.tryParse(docs.pagesRead.toString()) ?? 0;
                    double progress = paginasLidas / totalPages;
                    double rating = docs.note ?? 0.0;

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      color: Colors.white,
                      elevation: 0.3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(userData['profilePicture']),
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
                                  fit: BoxFit.cover,
                                  height: 180,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: SizedBox(
                                    width: sizeOf.width * .43,
                                    child: Expanded(
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
                                                const TextStyle(fontSize: 16),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 8),
                                          Chip(
                                            label: Text(
                                              docs.category ?? '',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: AppLiterArtTheme.violet,
                                              ),
                                            ),
                                            backgroundColor:
                                                AppLiterArtTheme.violetLigth2,
                                            side: const BorderSide(
                                                color: Colors.white),
                                          ),
                                          const SizedBox(height: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Páginas lidas'),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        sizeOf.height * 0.02,
                                                    width: sizeOf.width * 0.3,
                                                    child:
                                                        LinearProgressIndicator(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      value: progress,
                                                      backgroundColor:
                                                          Colors.grey[300],
                                                      color: AppLiterArtTheme
                                                          .violetButton,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    '${(progress * 100).toStringAsFixed(0)}%',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: AppLiterArtTheme
                                                          .violet,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                docs.comment!,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            Row(
                              children: [
                                Text('${docs.note}'),
                                const SizedBox(width: 8),
                                Row(
                                  children: List.generate(5, (starIndex) {
                                    return Icon(
                                      starIndex < rating
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: AppLiterArtTheme.violetButton,
                                      size: 20,
                                    );
                                  }),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
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
        backgroundColor: AppLiterArtTheme.violet,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation:
          EndFloatWithMargin(marginRight: 20, marginBottom: 20),
    );
  }
}

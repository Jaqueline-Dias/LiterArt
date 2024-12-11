import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:app_liter_art/src/core/utils/utils.dart';
import 'package:app_liter_art/src/model/models.dart';
import 'package:app_liter_art/src/modules/feed/feed_requests/feed_request_view_model.dart';
import 'package:app_liter_art/src/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:signals_flutter/signals_flutter.dart';

class FeedRequestPage extends StatefulWidget {
  const FeedRequestPage({super.key});

  @override
  State<FeedRequestPage> createState() => _FeedRequestPageState();
}

class _FeedRequestPageState extends State<FeedRequestPage> {
  //final viewModel = Injector.get<FeedDonationsViewModel>();
  final FeedRequestViewModel _viewModel = FeedRequestViewModel();
  final LAUtils _utils = LAUtils();

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        children: [
          const TextTitle(title: 'Últimos livros solicitados'),
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

                final requestDataList = _viewModel.requests.value;
                return ListView.builder(
                  itemCount: requestDataList.length,
                  itemBuilder: (context, index) {
                    final docs = requestDataList[index]['post'] as ModelRequest;
                    final userData =
                        requestDataList[index]['user'] as Map<String, dynamic>;
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
                                    width: sizeOf.width * .44,
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
                                ),
                              ],
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                docs.description ?? '',
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton.icon(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'assets/images/message-chat-circle.svg',
                                  height: 24,
                                ),
                                label: const Text('Enviar mensagem'),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                            ),
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
        backgroundColor: LAColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation:
          EndFloatWithMargin(marginRight: 20, marginBottom: 20),
    );
  }
}

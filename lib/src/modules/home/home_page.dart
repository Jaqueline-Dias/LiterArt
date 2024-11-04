import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/modules/feed/feed_assessments/feed_assessment_page.dart';
import 'package:app_liter_art/src/modules/feed/feed_donations/feed_donation_page.dart';
import 'package:app_liter_art/src/modules/feed/feed_messages/feed_message_page.dart';
import 'package:app_liter_art/src/modules/feed/feed_requests/feed_request_page.dart';
import 'package:app_liter_art/src/modules/home/widgets/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> tabs = [
    "Doações",
    "Pedidos",
    "Avaliações",
    "Chat",
  ];

  int current = 0;

  double _chengePosiotionedOfLine() {
    switch (current) {
      case 0:
        return 0;
      case 1:
        return 78;
      case 2:
        return 172;
      case 3:
        return 263;
      default:
        return 0;
    }
  }

  double _chengeConatinerWidth() {
    switch (current) {
      case 0:
        return 80;
      case 1:
        return 80;
      case 2:
        return 80;
      case 3:
        return 50;
      default:
        return 0;
    }
  }

  Widget _buildPageContent() {
    switch (current) {
      case 0:
        return const FeedDonationPage();
      case 1:
        return const FeedRequestPage();
      case 2:
        return const FeedAssessmentPage();
      case 3:
        return const FeedMessagePage();
      default:
        return const FeedDonationPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('LiterArt'),
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/images/trophy-02.svg',
          ),
          onPressed: () {
            // Ação a ser realizada ao pressionar o ícone
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: sizeOf.width,
            height: sizeOf.height * 0.05,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    width: sizeOf.width,
                    height: sizeOf.height * 0.04,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: tabs.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                current = index;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: index == 0 ? 10 : 24,
                                top: 7,
                              ),
                              child: Text(
                                tabs[index],
                                style: TextStyle(
                                  color: current == index
                                      ? AppLiterArtTheme.violetDark
                                      : AppLiterArtTheme.grey,
                                  fontSize: current == index ? 16 : 14,
                                  fontWeight: current == index
                                      ? FontWeight.w400
                                      : FontWeight.w300,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                AnimatedPositioned(
                  bottom: 0,
                  left: _chengePosiotionedOfLine(),
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(milliseconds: 500),
                  child: AnimatedContainer(
                    curve: Curves.fastLinearToSlowEaseIn,
                    margin: const EdgeInsets.only(left: 10),
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    width: _chengeConatinerWidth(),
                    height: sizeOf.height * 0.008,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppLiterArtTheme.violetDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildPageContent(),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppLiterArtTheme.violet,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('/service/search');
        },
        label: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

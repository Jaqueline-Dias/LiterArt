import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:app_liter_art/src/modules/assessments/assessment_feed_page.dart';
import 'package:app_liter_art/src/modules/donations/donation_feed_page.dart';
import 'package:app_liter_art/src/modules/messages/message_feed_page.dart';
import 'package:app_liter_art/src/modules/requests/request_feed_page.dart';
import 'package:app_liter_art/src/modules/search/search.dart';
import 'package:flutter/material.dart';

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
        return const DonationFeedPage();
      case 1:
        return const RequestFeedPage();
      case 2:
        return const AssessmentFeedPage();
      case 3:
        return const MessageFeedPage();
      default:
        return const DonationFeedPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('LiterArt'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: sizeOf.width,
          height: sizeOf.height,
          child: Column(
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
        ),
      ),
      //Botão flutuante
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppLiterArtTheme.violetDark,
        extendedPadding: const EdgeInsets.all(24),
        onPressed: () async {
          //  Validações
          // Navigator.of(context).pushNamed('/report/first');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Search()),
          );
        },
        label: const Text(
          "+",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

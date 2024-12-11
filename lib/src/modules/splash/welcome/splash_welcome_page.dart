import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:app_liter_art/src/modules/splash/welcome/widgets/widget_intro1.dart';
import 'package:app_liter_art/src/modules/splash/welcome/widgets/widget_intro2.dart';
import 'package:app_liter_art/src/modules/splash/welcome/widgets/widget_intro3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashWelcomePage extends StatefulWidget {
  const SplashWelcomePage({super.key});

  @override
  State<SplashWelcomePage> createState() => _SplashWelcomePageState();
}

class _SplashWelcomePageState extends State<SplashWelcomePage> {
  final PageController _controller = PageController();
  bool onLastPage = false;
  bool onLastPages = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LAColors.accent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/auth/login');
              },
              child:
                  onLastPage == false ? const Text(LATexts.skip) : Container(),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  onLastPage = (index == 2);
                });
              },
              children: const [
                WidgetIntro1(),
                WidgetIntro2(),
                WidgetIntro3(),
              ],
            ),

            //Detalhe do indicator
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                alignment: const Alignment(0, 0.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Skip
                    const SizedBox(
                      height: 50,
                      width: 50,
                    ),

                    //Indicador
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: const WormEffect(
                        paintStyle: PaintingStyle.stroke,
                        strokeWidth: 1.5,
                        dotColor: LAColors.buttonPrimary,
                        activeDotColor: LAColors.buttonPrimary,
                      ),
                    ),

                    //next
                    onLastPage
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/auth/login');
                            },
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: LAColors.buttonPrimary,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 32),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                              );
                            },
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: LAColors.buttonPrimary,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 32),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

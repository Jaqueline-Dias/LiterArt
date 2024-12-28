import 'package:app_liter_art/src/common/widgets/widget_icon_button_app_bar.dart';
import 'package:app_liter_art/src/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LAPageIndicator extends StatefulWidget {
  const LAPageIndicator({
    super.key,
    required this.children,
  });
  @override
  State<LAPageIndicator> createState() => _LAPageIndicatorState();

  final List<Widget> children;
}

class _LAPageIndicatorState extends State<LAPageIndicator> {
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
        leading: const LAIconButtonAppBar(),
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
              children: widget.children,
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
                                  .pushNamed('/service/search');
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

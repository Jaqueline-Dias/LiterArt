import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:app_liter_art/src/modules/home/home_view_model.dart';
import 'package:app_liter_art/src/modules/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:signals_flutter/signals_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final viewModel = Injector.get<HomeViewModel>();
  HomeViewModel viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.of(context).size;
    return Scaffold(
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('LiterArt'),
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/trophy-02.svg'),
          onPressed: () {
            // Ação do botão
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
                _buildTabBar(context, viewModel),
                _buildAnimatedLine(viewModel, sizeOf),
              ],
            ),
          ),
          Expanded(
            child: Watch(
              (context) => viewModel.getPageContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context, HomeViewModel viewModel) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: viewModel.tabs.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                viewModel.setCurrentTab(index);
              },
              child: Padding(
                padding: EdgeInsets.only(left: index == 0 ? 10 : 24, top: 7),
                child: Watch(
                  (context) {
                    final currentTab = viewModel.currentTab.value;
                    return Text(
                      viewModel.tabs[index],
                      style: TextStyle(
                        color: currentTab == index
                            ? LAColors.violetDark
                            : LAColors.textPrimary,
                        fontSize: currentTab == index ? 16 : 14,
                        fontWeight: currentTab == index
                            ? FontWeight.w400
                            : FontWeight.w300,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAnimatedLine(HomeViewModel viewModel, Size sizeOf) {
    return Watch(
      (context) {
        viewModel.currentTab.value;
        return AnimatedPositioned(
          bottom: 0,
          left: viewModel.getLinePosition(),
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(milliseconds: 500),
          child: AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            margin: const EdgeInsets.only(left: 10),
            duration: const Duration(milliseconds: 500),
            width: viewModel.getContainerWidth(),
            height: sizeOf.height * 0.008,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: LAColors.violetDark,
            ),
          ),
        );
      },
    );
  }
}

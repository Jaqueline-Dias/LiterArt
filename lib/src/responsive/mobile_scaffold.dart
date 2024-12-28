import 'package:animate_do/animate_do.dart';
import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:app_liter_art/src/model/models.dart';
import 'package:app_liter_art/src/modules/widgets/book_detail_widget.dart';
import 'package:app_liter_art/src/modules/widgets/book_image_widget.dart';
import 'package:flutter/material.dart';

class MobileScaffold extends StatelessWidget {
  final List<Item> bookItems;

  const MobileScaffold({super.key, required this.bookItems});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      height: deviceHeight - 330,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
      child: FadeInLeft(
        child: ListView.builder(
          padding: const EdgeInsets.all(0.0),
          itemCount: bookItems.length,
          itemBuilder: ((context, index) {
            return Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: BookImageWidget(
                    book: bookItems[index],
                  ),
                ),
                Positioned(
                  top: 50.0,
                  left: 9.0,
                  bottom: 50.0,
                  child: SizedBox(
                    width: deviceWidth * 0.60,
                    child: Card(
                      color: LAColors.accent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: BookDetailWidget(
                          book: bookItems[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

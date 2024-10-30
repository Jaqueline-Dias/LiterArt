import 'dart:convert';

import 'package:app_liter_art/src/core/utils.dart';
import 'package:app_liter_art/src/model/itens.dart';
import 'package:app_liter_art/src/modules/liter_art_service/search/widgets/responsive_layout.dart';
import 'package:app_liter_art/src/responsive/mobile_scaffold.dart';
import 'package:app_liter_art/src/widgets/empty_results_widget.dart';
import 'package:flutter/material.dart';

class FavoritesBooksWidget extends StatefulWidget {
  const FavoritesBooksWidget({super.key});

  @override
  State<FavoritesBooksWidget> createState() => FavoritesBooksWidgetState();
}

class FavoritesBooksWidgetState extends State<FavoritesBooksWidget> {
  static ValueNotifier<List<Item>> favoritesBooks = ValueNotifier([]);

  void getFavoritesBooks() async {
    List<String> savedBooks = await Utils.getFavoritesBooks();
    setState(() => favoritesBooks.value =
        savedBooks.map((map) => Item.fromApiItems(jsonDecode(map))).toList());
  }

  @override
  void initState() {
    getFavoritesBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double customPadding = MediaQuery.of(context).size.width * 0.03;
    return ValueListenableBuilder(
      valueListenable: favoritesBooks,
      builder: (BuildContext context, List<Item> favBooks, Widget? child) {
        if (favBooks.isEmpty) {
          return Padding(
            padding: EdgeInsets.only(left: customPadding, right: customPadding),
            child: const EmptyResultsWidget(
              message: 'teste',
            ),
          );
        } else {
          return ResponsiveLayout(
            mobileScaffold: MobileScaffold(bookItems: favBooks),
          );
        }
      },
    );
  }
}

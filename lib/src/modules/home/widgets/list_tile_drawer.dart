import 'package:app_liter_art/src/core/theme/app_liter_art_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListTileDrawer extends StatefulWidget {
  const ListTileDrawer({
    super.key,
    required this.onTap,
    required this.title,
    required this.image,
  });

  final VoidCallback onTap;
  final String title;
  final String image;

  @override
  State<ListTileDrawer> createState() => _ListTileDrawerState();
}

class _ListTileDrawerState extends State<ListTileDrawer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, bottom: 16),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppLiterArtTheme.violetLigth2,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SvgPicture.asset(
            widget.image,
          ),
        ),
        title: Text(
          widget.title,
          style: AppLiterArtTheme.titleDescription,
        ),
        onTap: widget.onTap,
      ),
    );
  }
}

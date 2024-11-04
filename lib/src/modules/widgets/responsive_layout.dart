import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScaffold;

  const ResponsiveLayout({
    super.key,
    required this.mobileScaffold,
  });

  @override
  Widget build(BuildContext context) {
    return mobileScaffold;
  }
}

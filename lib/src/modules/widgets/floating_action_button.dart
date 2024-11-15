import 'package:flutter/material.dart';

class EndFloatWithMargin extends FloatingActionButtonLocation {
  final double marginRight;
  final double marginBottom;

  EndFloatWithMargin({this.marginRight = 16.0, this.marginBottom = 16.0});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    // Calcula a posição do FAB
    double x = scaffoldGeometry.scaffoldSize.width -
        scaffoldGeometry.floatingActionButtonSize.width -
        marginRight;
    double y = scaffoldGeometry.scaffoldSize.height -
        scaffoldGeometry.floatingActionButtonSize.height -
        marginBottom;
    return Offset(x, y);
  }
}

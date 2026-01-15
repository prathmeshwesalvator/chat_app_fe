import 'package:flutter/material.dart';

class CenterDockedWithOffset extends FloatingActionButtonLocation {
  final double offsetY;

  const CenterDockedWithOffset(this.offsetY);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry geometry) {
    final double fabX =
        (geometry.scaffoldSize.width -
            geometry.floatingActionButtonSize.width) /
        2;

    final double fabY =
        geometry.contentBottom -
        geometry.floatingActionButtonSize.height / 2 -
        offsetY;

    return Offset(fabX, fabY);
  }
}

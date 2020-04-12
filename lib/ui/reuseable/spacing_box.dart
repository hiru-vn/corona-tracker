import 'package:corona_tracker/ui/reuseable/responsive_size.dart';
import 'package:flutter/material.dart';

class SpacingBox extends StatelessWidget {
  final double height;
  final double width;

  const SpacingBox({this.height = 0, this.width = 0});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * ResponsiveSize.heightMultiplier,
      width: width * ResponsiveSize.widthMultiplier,
    );
  }
}
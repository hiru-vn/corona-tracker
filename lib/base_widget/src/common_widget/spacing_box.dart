import 'package:flutter/material.dart';
import 'package:corona_tracker/base_config/base_config.dart';

class SpacingBox extends StatelessWidget {
  final double height;
  final double width;

  SpacingBox({this.height = 0, this.width = 0});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * SizeConfig.heightMultiplier,
      width: width * SizeConfig.widthMultiplier,
    );
  }
}

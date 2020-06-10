import 'package:flutter/material.dart';
import 'package:corona_tracker/base_config/base_config.dart';

class EmptyDataWidget extends StatelessWidget {
  final title;
  EmptyDataWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: SizeConfig.heightMultiplier * 15,
          ),
          Image.asset(
            'assets/data_empty.png',
            height: SizeConfig.heightMultiplier * 15,
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier * 1.5,
          ),
          Opacity(
            child: Text(
              title,
              style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2.2,
                color: Colors.black54,
              ),
            ),
            opacity: .5,
          ),
        ],
      ),
    );
  }
}

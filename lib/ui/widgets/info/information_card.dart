import 'package:flutter/material.dart';

class InformationCard extends StatelessWidget {
  final String title;
  final String detail;
  final Color color;

  const InformationCard({Key key, this.title, this.detail, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    Column(
      children: <Widget>[
        Text(title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(detail,
        style: TextStyle(
          color: color,

          fontWeight: FontWeight.normal
        ),)
      ],
    );
  }
}

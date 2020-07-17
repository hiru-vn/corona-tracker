import 'package:flutter/material.dart';

class InformationCard extends StatelessWidget {
  final String title;
  final String detail;
  final Color color;

  const InformationCard({Key key, this.title, this.detail, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        FittedBox(
          fit: BoxFit.cover,
          child: Text(
            detail,
            style: TextStyle(color: color, fontWeight: FontWeight.normal),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
      ],
    );
  }
}

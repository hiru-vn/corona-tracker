import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final String content;
  final String dateTime;
  final String address;
  final String nameDiner;

  const DetailCard({Key key, this.content, this.dateTime, this.address, this.nameDiner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween ,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(content,style: TextStyle(
                  color: Colors.red,

                ),),
                Text(dateTime)
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(nameDiner),
                Text(address),
              ],
            ),

          ],
        ),
        Align(alignment: Alignment.topRight,child: Text("  Chi tiết >>",style: TextStyle(
            color: Color(0xff28E2E2)
        ),))
      ],
    );
  }
}

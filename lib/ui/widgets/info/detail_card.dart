import 'package:corona_tracker/ui/reuseable/spacing_box.dart';
import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final String content;
  final String dateTime;
  final String address;
  final String nameDiner;

  const DetailCard(
      {Key key, this.content, this.dateTime, this.address, this.nameDiner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      content,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    SpacingBox(
                      height: 1,
                    ),
                    Text(dateTime)
                  ],
                ),
              ),
              SpacingBox(
                width: 1,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(nameDiner),
                    Text(address),
                  ],
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.topRight,
              child: Text(
                "  Chi tiết >>",
                style: TextStyle(color: Color(0xff28E2E2)),
              ))
        ],
      ),
    );
  }
}

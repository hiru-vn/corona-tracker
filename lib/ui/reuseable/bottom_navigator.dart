import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar(this._key, this._onTap);

  final Key _key;
  final Function _onTap;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: _key,
      height: 50,
      items: <Widget>[
        Icon(
          Icons.public,
          size: 30,
          color: Colors.black54,
        ),
        Icon(
          Icons.new_releases,
          size: 30,
          color: Colors.black54,
        ),
        Icon(
          Icons.map,
          size: 30,
          color: Colors.black54,
        ),
      ],
      color: Colors.white,
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.blueAccent,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      onTap: _onTap,
    );
  }
}

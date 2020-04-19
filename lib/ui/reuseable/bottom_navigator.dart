import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar(this._key, this._onTap, {this.color});

  final Key _key;
  final Function _onTap;
  final Color color;

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  List<Color> _color;
  @override
  void initState() {
    _color = [widget.color, null, null];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: widget._key,
      height: 50,
      items: <Widget>[
        Icon(
          Icons.public,
          size: 30,
          color: _color[0]?? Colors.black54,
        ),
        Icon(
          Icons.new_releases,
          size: 30,
          color: _color[1]?? Colors.black54,
        ),
        Icon(
          Icons.map,
          size: 30,
          color: _color[2]?? Colors.black54,
        ),
      ],
      color: Colors.white,
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.blueAccent,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      onTap: (index) {
        widget._onTap(index);
        setState(() {
          _color[0] = null;
          _color[1] = null;
          _color[2] = null;
          _color[index] = widget.color;
        });
      },
    );
  }
}

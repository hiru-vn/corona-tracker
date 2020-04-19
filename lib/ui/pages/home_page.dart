import 'package:corona_tracker/ui/pages/dashboard_page.dart';
import 'package:corona_tracker/ui/pages/info_page.dart';
import 'package:corona_tracker/ui/pages/map_page.dart';
import 'package:corona_tracker/ui/reuseable/bottom_navigator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bottomNavigationKey = GlobalKey();
  final _pageController = PageController(initialPage: 0);

  void _changePageByPress(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          DashboardPage(),
          InfoPage(),
          MapPage(),
        ],
      ),
      bottomNavigationBar:
          MyBottomNavigationBar(_bottomNavigationKey, _changePageByPress, color: Colors.blueAccent,),
    );
  }
}

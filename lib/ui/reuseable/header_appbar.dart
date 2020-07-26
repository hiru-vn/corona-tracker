import 'package:corona_tracker/base_config/src/spref/spref.dart';
import 'package:corona_tracker/base_config/src/utils/constants.dart';
import 'package:corona_tracker/ui/pages/login_page.dart';
import 'package:corona_tracker/ui/reuseable/spacing_box.dart';
import 'package:corona_tracker/ui/ui_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHeader extends StatefulWidget {
  final String image;
  final String textTop;
  final String textBottom;
  final double offset;
  final Function reload;
  const MyHeader(
      {Key key, this.image, this.textTop, this.textBottom, this.offset, this.reload})
      : super(key: key);

  @override
  _MyHeaderState createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: const EdgeInsets.only(left: 40, top: 50, right: 20),
        height: deviceHeight(context)/2,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              const Color(0xFF3383CD),
              const Color(0xFF11249F),
            ],
          ),
          image: const DecorationImage(
            image: AssetImage("assets/images/virus.png"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (widget.reload != null) {
                      widget.reload();
                    }
                  },
                  child: Icon(Icons.replay, color: Colors.white,),
                ),
                SpacingBox(width: 3),
                GestureDetector(
                  onTap: () {
                    SPref.instance.remove('loggedid').then((value) => Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginPage();
                          })),
                    );
                  },
                  child: Icon(Icons.power_settings_new, color: Colors.white,),
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: (widget.offset < 0) ? 0 : widget.offset,
                    child: SvgPicture.asset(
                      widget.image,
                      width: 230,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Positioned(
                    top: 20 - widget.offset / 2,
                    left: 150,
                    child: Text(
                      "${widget.textTop} \n${widget.textBottom}",
                      style: kHeadingTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(), // I dont know why it can't work without container
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

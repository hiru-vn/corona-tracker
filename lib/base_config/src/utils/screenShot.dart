import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'dart:ui' as ui;
import 'dart:typed_data';

GlobalKey keyEdit = GlobalKey();

class ScreenShot {
  static List<ui.Image> listImage = List<ui.Image>();
  static List<Uint8List> listUint8List = List<Uint8List>();

  static Future<Uint8List> uiImageToUint8List(ui.Image image) async {
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8list = byteData.buffer.asUint8List();
    return uint8list;
  }

  static void removeScreenShot(int index) {
    if (index > listImage.length - 1) return;
    listImage.removeAt(index);
    listUint8List.removeAt(index);
  }

  static Future screenShot(BuildContext context, GlobalKey appKey) async {
    RenderRepaintBoundary renderRepaintBoundary =
        appKey.currentContext.findRenderObject();
    ui.Image boxImage = await renderRepaintBoundary.toImage(pixelRatio: 1);

    listImage.add(boxImage);
    Uint8List u8 = await uiImageToUint8List(boxImage);
    listUint8List.add(u8);
    print(listImage.length);
  }

  static Future screenShotAndReplaceAt(BuildContext context, int index) async {
    RenderRepaintBoundary renderRepaintBoundary =
        keyEdit.currentContext.findRenderObject();
    ui.Image boxImage = await renderRepaintBoundary.toImage(pixelRatio: 1);

    listImage[index] = boxImage;
    Uint8List u8 = await uiImageToUint8List(boxImage);
    listUint8List[index] = u8;
    print(listImage.length);
  }

  static void clearAllImage() {
    listImage.clear();
    listUint8List.clear();
  }

  static Future drawOnImage(BuildContext context, int index,
      {Function onSave}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => KeyPaintProvider(
              image: listImage[index],
              onSave: onSave,
              index: index,
            ));
  }
}

class KeyPaintProvider extends StatelessWidget {
  final ui.Image image;
  final Function onSave;
  final int index;
  final GlobalKey<NavigatorState> navigatorKey;
  KeyPaintProvider({Key key, this.image, this.index, this.onSave, this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RepaintBoundary(
        key: keyEdit,
        child: ImageBoxContainer(
          image: image,
          onSave: onSave,
          index: index,
          navigatorKey: navigatorKey,
        ),
      ),
    );
  }
}

class ImageBoxContainer extends StatefulWidget {
  final ui.Image image;
  final Function onSave;
  final int index;
  final GlobalKey<NavigatorState> navigatorKey;

  ImageBoxContainer({Key key, this.image, this.index, this.onSave, @required this.navigatorKey})
      : super(key: key);
  @override
  _ImageBoxContainerState createState() => _ImageBoxContainerState();
}

class _ImageBoxContainerState extends State<ImageBoxContainer> {
  List<Offset> _points = <Offset>[];
  bool enableButton=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: GestureDetector(
            onPanUpdate: (DragUpdateDetails details) {
              setState(() {
                RenderBox object = context.findRenderObject();
                Offset _localPosition =
                    object.globalToLocal(details.globalPosition);
                _points = List.from(_points)..add(_localPosition);
              });
            },
            onPanEnd: (DragEndDetails details) => _points.add(null),
            child: CustomPaint(
              painter: Signature(points: _points, image: widget.image),
              size: Size.infinite,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: enableButton
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FloatingActionButton(
                      backgroundColor: Colors.grey,
                      onPressed: () {
                        widget.navigatorKey.currentState.pop();
                      },
                      child: Icon(Icons.close),
                    ),
                    Row(
                      children: <Widget>[
                        FloatingActionButton(
                          backgroundColor: Color(0xFFFF6724),
                          child: Icon(Icons.replay),
                          onPressed: () {
                            setState(() {
                              _points.clear();
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FloatingActionButton(
                          backgroundColor: Color(0xFF18B0F1),
                          child: Icon(Icons.done),
                          onPressed: () {
                            setState(() {
                              enableButton = false;
                            });
                            if (widget.onSave != null) widget.onSave();
                            Future.delayed(Duration(milliseconds: 100), () {
                              ScreenShot.screenShotAndReplaceAt(
                                  widget.navigatorKey.currentContext, widget.index);
                              widget.navigatorKey.currentState.pop();
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Container());
  }
}

class Signature extends CustomPainter {
  List<Offset> points;
  ui.Image image;
  Signature({this.points, this.image});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    canvas.drawImage(image, Offset.zero, paint);

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
}

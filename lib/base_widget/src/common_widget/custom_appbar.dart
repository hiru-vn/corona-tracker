import 'package:flutter/material.dart';
import 'package:corona_tracker/base_config/base_config.dart';

class CustomAppBar extends StatelessWidget {
  final bool canGoNotify;
  final bool canGoBack;
  final int numNoti;
  final Function searchAction;
  final Function(String) onSubmited;
  final FocusNode node;
  final TextInputAction inputAction;
  final String title;
  final GlobalKey<NavigatorState> navigatorKey;
  CustomAppBar(
      {this.node,
      this.numNoti,
      this.title,
      this.searchAction,
      this.canGoNotify = true,
      this.canGoBack = false,
      this.inputAction,
      this.onSubmited,
      @required this.navigatorKey,
      });
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double appbarheight = AppBar().preferredSize.height;
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      width: MediaQuery.of(context).size.width,
      height: appbarheight + statusBarHeight,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            canGoBack
                ? SizedBox(
                    width: SizeConfig.widthMultiplier * 10,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RawMaterialButton(
                        onPressed: () {
                          node?.unfocus();
                          navigatorKey.currentState.pop();
                        },
                        fillColor: Color.fromARGB(255, 245, 245, 245),
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          size: 28,
                          color: Colors.grey,
                        ),
                        shape: CircleBorder(),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            SizedBox(
              width: 10,
            ),
            title != null
                ? Text(title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
                : SizedBox.shrink(),
            searchAction != null
                ? Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 245, 245, 245),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        focusNode: node,
                        onSubmitted: onSubmited,
                        textInputAction: inputAction,
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2.5),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(bottom: 12),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            canGoNotify
                ? SizedBox(
                    width: SizeConfig.widthMultiplier * 10,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () =>
                            navigatorKey.currentState.pushNamed('/notify'),
                        child: Stack(
                          children: <Widget>[
                            Icon(
                              Icons.notifications,
                              color: Colors.grey,
                              size: 28,
                            ),
                            numNoti != null && numNoti > 0
                                ? Positioned(
                                    height: 15,
                                    width: numNoti < 100 ? 20 : 25,
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(800),
                                        child: Container(
                                          width: numNoti < 100 ? 20 : 25,
                                          height: 15,
                                          color: Colors.redAccent,
                                          child: Center(
                                            child: Text(
                                              numNoti < 100
                                                  ? numNoti.toString()
                                                  : '99+',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  fontSize: 11),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

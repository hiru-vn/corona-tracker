
import 'package:flutter/material.dart';

enum DialogAction {
  cancel,
  discard,
  disagree,
  agree,
}

typedef TapButtonListener(DialogAction action);
typedef TapConfirm();

void showWaitingDialog(BuildContext context, {String message}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            content: Container(
              width: double.infinity,
              height: 100.0,
              alignment: Alignment.center,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
                  Padding(
                      padding: EdgeInsets.only(top: 18.0),
                      child: Text(
                        message ?? 'Đang xử lí ...',
                        style: TextStyle(fontSize: 18.0),
                      ))
                ],
              )),
            ));
      });
}

Future<bool> showAlertDialog(BuildContext context, String errorMessage,
    {TapConfirm confirmTap, String confirmLabel, @required GlobalKey<NavigatorState> navigatorKey}) async {
  Color primaryColor = Theme.of(context).primaryColor;
  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          content: Text(errorMessage, style: TextStyle(fontSize: 18.0)),
          actions: <Widget>[
            FlatButton(
                child: Text(confirmLabel != null ? confirmLabel : 'Ok', style: TextStyle(color: primaryColor)),
                onPressed: confirmTap != null ? confirmTap : () => navigatorKey.currentState.pop(true)),
          ],
        );
      });
}

void showConfirmDialog(BuildContext context, String errorMessage, {TapConfirm confirmTap, @required GlobalKey<NavigatorState> navigatorKey}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text(errorMessage, style: TextStyle(fontSize: 18.0)),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel', style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () => navigatorKey.currentState.pop(context),
            ),
            FlatButton(
              child: Text('Ok', style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: confirmTap != null ? confirmTap : () => navigatorKey.currentState.pop(context),
            ),
          ],
        );
      });
}

Future showAlertWithTitleDialog(BuildContext context, String title, String content,
    {String firstAction,
    TapConfirm firstTap,
    String secondAction,
    TapConfirm secondTap,
    String thirdAction,
    TapConfirm thirdTap,
    @required GlobalKey<NavigatorState> navigatorKey}) {
  List<Widget> actions = new List<Widget>();
  Color primaryColor = Theme.of(context).primaryColor;

  if (thirdAction != null && thirdAction.isNotEmpty) {
    actions.add(new FlatButton(
      child: Text(thirdAction, style: TextStyle(color: primaryColor)),
      onPressed: thirdTap != null ? thirdTap : () => navigatorKey.currentState.pop(),
    ));
  }

  if (secondAction != null && secondAction.isNotEmpty) {
    actions.add(new FlatButton(
      child: Text(secondAction, style: TextStyle(color: primaryColor)),
      onPressed: secondTap != null ? secondTap : () => navigatorKey.currentState.pop(),
    ));
  }

  actions.add(new FlatButton(
    child: Text(firstAction ?? 'Ok', style: TextStyle(color: primaryColor)),
    onPressed: firstTap != null ? firstTap : () => navigatorKey.currentState.pop(),
  ));

  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content, style: TextStyle(fontSize: 18.0)),
          actions: actions,
        );
      });
}

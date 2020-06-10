import 'package:corona_tracker/base_config/base_config.dart';
import 'package:corona_tracker/services/navigate_services.dart';


class Headerqr extends StatelessWidget {
  Headerqr();
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double appbarheight = AppBar().preferredSize.height;
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      width: SizeConfig.widthMultiplier*200,
      height: appbarheight + statusBarHeight,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: SizeConfig.widthMultiplier * 10,
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => navigatorKey.currentState.pop(),
                  child: Icon(
                    Icons.close,
                    size: 30,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 3,
            ),
            Text(
              'Quét mã qr',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:corona_tracker/ui/reuseable/responsive_size.dart';
import 'package:flutter/material.dart';

class QrCodeButton extends StatelessWidget {
  final ResponsiveSize size;
  final VoidCallback onPressed;

  const QrCodeButton({Key key, this.size, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = ResponsiveSize.widthMultiplier * 20;

    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(width),
        width: width,
        height: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              offset: Offset.zero,
              color: Colors.grey.withOpacity(.5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              'assets/qrcode.png',
              fit: BoxFit.cover,
              width: width/1.5,
            ),
            Text(
              'Quét mã',
              style: TextStyle(
                fontSize: ResponsiveSize.textMultiplier * 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

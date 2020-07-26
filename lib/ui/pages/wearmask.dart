import 'package:corona_tracker/services/navigate_services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class wearmask extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
        //primarySwatch: Colors.blue,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 50,
              left: 20,
              child: InkWell(
                onTap: () => navigatorKey.currentState.pop(),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                      bottom: 10),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    image: AssetImage(
                      "assets/images/patient.png",
                    ),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.5,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Hãy đeo khẩu trang đúng cách",
                        style: GoogleFonts.raleway(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.1,
                            right: MediaQuery.of(context).size.width * 0.1),
                        child: Text(
                          "Bước 1: Làm ướt hai lòng bàn tay dưới vòi nước. Cho xà phòng vào lòng bàn tay và xoa đều.\n"
                          "Bước 2: Chà lòng bàn tay này lên mu bàn tay và kẽ ngoài các ngón tay của bàn tay kia và ngược lại.\n"
                          "Bước 3: Chà 2 lòng bàn tay vào nhau, miết mạnh các ngón tay và các kẽ ngón, móng tay trong vòng ít nhất 20 giây.\n"
                          "Bước 4: Chà mặt ngoài các ngón tay của bàn tay này vào lòng bàn tay kia.\n"
                          "Bước 5: Dùng bàn tay này xoay ngón cái của bàn tay kia và ngược lại.\n"
                          "Bước 6: Tráng sạch tay dưới vòi nước. Lau khô tay bằng khăn sạch hoặc khăn sử dụng một lần.\n",
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

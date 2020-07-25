import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05, bottom: 10),
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: AssetImage(
                  "assets/images/handwashing.jpg",
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
                    "Hãy rửa tay trang đúng cách",
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
                      "1. Kiểm tra mặt nạ xem có bất kỳ khiếm khuyết nào không, như rách hoặc thiếu dây buộc hoặc quai. Hãy loại bỏ chúng nếu có bất kỳ đó là khiếm khuyết nào \n"
                      "2. Đeo bề mặt màu xanh ra phía bên ngoài \n"
                      "3. Khi đeo khẩu trang, cần tránh chạm tay vào phần mặt bên trong của khẩu trang, vì có thể sẽ bị lây nhiễm vi khuẩn từ tay với phần tiếp xúc với mũi và miệng \n"
                      "4. Đeo quai khẩu vòng quanh tai \n"
                      "5. Nếu khẩu trang có dây buộc, hãy vòng dây qua sau đầu và buộc chặt theo hình chiếc nơ để cố định khẩu trang \n"
                      "6. Khi khẩu trang được đặt đúng vị trí, sử dụng ngón trỏ và ngón cái của bạn để kẹp điều chỉnh và uốn cong gọng cứng theo bề mặt mũi và khuôn mặt \n"
                      "7. Hãy chắc chắn rằng khẩu trang đã che hoàn toàn mũi và miệng của bạn và cạnh dưới thì nằm dưới cằm \n"
                      "8. Khi tháo khẩu trang, chỉ nên chạm vào phần dây đeo qua tai, không nên chạm vào mặt có màu của khẩu trang, để hạn chế nguy cơ lây nhiễm virus từ tay. \n"
                      "9. Khẩu trang y tế chỉ sử dụng một lần. Hãy bỏ khẩu trang sau khi sử dụng vào thùng rác có nắp đậy \n"
                      "10. Rửa tay với nước và xà phòng ít nhất 20 giây",
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
      ),
    ));
  }
}

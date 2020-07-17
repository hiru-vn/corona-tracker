import 'package:corona_tracker/services/navigate_services.dart';
import 'package:corona_tracker/ui/pages/login_page.dart';
import 'package:corona_tracker/ui/ui_variables.dart';
import 'package:corona_tracker/ui/widgets/info/detail_card.dart';
import 'package:corona_tracker/ui/widgets/info/information_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:corona_tracker/globals.dart' as globals;

class InfoPage extends StatefulWidget {
  @override
  InfoPageSate createState() => InfoPageSate();
}

class InfoPageSate extends State<InfoPage> {
  static List data = [];
  Future<void> fetchUser() async {
    var dio = Dio();
    String baseURL = globals.baseURL + "/user/getInfected";
    var response = await dio.get(baseURL);
    if (response.statusCode == 200) {
      var jsonData = response.data;
      for (var i in jsonData['data']) {
        data.add(i);
      }
      //print(data.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
    // TODO: implement initState
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
//            Container(
//              width: double.infinity,
//              height: 170,
//              padding: const EdgeInsets.symmetric(horizontal: 24),
//              decoration: const BoxDecoration(
//                gradient: LinearGradient(colors: <Color>[
//                    Color.fromRGBO(29, 89, 115, 0.5),
//                  Color.fromRGBO(50, 112, 139, 0),
//                ],begin: Alignment.center,end: Alignment.bottomCenter,
//                ),
//              ),
//              child: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: Container(
//                      height: 40,
//                      padding: const EdgeInsets.only(bottom: 5),
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(40),
//                        color: Color.fromRGBO(255, 255, 255, 0.7)
//                      ),
//                      child: TextFormField(
//                        decoration: InputDecoration(
//                          border: InputBorder.none,
//                          prefixIcon: Icon(Icons.search)
//                        ),
//                      ),
//                    ),
//                  ),
//                    Icon(Icons.notifications,size: 30,)
//                ],
//              ),
//            ),
          Container(
            width: double.infinity,
            height: 280,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color.fromRGBO(29, 89, 115, 0.5),
                  Color.fromRGBO(50, 112, 139, 0),
                ],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 20,
                  left: 50,
                  child: Container(
                      width: 60,
                      height: 52,
                      child: Image.asset('assets/images/virus2.png')),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                      width: 100,
                      height: 100,
                      child: Image.asset('assets/images/virus3.png')),
                ),

                Positioned(
                  right: 0,
                  top: 50,
                  child: Container(
                      width: 60,
                      height: 52,
                      child: Image.asset('assets/images/virus3.png')),
                ),
                // Row(
                //   children: <Widget>[
                //     Expanded(
                //       child: Container(
                //         height: 40,
                //         padding: const EdgeInsets.only(bottom: 5),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(40),
                //             color: const Color.fromRGBO(255, 255, 255, 0.7)),
                //         child: TextFormField(
                //           decoration: InputDecoration(
                //               border: InputBorder.none,
                //               prefixIcon: Icon(Icons.search)),
                //         ),
                //       ),
                //     ),
                //     IconButton(
                //       onPressed: () {
                //         Navigator.pushNamed(context, Views.notificationPage);
                //       },
                //       icon: Icon(Icons.notifications,
                //       size: 30,),
                //     ),
                //   ],
                // ),
                Positioned(
                  top: 20,
                  child: RaisedButton(
                    shape: const RoundedRectangleBorder(),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (Route<dynamic> route) => false);
                    },
                    child: Text(
                      "Đăng xuất",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),

                Positioned(
                  top: 80,
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.8),
                    elevation: 2.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 35, horizontal: 10),
                      width: MediaQuery.of(context).size.width - 50,
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InformationCard(
                            title: "Khu vực",
                            color: Colors.red,
                            detail: "NGUY CƠ CAO",
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const VerticalDivider(
                            width: 4,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InformationCard(
                            title: "F0,F1 đã tiếp xúc ",
                            color: Colors.red,
                            detail: "0",
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const VerticalDivider(
                            width: 4,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: InformationCard(
                              title: "Khả năng lây nhiễm",
                              color: kAbility,
                              detail: "Trung bình",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Cảnh báo",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    RaisedButton(
                      shape: const RoundedRectangleBorder(),
                      onPressed: () {
                        navigatorKey.currentState.pushNamed(Views.qrPage);
                      },
                      child: Text(
                        "Quét QR",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 30, left: 10, right: 5, bottom: 5),
                      width: double.infinity,
                      height: 220,
                      child: new ListView.builder(
                        itemCount: data == null ? 0 : 5,
                        itemBuilder: (BuildContext context, int index) {
                          return SingleChildScrollView(
                              child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.blue[50],
                                  ),
                                  child: DetailCard(
                                    content: data[index]["fullName"],
                                    dateTime: data[index]["address"]["String"],
                                    nameDiner: "",
                                    address: "",
                                  ),
                                ),
                              )
                            ],
                          ));
                        },
                      ),
                    )
                    // child: const DetailCard(
                    //   content: "Có khả năng tiếp xúc với F3",
                    //   dateTime: "Từ 17:12 - 17:17 ngày 20/3",
                    //   nameDiner: "Circle K ",
                    //   address: "Hà Nội",
                    // )),
                    )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

import 'package:corona_tracker/services/navigate_services.dart';
import 'package:corona_tracker/ui/ui_variables.dart';
import 'package:corona_tracker/ui/widgets/info/detail_card.dart';
import 'package:corona_tracker/ui/widgets/info/information_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:corona_tracker/globals.dart' as globals;
import 'package:rflutter_alert/rflutter_alert.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = ScrollController();
  bool isLoading = true;
  List data;
  List stores = [];
  dynamic city;
  List<String> riskStr = [
    "An toàn",
    "Nguy cơ",
    "Nguy cơ cao",
    "Bùng phát dịch",
    "Dịch lan rộng"
  ];
  List<Color> colors = [
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.red,
    Colors.redAccent[700]
  ];
  String searchText = '';

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  Future<dynamic> fetchStore(int id) async {
    try {
      var dio = Dio();
      Response response;
      String baseURL = globals.baseURL + "/store/get";
      var body = {
        "id": id,
      };
      response = await dio.get(baseURL, queryParameters: body);
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          return response.data['data'];
        }
      }
      return null;
    } catch (e) {
      print("false");
      Alert(
        context: context,
        type: AlertType.error,
        title: "có lỗi xảy ra",
        desc: "Vui lòng kiểm tra ke noi mang",
      ).show();
    }
  }

  Future<void> fetchCityData() async {
    try {
      var dio = Dio();
      Response response;
      String baseURL = globals.baseURL + "/city/getAll";
      response = await dio.get(baseURL);
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          setState(() {
            city = (response.data['data'] as List)
                .firstWhere((element) => element["id"] == globals.cityCode);
          });
        }
      }
    } catch (e) {
      print("false");
      Alert(
        context: context,
        type: AlertType.error,
        title: "có lỗi xảy ra",
        desc: "Vui lòng kiểm tra ke noi mang",
      ).show();
    }
  }

  Future<void> fetchData() async {
    try {
      var dio = Dio();
      Response response;
      String baseURL = globals.baseURL + "/user/getRiskEvent";
      var body = {
        "UserId": globals.id,
      };
      response = await dio.get(baseURL, queryParameters: body);
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          final fixedData = (response.data['data'] as List)
              .where((e) =>
                  (e["user1id"] == globals.id &&
                      e["user1infectlevel"] > e["user2infectlevel"]) ||
                  (e["user2id"] == globals.id &&
                      e["user2infectlevel"] > e["user1infectlevel"]))
              .toList();
          if (fixedData.length > 0) {
            globals.risk = fixedData[0]["user1id"] == globals.id
                ? fixedData[0]["user1infectlevel"]
                : fixedData[0]["user2infectlevel"];
          }
          for (int i = 0; i < fixedData.length; i++) {
            final store = await fetchStore(fixedData[i]["storeid"]);
            stores.add(store);
          }
          setState(() {
            data = fixedData;
          });

          print("oke");
        }
      }
    } catch (e) {
      print("false");
      Alert(
        context: context,
        type: AlertType.error,
        title: "có lỗi xảy ra",
        desc: "Vui lòng kiểm tra tài khoản",
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: const Color.fromRGBO(255, 255, 255, 0.7)),
                          child: TextFormField(
                            onFieldSubmitted: (str) {
                              setState(() {
                                searchText = str.trim();
                              });
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search)),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Views.notificationPage);
                        },
                        icon: Icon(
                          Icons.notifications,
                          size: 30,
                        ),
                      ),
                    ],
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
                            Expanded(
                              child: InformationCard(
                                title: "Khu vực",
                                color: city != null
                                    ? colors[city["infectedLevel"]]
                                    : colors[0],
                                detail: city != null
                                    ? riskStr[city["infectedLevel"]]
                                    : riskStr[0],
                              ),
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
                                title: "F0,F1 đã tiếp xúc ",
                                color: Colors.red,
                                detail: data != null
                                    ? data
                                        .where((element) =>
                                            [0, 1].contains(
                                                element["user2infectlevel"]) ||
                                            [0, 1].contains(
                                                element["user1infectlevel"]))
                                        .toList()
                                        .length
                                        .toString()
                                    : "0",
                              ),
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
                                detail: globals.risk != null
                                    ? "F${globals.risk}"
                                    : "Thấp",
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    data != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            controller: _scrollController,
                            //physics: NeverScrollableScrollPhysics(),
                            itemCount: data
                                .where((element) =>
                                    (element["address"] as String)
                                        .contains(searchText) ||
                                    (element["date"]["String"] as String)
                                        .contains(searchText))
                                .toList()
                                .length,
                            itemBuilder: (context, index) {
                              int curRisk = data[index]["user1id"] == globals.id
                                  ? data[index]["user2infectlevel"]
                                  : data[index]["user1infectlevel"];
                              String storeName = stores[index]["name"];
                              String time = data[index]["date"]["String"];
                              String address = data[index]["address"];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Material(
                                  elevation: 2,
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 10,
                                          right: 5,
                                          bottom: 5),
                                      width: double.infinity,
                                      //height: 90,
                                      child: DetailCard(
                                        content: "Có khả năng tiếp xúc với F" +
                                            curRisk.toString(),
                                        dateTime: time ?? '',
                                        nameDiner: storeName ?? '',
                                        address: address??'',
                                      )),
                                ),
                              );
                            },
                          )
                        : SizedBox.shrink()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

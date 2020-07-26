import 'package:corona_tracker/services/navigate_services.dart';
import 'package:corona_tracker/ui/reuseable/spacing_box.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:corona_tracker/globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';

class ListInfectPage extends StatefulWidget {
  @override
  _ListInfectPageState createState() => _ListInfectPageState();
}

class _ListInfectPageState extends State<ListInfectPage> {
  List l_infect = [];
  ScrollController controller = ScrollController();
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () => fetchData());
    super.initState();
  }

  fetchData() async {
    try {
      var dio = Dio();
      Response response;
      Map<String, dynamic> data = {
        "id": globals.id,
      };
      String baseURL = globals.baseURL + "/user/getInfected";
      response = await dio.get(baseURL, queryParameters: data);
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          setState(() {
            l_infect = (response.data['data'] as List).reversed.toList();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () => navigatorKey.currentState.pop(),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("Danh sách bệnh nhân dương tính",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              l_infect.length != 0
                  ? ListView.builder(
                      controller: controller,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0),
                      itemCount: l_infect.length,
                      itemBuilder: (context, index) {
                        int year = int.tryParse(
                                l_infect[index]["yearOfBirth"]["String"]) ??
                            1999;
                        return _notiWidget(
                          title: 'Bệnh nhân số ' + index.toString(),
                          content: 'Địa chỉ: ' +
                              l_infect[index]["address"]["String"],
                          time: l_infect[index]["fullName"] +
                              " - " +
                              (DateTime.now().year - year).toString(),
                        );
                      },
                    )
                  : Center(
                      child: Container(
                          margin: EdgeInsets.only(top: 100),
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator())),
            ],
          ),
        ),
      ),
    );
  }

  Widget _notiWidget(
      {String title, String content, String time, String address}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 3.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.info_outline),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title ?? '',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(time ?? '',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14)),
                        SpacingBox(
                          height: 1,
                        ),
                        Text(
                          content ?? '',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Có lỗi xảy ra'),
          content: Text(url),
        ),
      );
    }
  }
}

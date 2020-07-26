import 'package:corona_tracker/services/navigate_services.dart';
import 'package:corona_tracker/ui/reuseable/spacing_box.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:corona_tracker/globals.dart' as globals;

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List l_noti = [];
  String textSearch = '';
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
      String baseURL = globals.baseURL + "/notify/getByUserid";
      response = await dio.get(baseURL, queryParameters: data);
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          setState(() {
            l_noti = (response.data['data'] as List)
                .where((element) =>
                    (element["content"] as String).contains(textSearch.trim()) ||
                    (element["time"] as String).contains(textSearch.trim()) ||
                    (element["title"] as String).contains(textSearch.trim()))
                .toList();
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
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.only(top: 3),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            setState(() {
                              textSearch = value;
                            });
                            fetchData();
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ListView.builder(
                controller: controller,
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                itemCount: l_noti.length,
                itemBuilder: (context, index) {
                  return _notiWidget(
                    title: l_noti[index]["title"],
                    content: l_noti[index]["content"],
                    time: l_noti[index]["time"],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _notiWidget({String title, String content, String time}) {
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
                      ],
                    ),
                  ),
                ],
              ),
              SpacingBox(
                height: 1,
              ),
              HtmlWidget(
                content ?? '',
                onTapUrl: (url) => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('onTapUrl'),
                    content: Text(url),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

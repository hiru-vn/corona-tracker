import 'package:corona_tracker/json/countries.dart';
import 'package:corona_tracker/services/api.dart';
import 'package:corona_tracker/ui/pages/detailStore.dart';
import 'package:corona_tracker/ui/pages/handwashing.dart';
import 'package:corona_tracker/ui/pages/wearmask.dart';
import 'package:corona_tracker/ui/reuseable/header_appbar.dart';
import 'package:corona_tracker/ui/reuseable/spacing_box.dart';
import 'package:corona_tracker/ui/ui_variables.dart';
import 'package:corona_tracker/ui/widgets/dashboard/counter.dart';
import 'package:corona_tracker/ui/widgets/dashboard/prevent_card.dart';
import 'package:corona_tracker/ui/widgets/dashboard/symtom_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:corona_tracker/globals.dart' as globals;
import 'package:rflutter_alert/rflutter_alert.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DashboardPageWidget();
  }
}

class DashboardPageWidget extends StatefulWidget {
  @override
  _DashboardPageStateWidget createState() => _DashboardPageStateWidget();
}

class _DashboardPageStateWidget extends State<DashboardPageWidget>
    with AutomaticKeepAliveClientMixin {
  final _controller = ScrollController();
  double offset = 0;
  Future<List<Countries>> listCountries;
  List cities = [];
  dynamic selectedCity;

  @override
  void initState() {
    super.initState();
    _controller.addListener(onScroll);
    listCountries = API.fetchData();
    fetchCityData();
    print(globals.id);
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
            cities = (response.data['data'] as List);
            selectedCity = cities[0];
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
  bool get wantKeepAlive => true;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (_controller.hasClients) ? _controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final listItemMenu = <DropdownMenuItem<dynamic>>[];

    // model.listCountries.forEach((item) => {
    //       listItemMenu.add(
    //         DropdownMenuItem<Countries>(
    //           child: Text(item.country),
    //           value: item,
    //         ),
    //       )
    //     });
    cities.forEach((item) {
      listItemMenu.add(
        DropdownMenuItem<dynamic>(
          child: Text(item["name"]),
          value: item,
        ),
      );
    });

    return Scaffold(
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: <Widget>[
            MyHeader(
              image: "assets/icons/Drcorona.svg",
              textTop: "Hãy ở nhà",
              textBottom: "để bảo vệ bản thân\nvà mọi người",
              offset: offset,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: const Color(0xFFE5E5E5),
                ),
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                  const SizedBox(width: 20),
                  Expanded(
                    child: cities.isNotEmpty
                        ? DropdownButton<dynamic>(
                            isExpanded: true,
                            underline: const SizedBox(),
                            icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                            value: selectedCity,
                            items: listItemMenu.toList(),
                            onChanged: (city) {
                              setState(() {
                                selectedCity = city;
                              });
                            },
                          )
                        : const CircularProgressIndicator(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Cập nhật ca nhiễm bệnh\n",
                            style: kTitleTextstyle,
                          ),
                          TextSpan(
                            text:
                                "Cập nhật mới nhất ngày ${DateTime.now().subtract(Duration(days: 1)).day} tháng ${DateTime.now().subtract(Duration(days: 1)).month}",
                            style: TextStyle(
                              color: kTextLightColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    FlatButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailStore(
                          id: 1,
                        );
                      })),
                      child: Text(
                        "Chi tiết",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 30,
                        color: kShadowColor,
                      ),
                    ],
                  ),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Counter(
                            color: kInfectedColor,
                            number: selectedCity != null
                                ? selectedCity["infectedCount"]
                                : 0,
                            title: "Bị lây nhiễm",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Counter(
                            color: kDeathColor,
                            number: selectedCity != null
                                ? selectedCity["criticalCount"]
                                : 0,
                            title: "Tử vong",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Counter(
                            color: kRecovercolor,
                            number: selectedCity != null
                                ? selectedCity["curedCount"]
                                : 0,
                            title: "Bình phục",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Lây lan Virus",
                      style: kTitleTextstyle,
                    ),
                    Text(
                      "Chi tiết",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(0),
                  height: 178,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 30,
                        color: kShadowColor,
                      ),
                    ],
                  ),
                  child: Image.network(
                    "https://i.imgur.com/f9iZ0wB.png",
                    fit: BoxFit.contain,
                  ),
                ),
                const SpacingBox(height: 3),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Triệu chứng",
                      style: kTitleTextstyle,
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const SymptomCard(
                            image: "assets/images/headache.png",
                            title: "Đau đầu",
                            isActive: true,
                          ),
                          const SymptomCard(
                            image: "assets/images/caugh.png",
                            title: "Cảm lạnh",
                          ),
                          const SymptomCard(
                            image: "assets/images/fever.png",
                            title: "Sốt",
                          ),
                        ],
                      ),
                    ),
                    const SpacingBox(height: 3),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Triệu chứng",
                          style: kTitleTextstyle,
                        ),
                        const SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const SymptomCard(
                                image: "assets/images/headache.png",
                                title: "Đau đầu",
                                isActive: true,
                              ),
                              const SymptomCard(
                                image: "assets/images/caugh.png",
                                title: "Cảm lạnh",
                              ),
                              const SymptomCard(
                                image: "assets/images/fever.png",
                                title: "Sốt",
                              ),
                            ],
                          ),
                        ),
                        const SpacingBox(height: 3),
                        Text("Tự bảo vệ bản thân", style: kTitleTextstyle),
                        const SizedBox(height: 20),
                        FlatButton(
                          onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return wearmask();
                          })),
                          child: const PreventCard(
                            text:
                                "Kể từ khi bắt đầu bùng phát coronavirus, một số nơi đã hoàn toàn chấp nhận đeo khẩu trang",
                            image: "assets/images/wear_mask.png",
                            title: "Đeo khẩu trang",
                          ),
                        ),
                        FlatButton(
                          onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MyApp();
                          })),
                          child: const PreventCard(
                            text:
                                "Rửa tay để bảo vệ bản thân, rửa tay mỗi khi đến chỗ lạ",
                            image: "assets/images/wash_hands.png",
                            title: "Rửa tay",
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

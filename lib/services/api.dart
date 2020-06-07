import 'package:corona_tracker/json/countries.dart';
import 'package:dio/dio.dart';

class API {
  static Future<List<Countries>> fetchData() async {
    List<Countries> arrCountries = [];
    var dio = Dio();
    const  baseURL = "https://corona.lmao.ninja/v2/countries";
    var res = await dio.get(baseURL);
    if (res.statusCode == 200) {
      var jsonData = res.data;
      for(var i in jsonData) {
        final countries = Countries(
          cases: i['cases'],
          country: i['country'],
          active: i['active'],
          critical: i['critical'],
          todayCases: i['todayCases'],
          recovered: i['recovered'],
          deaths: i['deaths'],
          todayDeaths: i['todayDeaths'],
        );
        arrCountries.add(countries);
      }
    }
    return arrCountries;
  }
}

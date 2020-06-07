import 'package:dio/dio.dart';

class API {
  static loginapi(String name, int number, String email, String password) async {
    var dio = Dio();
    const  baseURL = "https://localhost:3000/user/sign-up";
    var data = {
      
    };
    var res = await dio.post(baseURL);
  }
}

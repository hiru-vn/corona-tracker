import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:corona_tracker/json/address.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:corona_tracker/globals.dart' as globals;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  var _emailErr ='Email đăng kí không hợp lệ';
  bool emailinvalid = false;
  TextEditingController _passController = new TextEditingController();
  var _passwordErr ='Mật khẩu phải dài hơn 6 kí tự';
  bool passinvalid = false;
  TextEditingController _confirmpassController = new TextEditingController();
  var _confimErr = 'Xác nhận mật khẩu sai';
  bool confiminvalid = false;
  TextEditingController _phoneController = new TextEditingController();
  var _phoneErr ='Số điện thoại phải 10 số';
  bool phoneinvalid =false;
  TextEditingController _tinhthanhphoController = new TextEditingController();
  TextEditingController _tamtruController = new TextEditingController();
  DateTime _dateTime;
  final List<Map> _addressVn = AddressVn.getJsonData();
  String _mySelection;
  bool isRegister = true;
  String cityCode;

  get parsedJson => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            constraints: BoxConstraints.expand(),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                    child: Text(
                      "Chào mừng bạn đến với Corona-tracker",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text("Đăng kí để sử dụng tính năng"),
                  ),
                  Container(
                    height: 400,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                            child: TextField(
                              controller: _nameController,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              decoration: InputDecoration(
                                  labelText: "Họ tên",
                                  labelStyle: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6)))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            child: TextField(
                              controller: _emailController,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  errorText: emailinvalid ? _emailErr : null,
                                  labelStyle: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6)))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _phoneController,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              decoration: InputDecoration(
                                  labelText: "Số điện thoai",
                                  errorText: phoneinvalid? _phoneErr : null,
                                  labelStyle: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6)))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              obscureText: true,
                              controller: _passController,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              decoration: InputDecoration(
                                  labelText: "Mật khẩu",
                                  errorText: passinvalid?_passwordErr:null,
                                  labelStyle: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6)))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              obscureText: true,
                              controller: _confirmpassController,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              decoration: InputDecoration(
                                  labelText: "Xác nhận mật khẩu",
                                  errorText: confiminvalid?_confimErr:null,
                                  labelStyle: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6)))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 60,
                              width: 350,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: DropdownButton(
                                    isExpanded: true,
                                    hint: _mySelection == null
                                        ? Text("Chọn tỉnh/thành phố")
                                        : Text(_mySelection),
                                    isDense: true,
                                    items: _addressVn.map((Map map) {
                                      return new DropdownMenuItem<String>(
                                        value: map["pn"].toString(),
                                        child: Text(map["pn"]),
                                      );
                                    }).toList(),
                                    onChanged: (String newValue) {
                                      onChange(newValue);
                                    },
                                    underline: const SizedBox(),
                                  ))
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _tamtruController,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              decoration: InputDecoration(
                                  labelText: "Nhập địa chỉ tạm trú của bạn",
                                  labelStyle: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6)))),
                            ),
                          ),
                          Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 300,
                          height: 52,
                          child: RaisedButton(
                            child: Text(( _dateTime==null)?'Chọn ngày sinh': "Ngày sinh:" +_dateTime.day.toString() +"/"+
                            _dateTime.month.toString() +"/"+ _dateTime.year.toString(),
                            style: TextStyle(color: Colors.white),),
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: _dateTime == null
                                          ? DateTime.now()
                                          : _dateTime,
                                      firstDate: DateTime(1980),
                                      lastDate: DateTime(2021))
                                  .then((date) {
                                setState(() {
                                  _dateTime = date;
                                });
                              });
                            },
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6))),
                          ),
                        ),
                      )
                    ],
                  ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                    child: SizedBox(
                      width: 250,
                      height: 52,
                      child: RaisedButton(
                        onPressed: _onClickRegister,
                        child: Text(
                          "Đăng kí",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        color: Color(0xff3277D8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                      ),
                    ),
                  ),                 
                ],
              ),
            )));
  }

  void onChange(String mySelection) {
    setState(() {
      _mySelection = mySelection;
    });
  }

  void checkVariable()
  {
    setState(() {
      Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if(!regex.hasMatch(_emailController.text.toString()) || _emailController.text.length<6)
      {
        emailinvalid = true;
      }
      else emailinvalid = false;

      if(_passController.text.length<6)
      passinvalid = true;
      else passinvalid = false;

      if(_confirmpassController.text.toString()!=_passController.text.toString())
      confiminvalid=true;
      else confiminvalid = false;
      if(_phoneController.text.length!=10)
      phoneinvalid = true;
      else phoneinvalid = false;
    });
  }

  void _onClickRegister() async {
    checkVariable();
    try{
      var dio = Dio();
    Response response;
    String baseURL = globals.baseURL+"/user/sign-in";
    var data =
    {
      "username" : _emailController.text,
      "password" : _passController.text
    };
    response = await dio.post(baseURL, data:data);
    if(response.statusCode==200)
    {
      Alert(
          context: context,
          type: AlertType.error,
          title: "Đăng kí thất bại",
          desc: "Tài khoản đã tồn tại",
        ).show();
    }
    }
    catch(e){ 
      var dio = Dio();
      Response response;
      String baseURL = globals.baseURL+"/user/sign-up";
      var data = 
      {
      "fullname": _nameController.text,
      "username" : _emailController.text,
      "password" : _passController.text
      };
      response = await dio.post(baseURL, data: data);
      globals.id = response.data['data']['id'];
      updateForUser();
      
    }
  }
  void updateForUser() 
  async{
    String cityCode;
    switch (_mySelection) {
      case "Thành phố Cần Thơ": cityCode = "92";
      break;
      case "Thành phố Hà Nội" :cityCode = "1";     
      break;
      case "Thành phố Hải Phòng": cityCode = "31";
      break;
      case "Thành phố Hồ Chí Minh" :cityCode = "79";     
      break;
      case "Thành phố Đà Nẵng": cityCode = "48";
      break;
      case "Tỉnh An Giang" :cityCode = "89";     
      break;
      case "Tỉnh Bà Rịa - Vũng Tàu": cityCode = "77";
      break;
      case "Tỉnh Bình Dương" :cityCode = "74";     
      break;
        break;
      default:
    }
    print(_tinhthanhphoController.text);
    var dio = Dio();
    Response response;
    String baseURL = globals.baseURL+"/user/update";
    var data =
    {
      "id" : globals.id,
      "phone" : _phoneController.text,
      "yearOfBirth" : _dateTime.year,
      "cityCode" : cityCode,
      "address" : _tamtruController.text
    };
    print(data.toString());
    response = await dio.post(baseURL, data:data);
    print(response.data.toString());
  }
}

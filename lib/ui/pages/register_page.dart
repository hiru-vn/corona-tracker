import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:corona_tracker/json/address.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  final List<Map> _addressVn = AddressVn.getJsonData();
  String _mySelection, _mySelectionWn, _mySelectionDn;
  bool choosedn = false;
  bool choosepn = false;

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
                    padding: const EdgeInsets.fromLTRB(10, 40, 0, 0),
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              decoration: InputDecoration(
                                  labelText: "Email",
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              decoration: InputDecoration(
                                  labelText: "Số điện thoai",
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              decoration: InputDecoration(
                                  labelText: "Mật khẩu",
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
                                    hint: _mySelection==null ?  Text("Chọn tỉnh/thành phố") : Text(_mySelection),
                                    isDense: true,
                                    items: _addressVn.map((Map map) {
                                      return new DropdownMenuItem<String>(
                                        value: map["pn"].toString(),
                                        child: Text(map["pn"]),
                                      );
                                    }).toList(),
                                    onChanged: (String newValue)
                                    {
                                      onChange(newValue);
                                    },
                                    underline: const SizedBox(),
                                  )
                                )
                                ],
                              ),
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
                                    hint: new Text("Chọn quận huyện"),
                                    isDense: true,
                                    value: _mySelection,
                                    items: null,
                                    onChanged: null,
                                    underline: const SizedBox(),
                                  )
                                )
                                ],
                              ),
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
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      hint: new Text("Chọn xã, thị trấn"),
                                      items: _addressVn.map((Map map) {
                                        return new DropdownMenuItem<String>(
                                          value: map.toString(),
                                          child: Text(map["pn"].toString()),
                                        );
                                      }).toList(),
                                      onChanged: null,
                                      underline: const SizedBox(),
                                    ),
                                  )
                                ],
                              ),
                            ),
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
                        onPressed: clickSignup,
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
  void onChange(String mySelection)
  {
    setState(() {
      _mySelection = mySelection;
      choosepn = true;
    });
  }

  void onChangews(String _mySelectionWs)
  {
    setState(()
    {
        if(_mySelection==null || _mySelection =="Chọn tỉnh/thành phố")
        {
          
        }
    });
  }
  void clickSignup()
  {
    
  }
}
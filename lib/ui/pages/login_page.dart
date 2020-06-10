import 'package:corona_tracker/ui/pages/register_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';




class LoginPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<LoginPage> {

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Image.asset('assets/images/logo.png', width: 150, height: 150, fit: BoxFit.fill),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                      "Chào mừng bạn \nĐến với Corona-tracker!",
                      style: TextStyle(fontSize:25, color: Color(0xff333333),fontWeight: FontWeight.bold),
                    ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,30,0,0),
                child: Text(
                  "Đăng nhập để sử dụng tính năng",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: StreamBuilder(
                    builder: (context, snapshot) => TextField(
                          controller: _emailController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Email",
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              prefixIcon: Container(
                                  width: 50, child: Image.asset("")),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)))),
                        )),
              ),
              StreamBuilder(
                  builder: (context, snapshot) => TextField(
                        controller: _passController,
                        obscureText: true,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                            errorText:
                                snapshot.hasError ? snapshot.error : null,
                            labelText: "Password",
                            prefixIcon: Container(
                                width: 50, child: Image.asset("")),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black,width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)))),
                      )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                child: SizedBox(
                  width: 250,
                  height: 52,
                  child: RaisedButton(
                    onPressed: clickSignin,
                    child: Text(
                      "Đăng nhập",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Color(0xff3277D8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: RichText(
                  text: TextSpan(
                      text: "Bạn chưa có tài khoản? ",
                      style: TextStyle(color: Colors.black,fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Đăng kí",
                            style: TextStyle(
                                color: Color(0xff3277D8), fontSize: 16),
                            recognizer: new TapGestureRecognizer()..onTap=()=>{
                              Navigator.push(context, MaterialPageRoute(builder: (context){ return RegisterPage();}))
                            }),
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  // void clicksignup()
  // {
  //   loginapi(_nameController.text,_phoneController.text,_emailController.text,_passController.text);
  // }
  // static loginapi(String name, String phonenumber, String email, String password) async {
  //   var dio = Dio();
  //   final  baseURL = 'https://127.0.0.1:3000/user/sign-up';
  //   var data = {
  //     "fullname" : email,
  //     "username" : name,
  //     "password" : password,
  //   };
  //   try {
  //     var res = await dio.post(baseURL,data: data);
  //     print(res);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

void clickSignin()
{
  setState((){
    
    });
}



  // void clicksignup()
  // {
  //   loginapi(_nameController.text,_phoneController.text,_emailController.text,_passController.text);
  // }
  // void loginapi(String name, String phonenumber, String email, String password) async {
  //   print(name);
  //   var dio = Dio();
  //   Response response;
  //   const  baseURL = "http://127.0.0.1:3000/user/sign-up";
  //   var data = {
  //     "fullName": "sadsadsadassdawqfsa",
	//     "username": "hahasad.com",
	//     "password": "password123123"
    
  //   };
  //   response = await dio.post(baseURL,data: data)  ;
  //   print(response.data.toString());
  // }
}
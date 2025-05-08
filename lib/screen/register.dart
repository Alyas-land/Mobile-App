import 'package:flutter/material.dart';
import '../widgets/staticWidgets/navigationBottom.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../session/sessionStatus.dart';

import '../screen/infoAccount.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  String result = "";
  String? errorUsername = null;
  String? errorPassword = null;
  Color color = Colors.blueAccent;
  int bottomNavigationSelector = 0;
  action(index){
    setState(() {
      if (index == 0){
        bottomNavigationSelector = 0;
      }

    });
  }

  Future<void> loginUser(String username, String password, BuildContext context) async{
    final response = await http.post(
        Uri.parse('http://192.168.6.91:5000/api/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        })
    );

    final user_id = jsonDecode(response.body);

    print('+++++++++++++++++ Response body: ${response.body} +++++++++++++++++');
    print('+++++++++++++++++ Status code: ${response.statusCode} +++++++++++++++++');
    print("+++++++++++++++++ Status code: $user_id['id'] +++++++++++++++++");

    final Map<String, dynamic> data = jsonDecode(response.body);
    globalUserId = data['id'];
    print("+++++++++++++++++ Status code: $globalUserId +++++++++++++++++");

    // final resultData = jsonDecode(response.body);
    if (response.statusCode == 200){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InfoAcountPage(userId: globalUserId)),
      );
    } else if (response.statusCode == 400) {
      print('&&&&&&&&&&&&&&& Status code: ${response.statusCode} &&&&&&&&&&&&&&&');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFF0C2D48),

            title: Text("خطا",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFFFF8B48)
              ),
            ),
            content: Text("نام کاربری یا رمز عبور اشتباه است.",
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  color: Color(0xFFE16C6C)
              ),
            ),
            actions: [
              TextButton(
                child: Center(child: Text("بستن",
                  style: TextStyle(
                      color: Color(0xFF6CE183)
                  ),
                )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }



  }

  bool checkUserPassFormating(String input){
    final regex = RegExp(r"^[a-zA-Z0-9]{4,}$");
    if (regex.hasMatch(input)){
      return true;
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
          fontFamily: "Irancell"
      ),
      home: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, 0), // near the top right
              radius: 0.8,
              colors: <Color>[
                Color(0xFF145DA0), //  sun
                Color(0xFF0C2D48), //  sky
              ],
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Center
            (child: Text("Hex Arena",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
          ),
            backgroundColor: Color(0xFF0C2D48),
          ),

          body: Container(

            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Column(
                      children: [
                        Image(image: AssetImage('assets/img/game-vector.png'),
                          width: 300,
                          height: 120,
                        ),

                        Center(
                          child: Text("ساخت حساب کاربری",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ]
                  ),
                ),

                Container(

                  margin: EdgeInsets.fromLTRB(50, 10, 50, 1),
                  child: TextField(
                    textAlign: TextAlign.right,
                    controller: username,
                    decoration: InputDecoration(
                      errorText: errorUsername,
                      hintText: "نام و نام خانوادگی",
                      hintStyle: TextStyle(
                          color: Color(0x42FFFFFF),
                          fontSize: 13,
                          fontWeight: FontWeight.w400
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),

                      // border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),
                      //   borderSide: BorderSide(color: Color(0xFFFFFFFF), width: 2.0
                      //   ),
                      // ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0x82FFFFFF),
                            width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Color(0x42FFFFFF),
                          width: 1.5,
                        ),
                      ),
                      // fillColor: Color(0x3BFFFFFF),
                      // filled: true,

                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(50, 10, 50, 1),
                  child: TextField(

                    textAlign: TextAlign.right,
                    controller: username,
                    decoration: InputDecoration(
                      errorText: errorUsername,
                      hintText: "شماره تلفن",
                      hintStyle: TextStyle(
                          color: Color(0x42FFFFFF),
                          fontSize: 13,
                          fontWeight: FontWeight.w400
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                      // border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),
                      //   borderSide: BorderSide(color: Color(0xFFFFFFFF), width: 2.0
                      //   ),
                      // ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0x82FFFFFF),
                            width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Color(0x42FFFFFF),
                          width: 1.5,
                        ),
                      ),
                      // fillColor: Color(0x3BFFFFFF),
                      // filled: true,

                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(50, 10, 50, 1),
                  child: TextField(
                    textAlign: TextAlign.right,
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "ایمیل",
                      hintStyle: TextStyle(
                          color: Color(0x42FFFFFF),
                          fontSize: 13,
                          fontWeight: FontWeight.w400
                      ),

                      errorText: errorPassword,
                      contentPadding: EdgeInsets.fromLTRB(20, 1, 10, 1),
                      // border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),
                      //   borderSide: BorderSide(color: Color(0xFFFFFFFF), width: 2.0
                      //   ),
                      // ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0x82FFFFFF),
                            width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Color(0x42FFFFFF),
                          width: 1.5,
                        ),
                      ),
                      // fillColor: Color(0x3BFFFFFF),
                      // filled: true,
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(50, 10, 50, 1),
                  child: TextField(

                    textAlign: TextAlign.right,
                    controller: username,
                    decoration: InputDecoration(
                      errorText: errorUsername,
                      hintText: "نام کاربری",
                      hintStyle: TextStyle(
                          color: Color(0x42FFFFFF),
                          fontSize: 13,
                          fontWeight: FontWeight.w400
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 1, 10, 1),
                      // border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),
                      //   borderSide: BorderSide(color: Color(0xFFFFFFFF), width: 2.0
                      //   ),
                      // ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0x82FFFFFF),
                            width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Color(0x42FFFFFF),
                          width: 1.5,
                        ),
                      ),


                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(50, 10, 50, 1),
                  child: TextField(

                    textAlign: TextAlign.right,
                    controller: username,
                    decoration: InputDecoration(
                      errorText: errorUsername,
                      hintText: "رمز عبور",
                      hintStyle: TextStyle(
                          color: Color(0x42FFFFFF),
                          fontSize: 13,
                          fontWeight: FontWeight.w400
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 1, 10, 1),
                      // border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),
                      //   borderSide: BorderSide(color: Color(0xFFFFFFFF), width: 2.0
                      //   ),
                      // ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0x82FFFFFF),
                            width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Color(0x42FFFFFF),
                          width: 1.5,
                        ),
                      ),
                      // fillColor: Color(0x3BFFFFFF),
                      // filled: true,

                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(50, 10, 50, 1),
                  child: TextField(

                    textAlign: TextAlign.right,
                    controller: username,
                    decoration: InputDecoration(
                      errorText: errorUsername,
                      hintText: "تکرار رمز عبور",
                      hintStyle: TextStyle(
                          color: Color(0x42FFFFFF),
                          fontSize: 13,
                          fontWeight: FontWeight.w400
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 1, 10, 1),
                      // border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),
                      //   borderSide: BorderSide(color: Color(0xFFFFFFFF), width: 2.0
                      //   ),
                      // ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0x82FFFFFF),
                            width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Color(0x42FFFFFF),
                          width: 1.5,
                        ),
                      ),
                      // fillColor: Color(0x3BFFFFFF),
                      // filled: true,

                    ),
                  ),
                ),


                Container(
                  margin: EdgeInsets.fromLTRB(50, 40, 50, 1),
                  child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      color: Color(0x5C00D0FF),
                      child: Text("ثبت نام",
                        style: TextStyle(color: Color(0xFFD3FFDD)),),

                      onPressed: (){
                        // setState(() {
                        //   errorUsername = null;
                        //   if (!checkUserPassFormating(username.text)){
                        //     errorUsername = "فرمت نام کاربری صحیح نمی باشد.";
                        //   }
                        //
                        //   errorPassword = null;
                        //   if (!checkUserPassFormating(password.text)){
                        //     errorPassword = "فرمت رمز عبور صحیح نمی باشد.";
                        //   }
                        //
                        //   else if (username.text == "admin" && password.text == "12345"){
                        //     isLoggedIn = true;
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) => ProductsPage()),
                        //     );
                        //     color = Colors.blueAccent;
                        //     result = "Welcome";
                        //
                        //   }
                        //   else {
                        //     result = "Error";
                        //     color = Colors.redAccent;
                        //     }
                        //
                        //
                        // });
                        loginUser(username.text, password.text, context);
                      }),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 50),
                  child: Center(child: Text(result,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  ),
                ),

              ],
            ),
          ),
          bottomNavigationBar: MyNavigationBottomBar(InitializeIndex: 0,),
        ),
      ),
    );
  }
}

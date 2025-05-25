import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../session/sessionStatus.dart';
import '../screen/infoAccount.dart';
import '../serverConfiguration/serverAddress.dart';
import '../widgets/staticWidgets/floatingActionButton.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  TextEditingController name = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confrimPassword = new TextEditingController();
  String result = "";
  String? errorText = null;
  String? errorPhoneNumber = null;
  String? errorEmail = null;
  String? errorUsername = null;
  String? errorPassword = null;
  String? errorConfrimPassword = null;

  Color color = Colors.blueAccent;
  int bottomNavigationSelector = 0;
  action(index){
    setState(() {
      if (index == 0){
        bottomNavigationSelector = 0;
      }

    });
  }

  Future<void> RegisterUser({required name, required phoneNumber, required email, required username, required password, required BuildContext context}) async{
    final response = await http.post(
        Uri.parse('$server/api/user/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'phone_number': phoneNumber,
          'email': email,
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
      final Map<String, dynamic> data = jsonDecode(response.body);
      globalUserId = data['userId'];
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => InfoAcountPage(userId: globalUserId),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );

            return FadeTransition(
              opacity: curvedAnimation,
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 1500),
        ),
      );
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => InfoAcountPage(userId: globalUserId)),
      // );
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

  String checkREGInput({required name, required phoneNumber, required email, required username, required password}){

    final nameRegex = RegExp(r"^[آ-یA-Za-z]{3,}(?: [آ-یA-Za-z]+)*$");
    final phoneNumberRegex = RegExp(r"^09\d{9}$");
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    final usernameRegex = RegExp(r"^[a-zA-Z0-9_]{4,}$");
    final passwordRegex = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$");

    if (!nameRegex.hasMatch(name)){
      return 'فرمت نام درست نمی باشد';
    }
    if (!phoneNumberRegex.hasMatch(phoneNumber)){
      return 'فرمت شماره تلفن درست نمی باشد';
    }
    if (!emailRegex.hasMatch(email)){
      return 'فرمت ایمیل درست نمی باشد';
    }
    if (!usernameRegex.hasMatch(username)){
      return 'فرمت نام کاربری درست نمی باشد';
    }
    if (!passwordRegex.hasMatch(password)){
      return 'فرمت رمز عبور درست نمی باشد';
    }

      return 'ok';

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
                Color(0xFF263375), //  sun
                Color(0xFF0A0E21), //  sky
              ],
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Text("ساخت حساب",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
            centerTitle: true,
            backgroundColor: Color(0xFF0A0E21),
          ),

          body: Container(

            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Column(
                      children: [
                        Image(image: AssetImage('assets/img/new-logo-blue.png'),
                          width: 300,
                          height: 120,
                        ),

                        // Center(
                        //   child: Text("ساخت حساب کاربری",
                        //     style: TextStyle(
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.bold,
                        //       color: Color(0xFFFFFFFF),
                        //     ),
                        //   ),
                        // ),
                      ]
                  ),
                ),

                Container(

                  margin: EdgeInsets.fromLTRB(50, 10, 50, 1),
                  child: TextField(
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Color(0xFFCFF4FC)),
                    controller: name,
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
                    style: TextStyle(color: Color(0xFFCFF4FC)),
                    controller: phoneNumber,
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
                    style: TextStyle(color: Color(0xFFCFF4FC)),
                    controller: email,
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
                    style: TextStyle(color: Color(0xFFCFF4FC)),
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
                    style: TextStyle(color: Color(0xFFCFF4FC)),
                    controller: password,
                    obscureText: true,
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
                    style: TextStyle(color: Color(0xFFCFF4FC)),
                    controller: confrimPassword,
                    obscureText: true,
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
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(width: 2,
                            color: Color(0xFF70BFFF),)
                      ),
                      color: Color(0xFF164A74),
                      child: Text("ثبت نام",
                        style: TextStyle(color: Color(0xFFD3FFDD)),),

                      onPressed: (){
                        setState(() {
                          result = '';
                          final responseCheckText = checkREGInput(
                            name: name.text,
                            phoneNumber: phoneNumber.text,
                            email: email.text,
                            username: username.text,
                            password: password.text,
                          );

                          if (responseCheckText == 'ok'){
                            if (password.text == confrimPassword.text){
                              RegisterUser(
                                name: name.text,
                                phoneNumber: phoneNumber.text,
                                email: email.text,
                                username: username.text,
                                password: password.text,
                                context: context

                              );
                            }
                          }

                          else {
                            result = '';
                            result = responseCheckText;
                            color = Colors.redAccent;
                          }
                        });


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
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: MyFloatingActionButton()
          // bottomNavigationBar: MyNavigationBottomBar(InitializeIndex: 0,),
        ),
      ),
    );
  }
}

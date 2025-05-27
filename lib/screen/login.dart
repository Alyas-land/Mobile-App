import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice2/screen/profile.dart';
import 'package:practice2/screen/registerWithProfile.dart';
import 'dart:convert';
import 'package:practice2/session/sessionStatus.dart';
import '../screen/infoAccount.dart';
import '../serverConfiguration/serverAddress.dart';
import '../widgets/staticWidgets/floatingActionButton.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        Uri.parse('$server/api/user/login'),
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
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => ProfilePage(userId: globalUserId),
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
          transitionDuration: Duration(milliseconds: 400),
        ),
      );
      // Navigator.push(
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
          appBar: AppBar(title: Text("ورود به حساب",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
            centerTitle: true,
            backgroundColor: Color(0xFF0A0E21),),



          body: Container(

            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Column(
                      children: [
                        Image(image: AssetImage('assets/img/new-logo-blue.png'),
                          width: 300,
                          height: 150,
                        ),

                        // Center(
                        //   child: Text("ورود به حساب کاربری",
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

                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFFCFF4FC)),
                    controller: username,
                    decoration: InputDecoration(
                      errorText: errorUsername,
                      hintText: "نام کاربری",
                      hintStyle: TextStyle(
                          color: Color(0x9EFFFFFF),
                          fontSize: 16,
                          fontWeight: FontWeight.w400
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 1, 20, 1),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(color: Color(0xFFFFFFFF), width: 2.0
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: Color(0xFFFFFFFF),
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: Color(0x9E0084FF),
                          width: 1.5,
                        ),
                      ),
                      fillColor: Color(0x3BFFFFFF),
                      filled: true,

                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(50, 20, 50, 1),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: password,
                    style: TextStyle(color: Color(0xFFCFF4FC)),
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "رمز عبور",
                      hintStyle: TextStyle(
                          color: Color(0x9EFFFFFF),
                          fontSize: 16,
                          fontWeight: FontWeight.w400
                      ),

                      errorText: errorPassword,
                      contentPadding: EdgeInsets.fromLTRB(20, 1, 20, 1),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(color: Color(0xFFFFFFFF), width: 2.0
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: Color(0xFFFFFFFF),
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: Color(0x9E0084FF),
                          width: 1.5,
                        ),
                      ),
                      fillColor: Color(0x3BFFFFFF),
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(50, 20, 50, 1),
                  child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          side: BorderSide(width: 2,
                            color: Color(0xFF70BFFF),)
                      ),
                      color: Color(0xFF164A74),
                      child: Text("ورود",
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
                  margin: EdgeInsets.fromLTRB(50, 20, 50, 1),
                  child: MaterialButton(

                      child: Text("حساب کاربری ندارید؟ ثبت نام",
                        style: TextStyle(
                            color: Color(0xFF5CE1E6),
                        ),),

                      onPressed: (){
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => RegisterPageWithProfile(),
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
                            transitionDuration: Duration(milliseconds: 400),
                          ),
                        );
                        // Navigator.push(context,
                        //   MaterialPageRoute(builder: (builder) => RegisterPage()));
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

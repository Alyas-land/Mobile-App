import 'package:flutter/material.dart';

void main() {
  runApp(const MyShop());
}

class MyShop extends StatefulWidget {
  const MyShop({super.key});

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
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
            (child: Text("هکس آرنا",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
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
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Column(
                    children: [
                      Image(image: AssetImage('assets/img/game-vector.png'),
                      width: 300,
                        height: 150,
                      ),

                      Center(
                        child: Text("ورود به حساب کاربری",
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

                    textAlign: TextAlign.center,
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
                      padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))
                      ),
                      color: Color(0xFF0C2D48),
                      child: Text("ارسال",
                      style: TextStyle(color: Colors.white),),

                      onPressed: (){
                        setState(() {
                          errorUsername = null;
                          if (username.text.length < 3){
                            errorUsername = "فرمت نام کاربری درست نمی باشد";
                          }

                          errorPassword = null;
                          if (password.text.length < 4){
                            errorPassword = "رمز عبور باید بیشتر از 4 کاراکتر باشد.";
                          }

                          else if (username.text == "admin" && password.text == "12345"){
                            color = Colors.blueAccent;
                            result = "Welcome";
                          }
                          else {
                            result = "Error";
                            color = Colors.redAccent;
                            }


                        });
                      }),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
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
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Color(0xFF0C2D48),
              selectedItemColor: Colors.white,
              unselectedItemColor: Color(0xFF7F7F7F),
              items:[
                BottomNavigationBarItem(icon: Icon(Icons.login_sharp,), label: "حساب کاربری"),
                BottomNavigationBarItem(icon: Icon(Icons.home_filled,), label: "خانه"),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_bag,), label: "سبد"),
                // BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: "Acount"),

              ],
              currentIndex: bottomNavigationSelector,
              onTap: action,
            ),
        ),
      ),
    );
  }
}

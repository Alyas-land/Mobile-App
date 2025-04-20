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
      home: Scaffold(
        appBar: AppBar(title: Center
          (child: Text("Khariday App",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),
        ),
        ),
          backgroundColor: Colors.blueAccent,
        ),

        body: Container(

          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                child: Center(
                    child: Text("Login",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(100, 10, 100, 1),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: username,
                  decoration: InputDecoration(
                    errorText: errorUsername,
                    hintText: "Username",
                    contentPadding: EdgeInsets.fromLTRB(20, 1, 20, 1),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular((50))))
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(100, 20, 100, 1),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      errorText: errorPassword,
                      contentPadding: EdgeInsets.fromLTRB(20, 1, 20, 1),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular((50))))
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(100, 20, 100, 1),
                child: MaterialButton(
                    padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    color: Colors.blue,
                    child: Text("Sign in",
                    style: TextStyle(color: Colors.white),),

                    onPressed: (){
                      setState(() {
                        errorUsername = null;
                        if (username.text.length < 3){
                          errorUsername = "Username Format invalidli";
                        }

                        errorPassword = null;
                        if (password.text.length < 4){
                          errorPassword = "Password must bigger than 4 charackter";
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
            backgroundColor: Colors.blueAccent,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            items:[
              BottomNavigationBarItem(icon: Icon(Icons.login_sharp,), label: "Login"),
              BottomNavigationBarItem(icon: Icon(Icons.home_filled,), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag,), label: "Bascket"),
              // BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: "Acount"),

            ],
            currentIndex: bottomNavigationSelector,
            onTap: action,
          ),
      ),
    );
  }
}

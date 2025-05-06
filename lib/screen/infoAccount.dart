import 'package:flutter/material.dart';
import 'package:practice2/screen/login.dart';
import 'package:practice2/session/sessionStatus.dart';
import '../widgets/staticWidgets/navigationBottom.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class InfoAcountPage extends StatefulWidget {
  final userId;

  const InfoAcountPage({super.key, this.userId});


  @override
  State<InfoAcountPage> createState() => _InfoAcountPageState();
}

class _InfoAcountPageState extends State<InfoAcountPage> {
  String name = '';
  String username = '';
  String phoneNumber = '';

  @override
  void initState(){
    super.initState();
    getInfo(widget.userId);
  }

  Future<void> getInfo(id) async{
    final response = await http.get(
      Uri.parse('http://192.168.6.91:5000/api/user/info/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200){
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      setState(() {
        name = data['name'];
        username = data['username'];
        phoneNumber = data['phone_number'];
      });
    } else {
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
            content: Text(data['msg'],
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
              appBar: AppBar(title: Text("حساب کاربری",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
              ),
                centerTitle: true,
                backgroundColor: Color(0xFF0C2D48),
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications, color: Colors.white),
                ),
              ),
              body: Container(
                padding: EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // cards
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF05121C),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(color: Color(0xFF2E8ABF), blurRadius: 5),
                          ],
                        ),
                        margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: Column(
                          children: [

                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              decoration: BoxDecoration(
                                color: Color(0xFF05121C),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(color: Color(0xFFFFFFFF), blurRadius: 1),
                                ],
                              ),
                              margin: EdgeInsets.fromLTRB(40, 40, 40, 2),
                              child: Center(
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    color: Color(0xFF81B5D3),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                              decoration: BoxDecoration(
                                color: Color(0xFF05121C),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(color: Color(0xFFFFFFFF), blurRadius: 1),
                                ],
                              ),
                              margin: EdgeInsets.fromLTRB(40, 50, 40, 2),
                              child: Center(
                                child: Text(
                                  username,
                                  style: TextStyle(
                                    color: Color(0xFF81B5D3),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              decoration: BoxDecoration(
                                color: Color(0xFF05121C),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(color: Color(0xFFFFFFFF), blurRadius: 1),
                                ],
                              ),
                              margin: EdgeInsets.fromLTRB(40, 50, 40, 2),
                              child: Center(
                                child: Text(
                                  phoneNumber,
                                  style: TextStyle(
                                    color: Color(0xFF81B5D3),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.fromLTRB(40, 50, 40, 40),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF0C2D48),
                                ),
                                onPressed: () {
                                  setState(() {
                                    globalUserId = null;
                                    Route route = MaterialPageRoute(builder: (context) => LoginPage());
                                    Navigator.pushReplacement(context, route);
                                  });
                                },
                                icon: Icon(Icons.exit_to_app,
                                  color: Color(0xFFEC565A),
                                ),
                                label: Text("خروج",
                                  style: TextStyle(
                                      color: Color(0xFFEC565A),
                                      fontWeight: FontWeight.w700

                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: MyNavigationBottomBar(InitializeIndex: 0,),
            )
        )
    );
  }
}

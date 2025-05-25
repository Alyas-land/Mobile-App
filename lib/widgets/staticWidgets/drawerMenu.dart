import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:practice2/screen/basketHistory.dart';
import '../../globalVariables/init.dart';
import '../../screen/card.dart';
import '../../serverConfiguration/serverAddress.dart';
import '../../session/sessionStatus.dart';
import '../../screen/login.dart';
import '../../screen/aboutUs.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class MyDrawerMenu extends StatefulWidget {
  const MyDrawerMenu({super.key});

  @override
  State<MyDrawerMenu> createState() => _MyDrawerMenuState();
}

class _MyDrawerMenuState extends State<MyDrawerMenu> {
  String username = '';
  String email = '';
  String profilePitcture = '';

  Future<void> getInfo(id) async {
    final response = await http.get(
      Uri.parse('$server/api/user/info/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    print('in future');

    Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print('yes');
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      setState(() {
        username = data['username'];
        email = data['email'];
        profilePitcture = data['profile_path'];
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFF0C2D48),

            title: Text(
              "خطا",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFFFF8B48)),
            ),
            content: Text(
              data['msg'],
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(color: Color(0xFFE16C6C)),
            ),
            actions: [
              TextButton(
                child: Center(
                  child: Text(
                    "بستن",
                    style: TextStyle(color: Color(0xFF6CE183)),
                  ),
                ),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo(globalUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Drawer(
        backgroundColor: Color(0xFF001334).withOpacity(0.5),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF00225E).withOpacity(0.5),
              ),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: SizedBox(
                        width: 90,
                        height: 90,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network('$server/$profilePitcture',
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null)
                                return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                              return Center(
                                child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Text(
                      username,
                      style: TextStyle(
                        color: Color(0xFF5CE1E6),
                        fontFamily: 'CFN',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                LineAwesomeIcons.shopping_bag,
                color: Color(0xFFABCAFF),
              ),
              title: Text(
                'لیست خریدها',
                style: TextStyle(
                  color: Color(0xFFABCAFF),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              tileColor: indexDrawerSaver == 1 ? Color(0x91284880) : null,

              onTap: () {
                setState(() {
                  indexDrawerSaver = 1;
                });
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder:
                        (context, animation, secondaryAnimation) =>
                            CardsHistory(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      final curvedAnimation = CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      );

                      return FadeTransition(
                        opacity: curvedAnimation,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 1000),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart, color: Color(0xFFABCAFF)),
              title: Text(
                'سبد حرید جاری',
                style: TextStyle(
                  color: Color(0xFFABCAFF),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              tileColor: indexDrawerSaver == 2 ? Color(0x91284880) : null,

              onTap: () {
                setState(() {
                  indexDrawerSaver = 2;
                });
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder:
                        (context, animation, secondaryAnimation) =>
                            BasketPage(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      final curvedAnimation = CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      );

                      return FadeTransition(
                        opacity: curvedAnimation,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 1000),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(LineAwesomeIcons.dove, color: Color(0xFFABCAFF)),
              title: Text(
                'درباره ما',
                style: TextStyle(
                  color: Color(0xFFABCAFF),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              tileColor: indexDrawerSaver == 3 ? Color(0x91284880) : null,

              onTap: () {
                indexDrawerSaver = 3;
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder:
                        (context, animation, secondaryAnimation) =>
                            AboutUsPage(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      final curvedAnimation = CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      );

                      return FadeTransition(
                        opacity: curvedAnimation,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 1000),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                LineAwesomeIcons.alternate_sign_out,
                color: Colors.red,
              ),
              // BorderRadius.circular(),
              title: Text(
                'خروج',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                globalUserId = null;
                // Route route = MaterialPageRoute(builder: (context) => LoginPage());
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder:
                        (context, animation, secondaryAnimation) => LoginPage(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      final curvedAnimation = CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      );

                      return FadeTransition(
                        opacity: curvedAnimation,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 1000),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

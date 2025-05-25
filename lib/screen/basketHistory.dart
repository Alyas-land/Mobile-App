import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:practice2/screen/profile.dart';
import '../session/sessionStatus.dart';
import '../widgets/staticWidgets/drawerMenu.dart';
import '../widgets/staticWidgets/navigationBottom.dart';
import '../serverConfiguration/serverAddress.dart';
import '../widgets/staticWidgets/floatingActionButton.dart';
import 'cardNotActive.dart';

class BasketsList {
  int id;
  String title;
  String createdAt;

  BasketsList({required this.id, required this.title, required this.createdAt});

  factory BasketsList.fromJson(Map<String, dynamic> json) {
    return BasketsList(
      id: json['basket_id'],
      title: json['basket_title'],
      createdAt: json['basket_created_at'],
    );
  }
}

class CardsHistory extends StatefulWidget {
  const CardsHistory({super.key});

  @override
  State<CardsHistory> createState() => _CardsHistoryState();
}

class _CardsHistoryState extends State<CardsHistory> {
  Future<List<BasketsList>> fetchBaskets() async {
    final response = await http.get(
      Uri.parse('$server/api/user/$globalUserId/basket_history'),
    );
    if (response.statusCode == 200) {
      print('object');
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => BasketsList.fromJson(item)).toList();
    } else {
      throw Exception('خطا در دریافت اطلاعات');
    }
  }

  List<BasketsList> basketsList = [];

  Future<void> loadBaskets() async {
    final data = await fetchBaskets();
    setState(() {
      basketsList = data;
    });
  }

  _goToDisplayBasketPage(basketId) {
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => CardsHistory(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );
        return FadeTransition(opacity: curvedAnimation, child: child);
      },
      transitionDuration: Duration(milliseconds: 1000),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBaskets();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Irancell"),
      home: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, 0), // near the top right
            radius: 0.8,
            colors: <Color>[
              Color(0xFF1E295E), //  sun
              Color(0xFF0A0E21), //  sky
            ],
          ),
        ),

        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Image.asset(
              'assets/img/new-logo-blue-edited-appbar.png',
              width: 90,
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Color(0xFF0A0E21),
            actions: [
              Builder(
                builder:
                    (context) => IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    ),
              ),
            ],
            leading: IconButton(
              icon: Icon(
                LineAwesomeIcons.chevron_circle_left,
                color: Color(0xFF5CE1E6),
              ),
              tooltip: 'Open shopping cart',
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder:
                        (context, animation, secondaryAnimation) =>
                        ProfilePage(),
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
          ),

          endDrawer: MyDrawerMenu(),

          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'تاریخچه فعالیت‌ها',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF5CE1E6),
                  ),
                ),

                const SizedBox(height: 30),

                const Divider(
                  endIndent: 40,
                  indent: 40,
                  color: Color(0x915CE1E6),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: 340,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      children: [
                        for (var item in basketsList)
                          Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 30,
                                  right: 25,
                                ),
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  16,
                                  16,
                                  12,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0x8F00BBFF),
                                      Color(0x994B049A),
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Color(0xFF5CE1E6),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${item.title} ${item.id}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF5CE1E6),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'تاریخ: ${item.createdAt ?? 'نامشخص'}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Positioned(
                                right: 0,
                                top: 12,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF4B049A),
                                  ),
                                  child: Icon(
                                    LineAwesomeIcons.gamepad,
                                    color: Color(0xFF5CE1E6),
                                    size: 20,
                                  ),
                                ),
                              ),

                              Positioned(
                                left: 10,
                                top: 10,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (
                                              context,
                                              animation,
                                              secondaryAnimation,
                                            ) => DisplayNotActiveBasketPage(
                                              basketId: item.id,
                                            ),
                                        transitionsBuilder: (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                          child,
                                        ) {
                                          final curvedAnimation =
                                              CurvedAnimation(
                                                parent: animation,
                                                curve: Curves.easeInOut,
                                              );

                                          return FadeTransition(
                                            opacity: curvedAnimation,
                                            child: child,
                                          );
                                        },
                                        transitionDuration: Duration(
                                          milliseconds: 1000,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Icon(
                                      LineAwesomeIcons.eye,
                                      color: Colors.white54,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          bottomNavigationBar: MyNavigationBottomBar(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: MyFloatingActionButton(),
        ),
      ),
    );
  }
}
